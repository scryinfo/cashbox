import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class AppInfoUtil {
  static const appInfoChannel = const MethodChannel('app_info_channel');
  static const UPGRADE_APP_METHOD = "upgrade_app_method";
  static const APP_SIGNINFO_METHOD = "app_signinfo_method";

  //Factory singleton class implementation
  factory AppInfoUtil() => _getInstance();

  static AppInfoUtil get instance => _getInstance();
  static AppInfoUtil _instance;

  AppInfoUtil._internal() {
    //init data
  }

  static AppInfoUtil _getInstance() {
    if (_instance == null) {
      _instance = new AppInfoUtil._internal();
    }
    return _instance;
  }

  //Method parameters are determined according to the backend. true: update required, false: no update required
  Future<bool> checkAppUpgrade() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    String buildNumber = packageInfo.buildNumber; //Version build number
    Config config = await HandleConfig.instance.getConfig();
    try {
      String serverVersion = config.privateConfig.serverApkVersion;
      var serverVersionArray = serverVersion.split(".");
      var nativeVersionArray = appVersion.split(".");
      bool isExistNewVersion = false;
      if (serverVersionArray.length == nativeVersionArray.length) {
        for (int i = 0; i < serverVersionArray.length; i++) {
          if (double.parse(serverVersionArray[i]) > double.parse(nativeVersionArray[i])) {
            isExistNewVersion = true;
            break;
          } else if (double.parse(serverVersionArray[i]) < double.parse(nativeVersionArray[i])) {
            //case: test eg, serverVersion:2.1.1  nativeVersion: 2.2.0
            break;
          }
        }
      }
      if (serverVersion != null && appVersion != null && isExistNewVersion) {
        String downloadIpValue = config.privateConfig.downloadLatestAppUrl;
        _doUpgradeApp(downloadIpValue, serverVersion);
        return true;
      }
      return false;
    } catch (e) {
      print("checkAppUpgrade error is ===>" + e.toString());
      return false;
    }
  }

  //Notification to the native part of android/ios, to upgrade
  _doUpgradeApp(String downloadUrl, String serverVersion) {
    appInfoChannel.invokeMethod(UPGRADE_APP_METHOD, {'downloadurl': downloadUrl, 'serverVersion': serverVersion});
  }

  //Get app signature information
  Future<String> getAppSignInfo() async {
    String appSignInfo = await appInfoChannel.invokeMethod(APP_SIGNINFO_METHOD);
    return appSignInfo;
  }
}
