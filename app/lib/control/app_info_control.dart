import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppInfoControl {
  static const appInfoChannel = const MethodChannel('app_info_channel');
  static const UPGRADE_APP_METHOD = "upgrade_app_method";
  static const APP_SIGNINFO_METHOD = "app_signinfo_method";

  //Factory singleton class implementation
  factory AppInfoControl() => _getInstance();

  static AppInfoControl get instance => _getInstance();
  static final AppInfoControl _instance = new AppInfoControl._internal();

  AppInfoControl._internal();

  static AppInfoControl _getInstance() {
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
      Logger().e("checkAppUpgrade error is ", e.toString());
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

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }

  /// [Best practices for unique identifiers](https://developer.android.com/training/articles/user-data-ids)
  /// get unique id from api, if not then generate a uuid
  Future<String> getDeviceId() async {
    final uniqueId = "dev_unique_id";
    try {
      String deviceId = "";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tid = await prefs.getString(uniqueId);
      if (tid != null) {
        deviceId = tid;
        return deviceId;
      }
      if (Platform.isAndroid) {
        var tid = await PlatformDeviceId.getDeviceId;
        if (tid == null) {
          DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
          var info = await _deviceInfoPlugin.androidInfo;
          tid = info.serialNumber;
        }
        if (tid == null) {
          tid = Uuid().v4().toString();
        }
        deviceId = tid;
        prefs.setString(uniqueId, deviceId);
      } else if (Platform.isIOS) {
        DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
        var info = await _deviceInfoPlugin.iosInfo;
        var tid = info.identifierForVendor;
        if (tid == null) {
          tid = await PlatformDeviceId.getDeviceId;
        }
        if (tid != null) {
          deviceId = tid;
        }
      }
      return deviceId;
    } catch (e) {
      Logger().e("requestWithDeviceId", "${e}");
      return "";
    }
  }
}
