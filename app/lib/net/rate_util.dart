import 'package:app/global_config/vendor_global_config.dart';
import 'package:app/model/rate.dart';
import 'package:app/net/net_util.dart';

//返回 价格对象Rate
Future<Rate> loadRateInstance() async {
  try {
    var res = await request(VendorGlobalConfig.RatePath); //todo change it 替换成你自己后端对应的法币接口地址
    if (res != null && (res as Map).containsKey("data") && ((res["data"] as Map).containsKey("prices"))) {
      Rate resultRate = Rate.instance;
      Map priceMap = (res["data"]["prices"] as Map);
      Map<String, DigitRate> resultMap = Map();
      priceMap.forEach((key, value) {
        DigitRate digitRate = new DigitRate();
        digitRate.name = value["name"].toString();
        digitRate.symbol = value["symbol"].toString();
        digitRate.price = double.parse(value["price"].toString());
        digitRate.high = double.parse(value["high"].toString());
        digitRate.low = double.parse(value["low"].toString());
        digitRate.histHigh = double.parse(value["histHigh"].toString());
        digitRate.histLow = double.parse(value["histLow"].toString());
        digitRate.timestamps = int.parse(value["timestamps"].toString());
        digitRate.volume = double.parse(value["volume"].toString());
        digitRate.changeDaily = double.parse(value["changeDaily"].toString());
        resultMap[key] = digitRate;
      });
      resultRate.setDigitRateMap(resultMap);
      Map legalRateMap = (res["data"]["rates"] as Map);
      resultRate.setLegalMap(legalRateMap);
      return resultRate;
    }
    return null;
  } catch (e) {
    return null;
  }
}
