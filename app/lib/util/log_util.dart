import 'package:flutter/services.dart';

class LogUtil {
  static const perform = const MethodChannel("android_log");

  static void v(String tag, String message) {
    perform.invokeMethod('logV', {'tag': tag, 'msg': message});
  }

  static void d(String tag, String message) {
    perform.invokeMethod('logD', {'tag': tag, 'msg': message});
  }

  static void i(String tag, String message) {
    perform.invokeMethod('logI', {'tag': tag, 'msg': message});
  }

  static void w(String tag, String message) {
    perform.invokeMethod('logW', {'tag': tag, 'msg': message});
  }

  static void e(String tag, String message) {
    perform.invokeMethod('logE', {'tag': tag, 'msg': message});
  }
}
