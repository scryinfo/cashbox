import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/refresh.pbgrpc.dart';

class Refresh {
  ClientChannel _channel;
  RefreshFaceClient _client;
  Refresh_RefreshReq _req;
  static Refresh _instance;

  Refresh._internal();

  factory Refresh.get(ConnectParameter parameter, String version,
      AppPlatformType platformType) {
    if (_instance == null) {
      _instance = Refresh._internal();
      _instance._channel = new ClientChannel(
        parameter.host,
        port: parameter.port,
        options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
            connectionTimeout: Duration(minutes: 1)),
      );
      _instance._client = new RefreshFaceClient(_instance._channel);
      _instance._req = Refresh_RefreshReq(
          version: version, appPlatformType: platformType.toEnumString());
    }
    return _instance;
  }

  @visibleForTesting
  set version(String v) => _req.version = v;

  Future<ConnectParameter> refreshCall() async {
    var res = await _client.refresh(_req);
    if (res.hasErr()) {
      return null;
    }
    ConnectParameter parameter = new ConnectParameter(
        res.serviceMeta.host, res.serviceMeta.port.toInt());
    return parameter;
  }

  shutDown() {
    _client = null;
    _channel.shutdown();
    _channel = null;
  }
}
