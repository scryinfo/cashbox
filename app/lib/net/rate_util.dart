import 'package:app/control/app_info_control.dart';
import 'package:app/model/token_rate.dart';
import 'package:logger/logger.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';

//Returns Price Object Rate
Future<TokenRate> loadRateInstance() async {
  final cashBoxType = "GA";
  String signInfo = await AppInfoControl.instance.getAppSignInfo();
  String deviceId = await AppInfoControl.instance.getDeviceId();
  String apkVersion = await AppInfoControl.instance.getAppVersion();

  var refresh = RefreshOpen.get(
      new ConnectParameter("cashbox.scry.info", 9004), apkVersion, AppPlatformType.any, signInfo, deviceId, cashBoxType);
  var channel = createClientChannel(refresh.refreshCall);
  BasicClientReq basicClientReq = new BasicClientReq();
  basicClientReq
    ..cashboxType = cashBoxType
    ..cashboxVersion = apkVersion
    ..deviceId = deviceId
    ..platformType = "aarch64-linux-android"
    ..signature = signInfo;
  TokenRate resultRate = TokenRate.instance;
  final tokenPriceClient = TokenOpenFaceClient(channel);
  try {
    TokenOpen_PriceRateRes priceRes = await tokenPriceClient.priceRate(basicClientReq);
    List<TokenOpen_Price> priceList = priceRes.prices;
    List<TokenOpen_Rate> rateList = priceRes.rates;
    // load and save legal
    {
      var legalMap = Map<String, double>();
      rateList.forEach((element) {
        legalMap[element.name] = element.value;
      });
      resultRate.setLegalMap(legalMap);
    }
    // load and save price
    {
      var priceMap = Map<String, TokenRateM>();
      priceList.forEach((price) {
        var digitRate = new TokenRateM();
        digitRate
          ..symbol = price.symbol
          ..name = price.name
          ..price = 0.0
          ..changeDaily = 0.0;
        if (price.hasChangePercent24Hr()) {
          digitRate.changeDaily = double.parse(price.changePercent24Hr ?? "0");
        }
        if (price.hasPriceUsd()) {
          digitRate.price = double.parse(price.priceUsd ?? "0");
        }
        priceMap[price.symbol] = digitRate;
      });
      resultRate.setDigitRateMap(priceMap);
    }
    return resultRate;
  } catch (e) {
    Logger.getInstance().e("rateUtil  error is --->", e.toString());
    return resultRate;
  }
}
