import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/util/app_info_util.dart';
import 'package:logger/logger.dart';
import 'package:services/services.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';

//Returns Price Object Rate
Future<TokenRate> loadRateInstance() async {
  // todo replace Ip
  // Config config = await HandleConfig.instance.getConfig();
  //  String rateIpValue = config.privateConfig.rateUrl;
  final cashBoxType = "GA";
  String signInfo = await AppInfoUtil.instance.getAppSignInfo();
  String deviceId = await AppInfoUtil.instance.getDeviceId();
  String apkVersion = await AppInfoUtil.instance.getAppVersion();

  var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), apkVersion, AppPlatformType.any, signInfo, deviceId, cashBoxType);
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
      var digitRate = new TokenRateM();
      priceList.forEach((price) {
        digitRate
          ..symbol = price.symbol
          ..name = price.name
          ..price = double.parse(price.priceUsd)
          ..changeDaily = double.parse(price.vwap24Hr);
        priceMap[price.symbol] = digitRate;
      });
      resultRate.setDigitRateMap(priceMap);
    }
    return resultRate;
  } catch (e) {
    Logger.getInstance().e("latestConfigRes  error is --->", e.toString());
    return resultRate;
  }
}
