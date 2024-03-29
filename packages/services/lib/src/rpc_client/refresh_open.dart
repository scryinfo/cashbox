import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/refresh_open.pbgrpc.dart';

class RefreshOpen {
  ClientChannel? _channel;
  RefreshOpenFaceClient? _client;
  late BasicClientReq _req;
  static RefreshOpen? _instance;

  RefreshOpen._internal();

  factory RefreshOpen.get(
    ConnectParameter parameter,
    String cashboxVersion,
    AppPlatformType platformType,
    String signature,
    String deviceId,
    String cashboxType,
  ) {
    if (_instance == null) {
      _instance = RefreshOpen._internal();
      _instance!._channel = new ClientChannel(
        parameter.host,
        port: parameter.port,
        options: ChannelOptions(
            credentials: ChannelCredentials.secure(
                onBadCertificate: (X509Certificate certificate, String host) => certificate.subject.endsWith("scry")),
            connectionTimeout: Duration(seconds: 30)),
      );
      _instance!._client = new RefreshOpenFaceClient(_instance!._channel!);
      BasicClientReq _req = new BasicClientReq();
      _req.cashboxVersion = cashboxVersion;
      _req.platformType = platformType.toEnumString();
      _req.signature = signature;
      _req.deviceId = deviceId;
      _req.cashboxType = cashboxType;
      _instance!._req = _req;
    }
    return _instance!;
  }

  @visibleForTesting
  set version(String v) => _req.cashboxVersion = v;

  Future<ConnectParameter> refreshCall() async {
    _req.timestamp = new Int64(DateTime.now().millisecondsSinceEpoch ~/ 1000);
    var res = await _client!.connectParameter(_req);
    if (res.hasErr()) {
      //todo
      res.host = "http://cashbox.scry.info";
      res.port = 80 as Int64;
    }
    ConnectParameter parameter = new ConnectParameter(res.host, res.port.toInt(),
        options: ChannelOptions(
            credentials: ChannelCredentials.secure(
                onBadCertificate: (X509Certificate certificate, String host) => certificate.subject.endsWith("scry")),
            connectionTimeout: Duration(seconds: 30)));
    return parameter;
  }

  shutDown() {
    _client = null;
    if (_channel != null) {
      _channel!.shutdown();
    }
    _channel = null;
  }
}
