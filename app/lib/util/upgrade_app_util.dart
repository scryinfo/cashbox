import 'package:flutter/services.dart';

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

  static doUpgradeApp(String downloadUrl, {String serverVersion = "*.0.0"}) {
    methodPlugin.invokeMethod('upgrade_app_method', {'downloadurl': downloadUrl, 'serverVersion': serverVersion});
  }
}
