import 'package:app/global_config/vendor_config.dart';
import 'package:app/net/net_util.dart';
import 'package:app/util/sharedpreference_util.dart';
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
    print("packageInfo appVersion===>" + appVersion + "||buildNumber===>" + buildNumber);
    try {
      var spUtil = await SharedPreferenceUtil.instance;
      String versionIpValue = spUtil.getString(VendorConfig.versionCheckIpKey) ?? VendorConfig.versionCheckIpValue;
      var serveResult = await requestWithDeviceId(versionIpValue, formData: {"apkVersion": appVersion});
      if ((serveResult != null) && (serveResult["code"] == 0)) {
        var resultObj = serveResult["data"];
        if (resultObj == null || resultObj["isLatest"] == null) {
          print("resultObj is wrong=====>");
          return false;
        }
        if (!resultObj["isLatest"]) {
          print("isLatest=====>" + resultObj["isLatest"].toString());
          var latestVersion = resultObj["latestApk"]["apkVersion"].toString();
          if (latestVersion != null && latestVersion.isNotEmpty) {
            var spUtil = await SharedPreferenceUtil.instance;
            String downloadIpValue = spUtil.getString(VendorConfig.downloadLatestVersionIpKey) ?? VendorConfig.downloadLatestVersionIpValue;
            _doUpgradeApp(downloadIpValue, latestVersion);
            return true;
          }
        }
      } else {
        print("checkAppUpgrade serve check failure ====>");
        return false;
      }
    } catch (e) {
      print("checkAppUpgrade error is ===>" + e.toString());
      return false;
    }
    return false;
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
