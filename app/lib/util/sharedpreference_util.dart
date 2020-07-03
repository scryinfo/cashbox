import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Use local files to store information. key:value. Part of the implementation of android is sharedPreference, the implementation of ios is NSUserDefaults
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
      //Configure application version upgrade information
      spUtil.setString(VendorConfig.cashboxDownloadIpKey, VendorConfig.cashboxDownloadIpDefaultValue);
    }
    {
      //Configure token corresponding fiat currency information, trusted token list address, and default token address
      /// You can add or delete the initial configuration here according to your needs.
      spUtil.setString(VendorConfig.rateDigitIpKey, VendorConfig.rateDigitIpDefaultValue);
      spUtil.setString(VendorConfig.authDigitsIpKey, VendorConfig.authDigitsIpDefaultValue);
      spUtil.setString(VendorConfig.defaultDigitsKey, VendorConfig.defaultDigitsDefaultValue);
      spUtil.setString(VendorConfig.scryXIpKey, VendorConfig.scryXIpDefaultValue);
      spUtil.setString(VendorConfig.publicIpKey, VendorConfig.publicIpDefaultValue);
    }
    {
      //The selected fiat currency is: (usd cny jpy)
      spUtil.setString(GlobalConfig.currencyKey, GlobalConfig.currencyDefaultValue);
    }
    spUtil.setBool(GlobalConfig.isInitAppConfig, true);
  }
}
