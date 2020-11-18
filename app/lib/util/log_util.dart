import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum Level {
  Debug,
  Info,
  Warn,
  Error,
}

class LogUtil {
  Level _level;
  String _logFileName = "cashbox.log";

  factory LogUtil() => _getInstance();

  static LogUtil get instance => _getInstance();
  static LogUtil _instance;

  LogUtil._internal() {
    //init data
  }

  static LogUtil _getInstance() {
    if (_instance == null) {
      _instance = LogUtil._internal();
    }
    return _instance;
  }

  Future<File> get _logFile async {
    Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
    String fullPath = directory.path + "/" + _logFileName;
    print("log fullPath is " + fullPath.toString());
    if (!await File(fullPath).exists()) {
      File(fullPath).create();
    }
    return File(fullPath);
  }

  void d(String tag, String message) async {
    _level = Level.Debug;
    _printOut(tag, message);
  }

  void i(String tag, String message) async {
    _level = Level.Info;
    _printOut(tag, message);
  }

  void w(String tag, String message) async {
    _level = Level.Warn;
    _printOut(tag, message);
  }

  e(String tag, String message) async {
    _level = Level.Error;
    _printOut(tag, message);
  }

  void _printOut(String tag, String message) async {
    File file = await _logFile;
    file.writeAsString(_level.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n", flush: true, mode: FileMode.append);
  }
}
