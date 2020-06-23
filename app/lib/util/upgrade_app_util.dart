import 'package:app/global_config/vendor_global_config.dart';
import 'package:app/net/net_util.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class UpgradeAppUtil {
  static const methodPlugin = const MethodChannel('upgrade_app_channel');

  //工厂单例类实现
  factory UpgradeAppUtil() => _getInstance();

  static UpgradeAppUtil get instance => _getInstance();
  static UpgradeAppUtil _instance;

  UpgradeAppUtil._internal() {
    //init data
  }

  static UpgradeAppUtil _getInstance() {
    if (_instance == null) {
      _instance = new UpgradeAppUtil._internal();
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
      var serveResult = await request(VendorGlobalConfig.versionCheckIp, formData: {"ApkVersion": appVersion});
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
            _doUpgradeApp(VendorGlobalConfig.latestVersionIp, latestVersion);
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
    methodPlugin.invokeMethod('upgrade_app_method', {'downloadurl': downloadUrl, 'serverVersion': serverVersion});
  }
}
