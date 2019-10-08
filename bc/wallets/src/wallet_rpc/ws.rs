// Copyright 2019 PolkaWorld.

use std::collections::BTreeMap;
use std::fmt::{Debug, Error as FmtError, Formatter};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use std::thread;

use parking_lot::Mutex;
use std::sync::mpsc;
use url::Url;
use log::warn;
use futures::{oneshot, Canceled, Complete, Future};
use jsonrpc_core::request::MethodCall;
use jsonrpc_core::response::{Failure, Output, Success};
use jsonrpc_core::{Error as JsonRpcError, Id, Params, Version};
use jsonrpc_ws_server::ws::{
    Error as WsError, ErrorKind as WsErrorKind, Frame, Handler, Handshake, Message, Request,
    Result as WsResult, Sender,
};
use serde::de::DeserializeOwned;
use serde_json::{self as json, Error as JsonError, Value as JsonValue};

pub type BoxFuture<T, E> = Box<dyn futures::Future<Item = T, Error = E> + Send>;

/// The actual websocket connection handler, passed into the
/// event loop of ws-rs
struct RpcHandler {
    pending: Pending,
    // Option is used here as temporary storage until connection
    // is setup and the values are moved into the new `Rpc`
    complete: Option<Complete<Result<Rpc, RpcError>>>,
    out: Option<Sender>,
    send_tx: mpsc::Sender<Message>,
}

impl RpcHandler {
    fn new(
        out: Sender,
        complete: Complete<Result<Rpc, RpcError>>,
        send_tx: mpsc::Sender<Message>,
    ) -> Self {
        RpcHandler {
            out: Some(out),
            pending: Pending::new(),
            complete: Some(complete),
            send_tx,
        }
    }
}

impl Handler for RpcHandler {
    fn build_request(&mut self, url: &Url) -> WsResult<Request> {
        match Request::from_url(url) {
            Ok(r) => Ok(r),
            Err(e) => Err(WsError::new(WsErrorKind::Internal, format!("{}", e))),
        }
    }
    fn on_error(&mut self, err: WsError) {
        match self.complete.take() {
            Some(c) => match c.send(Err(RpcError::WsError(err))) {
                Ok(_) => {}
                Err(_) => warn!(target: "rpc-client", "Unable to notify about error."),
            },
            None => warn!(target: "rpc-client", "unexpected error: {}", err),
        }
    }
    fn on_open(&mut self, _: Handshake) -> WsResult<()> {
        match (self.complete.take(), self.out.take()) {
            (Some(c), Some(out)) => {
                let res = c.send(Ok(Rpc {
                    out: out,
                    counter: AtomicUsize::new(0),
                    pending: self.pending.clone(),
                }));
                if let Err(_) = res {
                    warn!(target: "rpc-client", "Unable to open a connection.")
                }
                Ok(())
            }
            _ => {
                let msg = format!("on_open called twice");
                Err(WsError::new(WsErrorKind::Internal, msg))
            }
        }
    }
    fn on_message(&mut self, msg: Message) -> WsResult<()> {
        // println!("-----on_message: {:?}", msg);
        let ret: Result<JsonValue, JsonRpcError>;
        let response_id;
        let string = &msg.to_string();
        match json::from_str::<Output>(&string) {
            Ok(Output::Success(Success {
                                   result,
                                   id: Id::Num(id),
                                   ..
                               })) => {
                ret = Ok(result);
                response_id = id as usize;
            }
            Ok(Output::Failure(Failure {
                                   error,
                                   id: Id::Num(id),
                                   ..
                               })) => {
                ret = Err(error);
                response_id = id as usize;
            }
            _ => {
                if let Err(_) = self.send_tx.send(msg) {
                    warn!(target: "rpc-client", "Unable to subscribe send.")
                }
                return Ok(());
            }
        }

        match self.pending.remove(response_id) {
            Some(c) => {
                if let Err(_) = c.send(ret.map_err(|err| RpcError::JsonRpc(err))) {
                    warn!(target: "rpc-client", "Unable to send response.")
                }
            }
            None => warn!(target: "rpc-client", "Unable to send response."),
        }
        Ok(())
    }

    fn on_frame(&mut self, frame: Frame) -> WsResult<Option<Frame>> {
        //let frame1 = String::from_utf8(frame.clone().into_data());
        //println!("-----on_frame------frame:{:?}", frame1);
        Ok(Some(frame))
    }
}

