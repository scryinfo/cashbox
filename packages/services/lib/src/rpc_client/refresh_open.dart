import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/refresh_open.pbgrpc.dart';

class RefreshOpen {
  ClientChannel _channel;
  RefreshOpenFaceClient _client;
  BasicClientReq _req;
  static RefreshOpen _instance;

  RefreshOpen._internal();

  factory RefreshOpen.get(ConnectParameter parameter,
      String version,
      AppPlatformType platformType,
      String signature,
      String deviceId,
      String cashboxType,
      int requestTime,
      ) {
    if (_instance == null) {
      _instance = RefreshOpen._internal();
      _instance._channel = new ClientChannel(
        parameter.host,
        port: parameter.port,
        options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
            connectionTimeout: Duration(minutes: 1)),
      );
      _instance._client = new RefreshOpenFaceClient(_instance._channel);
      _instance._req = BasicClientReq(
          cashboxVersion: version, platformType: platformType.toEnumString());
    }
    return _instance;
  }

  @visibleForTesting
  set version(String v) => _req.cashboxVersion = v;

  Future<ConnectParameter> refreshCall() async {
    var res = await _client.connectParameter(_req);
    if (res.hasErr()) {
      return null;
    }
    ConnectParameter parameter = new ConnectParameter(
        res.host, res.port.toInt());
    return parameter;
  }

  shutDown() {
    _client = null;
    _channel.shutdown();
    _channel = null;
  }
}
