
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/src/client/channel.dart' as $channel;
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/profiler.dart';

ClientTransportChannel createChannel(ConnectParameter parameter, ReFreshCall refreshCall) {
  var refreshParameter = ReFreshParameter(parameter,refreshCall);
  var channel = ClientTransportChannel(refreshParameter);
  return channel;
}

//与服务端连接的参数
class ConnectParameter {
  // [host] can either be a [String] or an [InternetAddress]
  Object host;
  int port;
  ChannelOptions options;

  ConnectParameter(this.host, this.port, {this.options = const ChannelOptions()});
}

typedef ReFreshCall = Future<ConnectParameter> Function(ConnectParameter);

//刷新服务端连接参数
class ReFreshParameter {
  ConnectParameter _connectParameter;
  final ConnectParameter _refreshService;
  final ReFreshCall _refreshCall;
  ReFreshParameter(this._refreshService, this._refreshCall);

  bool _refreshing = false;

  ConnectParameter get connectParameter  => _connectParameter;

  void resetConnectParameter(){
    _connectParameter = null;
  }

  void refreshParameter() async {
    if (_refreshing) {
      return null;
    }
    _refreshing = true;
    if(_refreshCall != null) {
      _connectParameter = await _refreshCall(_refreshService);
    }
    _refreshing = false;
    return;
  }
}

// see: grpc-2.8.0/lib/src/client/channel.dart ClientChannelBase
// 增加功能，当连接出错时，刷新服务地址
class ClientTransportChannel  implements $channel.ClientChannel {
  // TODO(jakobr): Multiple connections, load balancing.
  ClientConnection _connection;

  bool _isShutdown = false;

  final ReFreshParameter _refreshParameter;

  ClientTransportChannel(this._refreshParameter);

  Future<ClientConnection> createConnection() async {
    var parameter = _refreshParameter.connectParameter;
    if(parameter == null) {
      await _refreshParameter.refreshParameter();
      parameter = _refreshParameter.connectParameter;
    }
    if(parameter == null){
      throw Exception("can not get parameter from RefindingParameter");
    }

    return Http2ClientConnection(parameter.host, parameter.port, parameter.options);
  }

  @override
  Future<void> shutdown() async {
    if (_isShutdown) return;
    _isShutdown = true;
    if (_connection != null) await _connection.shutdown();
  }

  @override
  Future<void> terminate() async {
    _isShutdown = true;
    if (_connection != null) await _connection.terminate();
  }

  /// Returns a connection to this [Channel]'s RPC endpoint.
  ///
  /// The connection may be shared between multiple RPCs.
  Future<ClientConnection> getConnection() async {
    if (_isShutdown) throw GrpcError.unavailable('Channel shutting down.');
    return _connection ??= await createConnection();
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = ClientCall(
        method,
        requests,
        options,
        isTimelineLoggingEnabled
            ? timelineTaskFactory(filterKey: clientTimelineFilterKey)
            : null);
    getConnection().then((connection) {
      if (call.isCancelled) return;
      connection.dispatchCall(call);
    }, onError: (err){
      _onConnectionError(err);
      call.onConnectionError(err);
    });
    return call;
  }

  //连接出错时，[freshParameter]
  void _onConnectionError(error) {
    freshParameter();
  }

  //重新取服务地址，重置连接
  void freshParameter(){
    if(_connection != null){
      _connection.shutdown();
      _connection = null;
    }
    _refreshParameter.resetConnectParameter();
    _refreshParameter.refreshParameter();
  }
}