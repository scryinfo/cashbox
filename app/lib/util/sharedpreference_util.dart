import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 利用本地文件，存储信息。 key:value。  android部分实现是sharedPreference，ios实现是NSUserDefaults
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
      //配置应用版本升级信息
      spUtil.setString(VendorGlobalConfig.cashboxDownloadIpKey, VendorGlobalConfig.cashboxDownloadIpDefaultValue);
    }
    {
      //配置代币对应法币信息、信任代币列表地址、默认代币地址
      /// 可根据自己需要，增删此处的初始配置。
      spUtil.setString(VendorGlobalConfig.rateDigitIpKey, VendorGlobalConfig.rateDigitIpDefaultValue);
      spUtil.setString(VendorGlobalConfig.authDigitsIpKey, VendorGlobalConfig.authDigitsIpDefaultValue);
      spUtil.setString(VendorGlobalConfig.defaultDigitsKey, VendorGlobalConfig.defaultDigitsDefaultValue);
      spUtil.setString(VendorGlobalConfig.scryXIpKey, VendorGlobalConfig.scryXIpDefaultValue);
      spUtil.setString(VendorGlobalConfig.publicIpKey, VendorGlobalConfig.publicIpDefaultValue);
    }
    {
      //选择的法币是： （usd cny jpy）
      spUtil.setString(GlobalConfig.currencyKey, GlobalConfig.currencyDefaultValue);
    }
    spUtil.setBool(GlobalConfig.isInitAppConfig, true);
  }
}
