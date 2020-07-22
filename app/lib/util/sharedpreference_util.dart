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

  static initIpConfig() async {
    var spUtil = await SharedPreferenceUtil.instance;
    {
      //Configure application version upgrade information
      spUtil.setString(VendorConfig.downloadLatestVersionIpKey, VendorConfig.downloadLatestVersionIpValue);
    }
    {
      /// You can add or delete the initial configuration here according to your needs.
      spUtil.setString(VendorConfig.appServerConfigIpKey, VendorConfig.appServerConfigIpValue);
      spUtil.setString(VendorConfig.appConfigVersionKey, VendorConfig.appConfigVersionValue);
      spUtil.setString(VendorConfig.serverApkVersionKey, VendorConfig.serverApkVersionValue);
      //Configure token corresponding fiat currency information, trusted token list address, and default token address
      spUtil.setString(VendorConfig.rateDigitIpKey, VendorConfig.rateDigitIpDefaultValue);
      // record digit ip and version
      spUtil.setString(VendorConfig.authDigitsVersionKey, VendorConfig.authDigitsVersionValue);
      spUtil.setString(VendorConfig.authDigitsIpKey, VendorConfig.authDigitsIpDefaultValue);
      spUtil.setString(VendorConfig.defaultDigitsVersionKey, VendorConfig.defaultDigitsVersionValue);
      spUtil.setString(VendorConfig.defaultDigitsIpKey, VendorConfig.defaultDigitsIpDefaultValue);
      spUtil.setString(VendorConfig.defaultDigitsContentKey, VendorConfig.defaultDigitsContentDefaultValue);
      spUtil.setString(VendorConfig.scryXIpKey, VendorConfig.scryXIpDefaultValue);

      /// public web
      spUtil.setString(VendorConfig.publicIpKey, VendorConfig.publicIpDefaultValue);

      /// control visit time
      spUtil.setString(VendorConfig.lastTimeCheckConfigKey, VendorConfig.lastTimeCheckConfigValue);
      //init db info config
      spUtil.setBool(VendorConfig.initDatabaseStateKey, false);
      spUtil.setString(VendorConfig.newDbVersionKey, VendorConfig.newDbVersionValue);
      spUtil.setString(VendorConfig.oldDbVersionKey, VendorConfig.oldDbVersionValue);
    }
    {
      //The selected fiat currency is: (usd cny jpy)
      spUtil.setString(GlobalConfig.currencyKey, GlobalConfig.currencyDefaultValue);
    }
    spUtil.setBool(GlobalConfig.isInitAppConfig, true);
  }
}
