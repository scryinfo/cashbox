import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_demo/model/server_config_model.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/cashbox_version_open.pbgrpc.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'dart:convert';

void main() {
  final cashBoxType = "GA";
  final signInfo = "82499105f009f80a1fe2f1db86efdec7";
  var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), "2.0.0", AppPlatformType.any, signInfo, "eee", cashBoxType);
  var channel = createClientChannel(refresh.refreshCall);
  test('cashboxConfigOpenFaceClient', () async {
    BasicClientReq basicClientReq = new BasicClientReq();
    basicClientReq
      ..cashboxType = cashBoxType
      ..cashboxVersion = "2.0.0"
      ..deviceId = "eee"
      ..platformType = "aarch64-linux-android"
      ..signature = signInfo;
    final cashboxConfigOpenFaceClient = CashboxConfigOpenFaceClient(channel);
    try {
      CashboxConfigOpen_LatestConfigRes latestConfigRes = await cashboxConfigOpenFaceClient.latestConfig(basicClientReq);
      print("latestConfigRes  is ------>" + latestConfigRes.toString());
      print("latestConfigRes  configVersion is ------>" + latestConfigRes.configVersion.toString());
      print("latestConfigRes  cashboxVersion is ------>" + latestConfigRes.cashboxVersion.toString());
      print("latestConfigRes  conf is ------>" + latestConfigRes.conf.toString());
      print("latestConfigRes  is ------>" + json.decode(latestConfigRes.conf).toString());
      print("latestConfigRes  url is ------>" + json.decode(latestConfigRes.conf)["scryXChainUrl"].toString());
      print("latestConfigRes  authTokenListVersion is ------>" + json.decode(latestConfigRes.conf)["authTokenListVersion"].toString());
      ServerConfigModel serverConfigModel = ServerConfigModel.fromJson(json.decode(latestConfigRes.conf));
      print("latestConfigRes  is ------>" + serverConfigModel.toJson().toString());
    } catch (e) {
      print("latestConfigRes  error is ------>" + e.toString());
    }
  });
  test('TokenOpenFaceClient ', () async {
    BasicClientReq basicClientReq = BasicClientReq();
    basicClientReq
      ..cashboxType = "GA"
      ..cashboxVersion = "2.0.0"
      ..deviceId = "eee"
      ..platformType = "aarch64-linux-android"
      ..signature = "82499105f009f80a1fe2f1db86efdec7";
    final tokenClient = TokenOpenFaceClient(channel);
    try {
      TokenOpen_PriceRateRes tokenRes = await tokenClient.priceRate(basicClientReq);
      print("tokenRes  is ------>" + tokenRes.toString());
    } catch (e) {
      print("tokenRes  error is ------>" + e.toString());
    }
  });
}
