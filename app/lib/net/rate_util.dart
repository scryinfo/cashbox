import 'package:app/global_config/global_config.dart';
import 'package:app/model/rate.dart';
import 'package:app/net/net_util.dart';

//返回 价格对象Rate
Future<Rate> loadRateInstance() async {
  try {
    var res = await request(RatePath);
    if (res != null && (res as Map).containsKey("data") && ((res["data"] as Map).containsKey("prices"))) {
      Rate resultRate = Rate.instance;
      var priceMap = (res["data"]["prices"] as Map);
      resultRate.setDigitRateMap(priceMap);
      var legalRateMap = (res["data"]["rates"] as Map);
      resultRate.setLegalMap(legalRateMap);
      return resultRate;
    }
    return null;
  } catch (e) {
    print("loadDigitRate error is ====>" + e);
    return null;
  }
}
