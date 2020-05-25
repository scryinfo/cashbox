import 'package:app/global_config/global_config.dart';
import 'package:app/model/rate.dart';
import 'package:app/net/net_util.dart';

//返回 价格对象Rate
Future<Rate> loadRateInstance() async {
  try {
    var res = await request(RatePath);
    if (res != null && (res as Map).containsKey("data") && ((res["data"] as Map).containsKey("prices"))) {
      Rate resultRate = Rate.instance;
      Map priceMap = (res["data"]["prices"] as Map);
      Map<String, DigitRate> resultMap = Map();
      priceMap.forEach((key, value) {
        DigitRate digitRate = new DigitRate();
        digitRate.name = value["name"].toString();
        //print("digitRate.name  is ======>" + digitRate.name.toString());
        digitRate.symbol = value["symbol"].toString();
        //print("digitRate.symbol  is ======>" + digitRate.symbol.toString());
        digitRate.price = double.parse(value["price"].toString());
        //print("digitRate.price  is ======>" + digitRate.price.toString());
        digitRate.high = double.parse(value["high"].toString());
        //print("digitRate.high  is ======>" + digitRate.high.toString());
        digitRate.low = double.parse(value["low"].toString());
        //print("digitRate.name  is ======>" + digitRate.low.toString());
        //print("digitRate.histHigh  is ======>" + value["histHigh"].runtimeType.toString());
        digitRate.histHigh = double.parse(value["histHigh"].toString());
        //print("digitRate.histHigh  is ======>" + digitRate.histHigh.toString());
        digitRate.histLow = double.parse(value["histLow"].toString());
        //print("digitRate.histLow  is ======>" + digitRate.histLow.toString());
        digitRate.timestamps = int.parse(value["timestamps"].toString());
        //print("digitRate.name  is ======>" + digitRate.timestamps.toString());
        digitRate.volume = double.parse(value["volume"].toString());
        //print("digitRate.volume  is ======>" + digitRate.volume.toString());
        digitRate.changeDaily = double.parse(value["changeDaily"].toString());
        //print("digitRate.changeDaily  is ======>" + digitRate.changeDaily.toString());
        resultMap[key] = digitRate;
      });
      resultRate.setDigitRateMap(resultMap);
      Map legalRateMap = (res["data"]["rates"] as Map);
      //print("legalRateMap  is ========>" + legalRateMap.toString());
      resultRate.setLegalMap(legalRateMap);
      return resultRate;
    }
    return null;
  } catch (e) {
    print("loadRateInstance() error is ====>" + e.toString());
    return null;
  }
}
