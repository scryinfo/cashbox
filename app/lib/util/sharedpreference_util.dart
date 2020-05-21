import 'package:app/global_config/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static Future<SharedPreferences> get instance => _getInstance();
  static Future<SharedPreferences> _instance;

  static Future<SharedPreferences> _getInstance() {
    if (_instance == null) {
      _instance = SharedPreferences.getInstance();
    }
    return _instance;
  }

  static initVersion() async {
    var spUtil = await SharedPreferenceUtil.instance;
    spUtil.setString(GlobalConfig.rateDigitIpKey, GlobalConfig.rateDigitIpValue);
    spUtil.setString(GlobalConfig.authDigitListKey, GlobalConfig.authDigitListValue);
    spUtil.setString(GlobalConfig.defaultDigitListKey, GlobalConfig.defaultDigitListValue);
    spUtil.setString(GlobalConfig.scryXkey, GlobalConfig.scryXValue);
    spUtil.setString(GlobalConfig.cashboxVersionKey, GlobalConfig.cashboxVersionValue);
    spUtil.setString(GlobalConfig.cashboxDownloadIpKey, GlobalConfig.cashboxDownloadIpValue);
    spUtil.setString(GlobalConfig.publicIpKey, GlobalConfig.publicIpValue);
    spUtil.setBool(GlobalConfig.isInitAppConfig, true);
  }
}
