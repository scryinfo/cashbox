import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/src/client/channel.dart' as $channel;
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/profiler.dart';
import 'package:meta/meta.dart';

$channel.ClientChannel createClientChannel(_ReFreshCall refreshCall) {
  var channel = ClientTransportChannel(_ReFreshParameter(refreshCall));
  return channel;
}

//与服务端连接的参数
class ConnectParameter {
  // [host] can either be a [String] or an [InternetAddress]
  Object host;
  int port;
  ChannelOptions options;

  ConnectParameter(this.host, this.port,
      {this.options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())});
}

typedef _ReFreshCall = Future<ConnectParameter> Function();

//刷新服务端连接参数
class _ReFreshParameter extends Function {
  ConnectParameter? _connectParameter;
  final _ReFreshCall _refreshCall;

  _ReFreshParameter(this._refreshCall);

  ConnectParameter? get connectParameter => _connectParameter;

  void _resetConnectParameter() {
    _connectParameter = null;
  }

  Future<ConnectParameter?> _refreshParameter() async {
    if (_connectParameter != null) {
      return _connectParameter;
    }
    if (_refreshCall != null) {
      _connectParameter = await _refreshCall();
    }
    return _connectParameter;
  }
}

// see: grpc-2.8.0/lib/src/client/channel.dart ClientChannelBase
// 增加功能，当连接出错时，刷新服务地址
@visibleForTesting
class ClientTransportChannel implements $channel.ClientChannel {
  // TODO: Multiple connections, load balancing.
  ClientConnection? _connection;

  bool _isShutdown = false;

  final _ReFreshParameter _refreshParameter;

  ClientTransportChannel(this._refreshParameter);

  Future<ClientConnection> createConnection() async {
    var parameter = _refreshParameter.connectParameter;
    if (parameter == null) {
      await _refreshParameter._refreshParameter();
      parameter = _refreshParameter.connectParameter;
    }
    if (parameter == null) {
      throw Exception("can not get parameter from RefreshParameter");
    }

    return Http2ClientConnection(
        parameter.host, parameter.port, parameter.options);
  }

  @override
  Future<void> shutdown() async {
    if (_isShutdown) return;
    _isShutdown = true;
    if (_connection != null) await _connection!.shutdown();
  }

  @override
  Future<void> terminate() async {
    _isShutdown = true;
    if (_connection != null) await _connection!.terminate();
  }

  Future<ClientConnection> getConnection() async {
    if (_isShutdown) throw GrpcError.unavailable('Channel shutting down.');
    return _connection ??= await createConnection();
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = _ClientCallError(
        method,
        requests,
        options,
        _onConnectionError,
        isTimelineLoggingEnabled
            ? timelineTaskFactory(filterKey: clientTimelineFilterKey)
            : null);
    getConnection().then((connection) {
      if (call.isCancelled) return;
      connection.dispatchCall(call);
    }).catchError(call.onConnectionError);
    return call;
  }

  @visibleForTesting
  ConnectParameter? get connectParameter => _refreshParameter.connectParameter;

  //连接出错时，reset ConnectParameter
  void _onConnectionError(error) {
    if (_connection != null) {
      //不能调用 _connection.shutdown()
      // var t = Future(_connection.shutdown);
      _connection = null;
      _refreshParameter._resetConnectParameter();
    }
  }
}

typedef _ErrorCall = void Function(dynamic);

class _ClientCallError<Q, R> extends ClientCall<Q, R> {
  _ErrorCall _errCall;
  Stream<R>? _stream = null;

  _ClientCallError(ClientMethod<Q, R> method, Stream<Q> requests,
      CallOptions options, _ErrorCall this._errCall,
      [timelineTask])
      : super(method, requests, options, timelineTask);

  // onConnectionError 建立连接时出错的回调，当服务端主动断开时，不会回调。处理不完整
  // @override
  // void onConnectionError(error) {
  //   if (_errCall != null) {
  //     _errCall(error);
  //   }
  //   super.onConnectionError(error);
  // }

  @override
  Stream<R> get response {
    if (_stream == null) {
      var res = super.response;
      _stream = res.handleError((err) {
        if (_errCall != null) {
          _errCall(err);
        }
      });
    }
    return _stream!;
  }
}
