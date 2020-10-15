import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LogUtil {
  static const perform = const MethodChannel("android_log_channel");

  // todo : wait plugin Logger merge code to fix FileOutput problem
  // Future<Logger> getLogUtilInstance() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String fullPath = directory.path + "/" + "some-log.txt";
  //   final Logger fileLogger = Logger(output: FileOutput(file: File(fullPath)));
  //   fileLogger.d();
  //   fileLogger.v();
  //   return fileLogger;
  // }

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
