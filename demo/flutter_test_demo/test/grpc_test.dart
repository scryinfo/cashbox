import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_demo/control/eth_chain_control.dart';
import 'package:flutter_test_demo/control/wallets_control.dart';
import 'package:flutter_test_demo/model/server_config_model.dart';
import 'package:flutter_test_demo/model/token.dart';
import 'package:flutter_test_demo/model/token_rate.dart';
import 'package:package_info/package_info.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/cashbox_version_open.pbgrpc.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'dart:convert';
import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:wallets/wallets_c.dc.dart';

void main() {
  final cashBoxType = "GA";
  final signInfo = "82499105f009f80a1fe2f1db86efdec7";
  final deviceId = "deviceIddddddd";
  final apkVersion = "5.0.0";
  var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.57", 9004),
      apkVersion, AppPlatformType.any, signInfo, deviceId, cashBoxType);
  var channel = createClientChannel(refresh.refreshCall);
  BasicClientReq basicClientReq = new BasicClientReq();
  basicClientReq
    ..cashboxType = cashBoxType
    ..cashboxVersion = apkVersion
    ..deviceId = deviceId
    ..platformType = "aarch64-linux-android"
    ..signature = signInfo;
  test('cashboxConfigOpenFaceClient', () async {
    final cashboxConfigOpenFaceClient = CashboxConfigOpenFaceClient(channel);
    try {
      CashboxConfigOpen_LatestConfigRes latestConfigRes =
          await cashboxConfigOpenFaceClient.latestConfig(basicClientReq);
      print("latestConfigRes  is ------>" + latestConfigRes.toString());
      print("latestConfigRes  is ------>" +
          json.decode(latestConfigRes.conf).toString());
      print("latestConfigRes  url is ------>" +
          json.decode(latestConfigRes.conf)["scryXChainUrl"].toString());
      LatestConfig serverConfigModel =
          LatestConfig.fromJson(json.decode(latestConfigRes.conf));
      print("latestConfigRes  is ------>" +
          serverConfigModel.toJson().toString());
      print("latestConfigRes  is ------>" + serverConfigModel.toString());
    } catch (e) {
      print("latestConfigRes  error is ------>" + e.toString());
    }
  });
  test('Cashbox Rate Info ', () async {
    final tokenPriceClient = TokenOpenFaceClient(channel);
    try {
      TokenOpen_PriceRateRes priceRes =
          await tokenPriceClient.priceRate(basicClientReq);
      print("priceRes  is ------>" + priceRes.toString());
      List<TokenOpen_Price> priceList = priceRes.prices;
      List<TokenOpen_Rate> rateList = priceRes.rates;

      print("priceRes.prices.length  is ------>" + priceList.length.toString());
      print("priceRes.prices  is ------>" + priceRes.prices.toString());
      priceList.forEach((price) {
        if (price.hasChangePercent24Hr()) {
          var changePerHour = double.parse(price.changePercent24Hr);
          print("change  is ------>" + changePerHour.toString());
          print("change  is ------>" + price.name);
        } else {
          print("这货没有changePercent24Hour  is ------>" + price.name);
        }
      });

      print("priceRes.rates  is ------>" + rateList.length.toString());
      print("priceRes.rates  is ------>" + priceRes.rates[0].toString());
      print("priceRes err is ------>" +
          priceRes.err.code.toString() +
          "||" +
          priceRes.err.message.toString());
    } catch (e) {
      print("latestConfigRes  error is ------>" + e.toString());
    }
  });

  test('EthTokenOpen_QueryReq ', () async {
    var refresh = RefreshOpen.get(
        new ConnectParameter("192.168.2.57", 9004),
        "5.0.0",
        AppPlatformType.any,
        "82499105f009f80a1fe2f1db86efdec7",
        "",
        "");
    var channel = createClientChannel(refresh.refreshCall);
    EthTokenOpen_QueryReq open_queryReq = new EthTokenOpen_QueryReq();
    EeeTokenOpen_QueryReq open_eee_queryReq = new EeeTokenOpen_QueryReq();

    PageReq pageReq = PageReq();
    pageReq..page = 0;
    open_queryReq
      ..info = basicClientReq
      ..page = pageReq
      ..isDefault = false;
    open_eee_queryReq
      ..info = basicClientReq
      ..page = pageReq
      ..isDefault = false;
    final ethTokenClient = EthTokenOpenFaceClient(channel);
    final eeeTokenClient = EeeTokenOpenFaceClient(channel);
    try {
      EeeTokenOpen_QueryRes eeeTokenOpen_QueryRes =
          await eeeTokenClient.query(open_eee_queryReq);
      print("eee TokenOpen_QueryRes.page  is ------>");
      print("eee TokenOpen_QueryRes.page  is ------>" +
          eeeTokenOpen_QueryRes.page.toString());
      List<EeeTokenOpen_Token> eeeTokenList = eeeTokenOpen_QueryRes.tokens;
      print(
          "eth TokenList.length  is ------>" + eeeTokenList.length.toString());
      eeeTokenList.forEach((element) {
        print("element is --->" + element.toString());
      });
      EthTokenOpen_QueryRes ethTokenOpen_QueryRes =
          await ethTokenClient.query(open_queryReq);
      print("eth TokenOpen_QueryRes.page  is ------>" +
          ethTokenOpen_QueryRes.page.toString());

      List<EthTokenOpen_Token> ethTokenList = ethTokenOpen_QueryRes.tokens;
      print(
          "eth TokenList.length  is ------>" + ethTokenList.length.toString());
      List<TokenM> tokenMList = [];
      ArrayCEthChainTokenAuth arrayCEthChainTokenAuth =
          ArrayCEthChainTokenAuth();
      List<EthChainTokenAuth> ethChainTokenList = [];
      ethTokenList.forEach((element) {
        TokenM tokenM = TokenM()
          ..tokenId = element.id
          ..shortName = element.tokenShared.symbol
          ..contractAddress = element.contract
          ..decimal = element.decimal
          ..fullName = element.tokenShared.name;
        tokenMList.add(tokenM);
        print("ethTokenList item is --->" +
            element.id +
            "id" +
            element.tokenShared.name +
            "||" +
            element.tokenShared.symbol);
        EthChainTokenAuth ethChainTokenAuth = EthChainTokenAuth();
        ethChainTokenAuth
          ..contractAddress = element.contract
          ..chainTokenSharedId = element.tokenShardId
          ..ethChainTokenShared.decimal = element.decimal
          ..ethChainTokenShared.tokenShared.name = element.tokenShared.name
          ..ethChainTokenShared.tokenShared.symbol = element.tokenShared.symbol
          ..ethChainTokenShared.tokenShared.logoUrl =
              element.tokenShared.logoUrl;
        ethChainTokenList.add(ethChainTokenAuth);
      });
      arrayCEthChainTokenAuth.data = ethChainTokenList;
      // await WalletsControl.getInstance().initWallet();
      // EthChainControl.getInstance().updateAuthTokenList(arrayCEthChainTokenAuth);
      print("tokenM item is --->" + tokenMList.toString());
    } catch (e) {
      print("latestConfigRes  error is ------>" + e.toString());
    }
  });

  test('TokenOpenFaceClient  PriceRate ', () async {
    final tokenClient = TokenOpenFaceClient(channel);
    try {
      TokenOpen_PriceRateRes tokenRes =
          await tokenClient.priceRate(basicClientReq);
      print("tokenRes err is ------>" + tokenRes.err.toString());
      print("tokenRes prices is ------>" + tokenRes.prices.toString());
      List<DigitRate> tokenPrices = [];
      tokenRes.prices.forEach((element) {
        DigitRate digitRate = DigitRate()
          ..name = element.name
          ..symbol = element.symbol
          ..changeDaily = double.parse(element.changePercent24Hr) ?? "0.0";
        tokenPrices.add(digitRate);
      });
      print("tokenRes tokenPrices is ------>" + tokenPrices.toString());
      Map priceMap = Map();
      tokenRes.rates.forEach((element) {
        priceMap[element.name] = element.value;
      });
      print("tokenRes priceMap is ------>" + priceMap.toString());
      print("tokenRes rates is ------>" + tokenRes.rates.toString());
    } catch (e) {
      print("tokenRes  error is ------>" + e.toString());
    }
  });
}
