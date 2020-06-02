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
    {
      //版本信息
      spUtil.setString(GlobalConfig.cashboxDownloadIpKey, GlobalConfig.cashboxDownloadIpDefaultValue);
    }
    {
      //配置信息
      spUtil.setString(GlobalConfig.rateDigitIpKey, GlobalConfig.rateDigitIpDefaultValue);
      spUtil.setString(GlobalConfig.authDigitsIpKey, GlobalConfig.authDigitsIpDefaultValue);
      spUtil.setString(GlobalConfig.defaultDigitsKey, GlobalConfig.defaultDigitsDefaultValue);
      spUtil.setString(GlobalConfig.scryXIpKey, GlobalConfig.scryXIpDefaultValue);
      spUtil.setString(GlobalConfig.publicIpKey, GlobalConfig.publicIpDefaultValue);
    }
    {
      //选择的法币是： （usd cny jpy）
      spUtil.setString(GlobalConfig.currencyKey, GlobalConfig.currencyDefaultValue);
    }
    spUtil.setBool(GlobalConfig.isInitAppConfig, true);
  }
}
