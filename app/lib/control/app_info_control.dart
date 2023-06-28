import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

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

  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, dynamic>> _readAndroidBuildData() async {
    var build = await _deviceInfoPlugin.androidInfo;
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

//Record ios device information
  Future<Map<String, dynamic>> _readIosDeviceInfo() async {
    var data = await _deviceInfoPlugin.iosInfo;
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Future<dynamic> getSupportAbi() async {
    Map<String, dynamic> _deviceData = <String, dynamic>{};
    if (Platform.isAndroid) {
      _deviceData = await _readAndroidBuildData();
      if (_deviceData != null) {
        var abiList = List.castFrom(_deviceData["supportedAbis"]);
        if (abiList != null && abiList.length > 0) {
          return abiList[0];
        }
      }
    }
    return "";
  }

  Future<dynamic> getDeviceId() async {
    Map<String, dynamic> _deviceData = <String, dynamic>{};
    try {
      String deviceId = "";
      if (Platform.isAndroid) {
        _deviceData = await _readAndroidBuildData();
        if (_deviceData != null) {
          deviceId = _deviceData["androidId"];
          //At present, each Android product device has a unique identification value. If you do not agree, temporarily take the value of androidId.
        }
      } else if (Platform.isIOS) {
        _deviceData = await _readIosDeviceInfo();
        deviceId = _deviceData["utsname.machine"];
      }
      return deviceId;
    } on PlatformException {
      _deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
      Logger().e("requestWithDeviceId", "unknown target platform");
      return null;
    } catch (e) {
      Logger().e("requestWithDeviceId", "${e}");
      return null;
    }
  }
}
