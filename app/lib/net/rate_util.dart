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
      // todo 2.0 说明，访问接口https://data.block.cc/api/v3 数据返回的rate值（法币间汇率）有问题，
      // 目前暂时写死（法币间汇率）展示
      legalRateMap["CNY"] = 6.92;
      legalRateMap["EUR"] = 0.881679;
      legalRateMap["GBP"] = 0.765212;
      legalRateMap["JPY"] = 103.9849366;
      legalRateMap["KRW"] = 900;
      legalRateMap["USD"] = 1;
      resultRate.setLegalMap(legalRateMap);
      return resultRate;
    }
    return null;
  } catch (e) {
    print("loadDigitRate error is ====>" + e);
    return null;
  }
}