/// Keeping track of issued requests to be matched up with responses
#[derive(Clone)]
struct Pending(Arc<Mutex<BTreeMap<usize, Complete<Result<JsonValue, RpcError>>>>>);

impl Pending {
    fn new() -> Self {
        Pending(Arc::new(Mutex::new(BTreeMap::new())))
    }
    fn insert(&mut self, k: usize, v: Complete<Result<JsonValue, RpcError>>) {
        self.0.lock().insert(k, v);
    }
    fn remove(&mut self, k: usize) -> Option<Complete<Result<JsonValue, RpcError>>> {
        self.0.lock().remove(&k)
    }
}

/// The handle to the connection
pub struct Rpc {
    out: Sender,
    counter: AtomicUsize,
    pending: Pending,
}

impl Rpc {
    /// Blocking, returns a new initialized connection or RpcError
    pub fn new(url: &str, send_tx: mpsc::Sender<Message>) -> Result<Self, RpcError> {
        let rpc = Self::connect(url, send_tx).map(|rpc| rpc).wait()?;
        rpc
    }

    /// Non-blocking, returns a future
    pub fn connect(
        url: &str,
        send_tx: mpsc::Sender<Message>,
    ) -> BoxFuture<Result<Self, RpcError>, Canceled> {
        let (c, p) = oneshot::<Result<Self, RpcError>>();
        let url = String::from(url);
        // The ws::connect takes a FnMut closure, which means c cannot
        // be moved into it, since it's consumed on complete.
        // Therefore we wrap it in an option and pick it out once.
        let mut once = Some(c);
        thread::spawn(move || {
            let conn = jsonrpc_ws_server::ws::connect(url, |out| {
                // this will panic if the closure is called twice,
                // which it should never be.
                let c = once.take().expect("connection closure called only once");
                RpcHandler::new(out, c, send_tx.clone())
            });
            match conn {
                Err(err) => {
                    // since ws::connect is only called once, it cannot
                    // both fail and succeed.
                    let c = once.take().expect("connection closure called only once");
                    let _ = c.send(Err(RpcError::WsError(err)));
                }
                // c will complete on the `on_open` event in the Handler
                _ => (),
            }
        });
        Box::new(p)
    }

    /// Non-blocking, returns a future of the request response
    pub fn request<T>(
        &mut self,
        method: &'static str,
        params: Vec<JsonValue>,
    ) -> BoxFuture<Result<T, RpcError>, Canceled>
        where
            T: DeserializeOwned + Send + Sized,
    {
        let (c, p) = oneshot::<Result<JsonValue, RpcError>>();

        let id = self.counter.fetch_add(1, Ordering::Relaxed);
        self.pending.insert(id, c);

        let request = MethodCall {
            jsonrpc: Some(Version::V2),
            method: method.to_owned(),
            params: Params::Array(params),
            id: Id::Num(id as u64),
        };

        let serialized = json::to_string(&request).expect("request is serializable");
        let _ = self.out.send(serialized);

        Box::new(p.map(|result| match result {
            Ok(json) => {

                let t: T = json::from_value(json)?;
                Ok(t)
            }
            Err(err) => {
                println!("oneshot has a error");
                Err(err)
            },
        }))
    }
}

pub enum RpcError {
    ParseError(JsonError),
    JsonRpc(JsonRpcError),
    WsError(WsError),
    Canceled(Canceled),
}

impl Debug for RpcError {
    fn fmt(&self, f: &mut Formatter) -> Result<(), FmtError> {
        match *self {
            RpcError::ParseError(ref err) => write!(f, "ParseError: {}", err),
            RpcError::JsonRpc(ref json) => write!(f, "JsonRpc error: {:?}", json),
            RpcError::WsError(ref s) => write!(f, "Websocket error: {}", s),
            RpcError::Canceled(ref s) => write!(f, "Futures error: {:?}", s),
        }
    }
}

impl From<JsonError> for RpcError {
    fn from(err: JsonError) -> RpcError {
        RpcError::ParseError(err)
    }
}

impl From<WsError> for RpcError {
    fn from(err: WsError) -> RpcError {
        RpcError::WsError(err)
    }
}

impl From<Canceled> for RpcError {
    fn from(err: Canceled) -> RpcError {
        RpcError::Canceled(err)
    }
}
