import 'package:app/global_config/vendor_config.dart';
import 'package:app/net/net_util.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class AppInfoUtil {
  static const appInfoChannel = const MethodChannel('app_info_channel');
  static const UPGRADE_APP_METHOD = "upgrade_app_method";
  static const APP_SIGNINFO_METHOD = "app_signinfo_method";

  //工厂单例类实现
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

  //true:需要更新，   false： 不需要更新
  Future<bool> checkAppUpgrade() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    String buildNumber = packageInfo.buildNumber; //版本构建号
    print("packageInfo appVersion===>" + appVersion + "||buildNumber===>" + buildNumber);
    try {
      var serveResult = await request(VendorConfig.versionCheckIp, formData: {"ApkVersion": appVersion});
      if ((serveResult != null) && (serveResult["code"] == 0)) {
        var resultObj = serveResult["data"];
        if (resultObj == null || resultObj["confirmLatest"] == null) {
          print("resultObj is wrong=====>");
          return false;
        }
        if (!resultObj["confirmLatest"]) {
          print("confirmLatest=====>" + resultObj["confirmLatest"].toString());
          var latestVersion = resultObj["latestApk"]["apkVersion"].toString();
          if (latestVersion != null && latestVersion.isNotEmpty) {
            _doUpgradeApp(VendorConfig.latestVersionIp, latestVersion);
            return true;
          }
        }
      } else {
        print("checkAppUpgrade serve check failure ====>");
      }
    } catch (e) {
      print("checkAppUpgrade error is ===>" + e.toString());
      return false;
    }
    return false;
  }

  //通知到android/ios 原生部分，去升级
  _doUpgradeApp(String downloadUrl, String serverVersion) {
    appInfoChannel.invokeMethod(UPGRADE_APP_METHOD, {'downloadurl': downloadUrl, 'serverVersion': serverVersion});
  }

  //获取app 签名信息
  Future<String> getAppSignInfo() async {
    String appSignInfo = await appInfoChannel.invokeMethod(APP_SIGNINFO_METHOD);
    return appSignInfo;
  }
}
