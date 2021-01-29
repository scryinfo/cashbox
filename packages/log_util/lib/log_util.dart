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

  factory LogUtil({String logFileName = "cashbox.log"}) => _getInstance(logFileName);

  static LogUtil instance({String logFileName = "cashbox.log"}) => _getInstance(logFileName);
  static LogUtil _instance;

  LogUtil._internal(logFileName) {
    //init data
    this._logFileName = logFileName;
  }

  static LogUtil _getInstance(String logFileName) {
    if (_instance == null) {
      _instance = LogUtil._internal(logFileName);
    }
    return _instance;
  }

  clearObsoleteFiles({int fileRetainDays = 10}) async {
    DateTime nowDateTime = DateTime.now();
    Directory directory = await getExternalStorageDirectory(); // eg path:  Android/data/
    List<FileSystemEntity> files = directory.listSync();
    for (var f in files) {
      var fileDirArray = f.path.split("/");
      if (fileDirArray == null || fileDirArray.length < 1) {
        continue;
      }
      var fileNameArray = fileDirArray.last.split("_");
      if (fileNameArray == null || fileNameArray.length < 3) {
        continue;
      }
      var fileNameDate = DateTime(int.parse(fileNameArray[0]), int.parse(fileNameArray[1]), int.parse(fileNameArray[2]));
      if (nowDateTime.difference(fileNameDate).inDays > fileRetainDays) {
        f.delete();
      }
    }
  }

  Future<File> get _logFile async {
    // filename eg: 2020_01_02_cashbox.log
    Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
    var datePrefix = DateTime.now().year.toString() + "_" + DateTime.now().month.toString() + "_" + DateTime.now().day.toString() + "_";
    String fullPath = directory.path + "/" + datePrefix + _logFileName;
    if (!await File(fullPath).exists()) {
      File(fullPath).create();
    }
    return File(fullPath);
  }

  void d(String tag, String message, {bool isSave2File = true}) {
    _level = Level.Debug;
    _printOut(tag, message, isSave2File);
  }

  void i(String tag, String message, {bool isSave2File = true}) {
    _level = Level.Info;
    _printOut(tag, message, isSave2File);
  }

  void w(String tag, String message, {bool isSave2File = true}) {
    _level = Level.Warn;
    _printOut(tag, message, isSave2File);
  }

  e(String tag, String message, {bool isSave2File = true}) {
    _level = Level.Error;
    _printOut(tag, message, isSave2File);
  }

  void _printOut(String tag, String message, bool isSave2File) async {
    print(_level.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n");
    if (isSave2File) {
      File file = await _logFile;
      file.writeAsStringSync(_level.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n",
          flush: true, mode: FileMode.append);
    }
  }
}
