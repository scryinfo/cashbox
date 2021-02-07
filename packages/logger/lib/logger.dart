import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

enum LogLevel {
  Debug,
  Info,
  Warn,
  Error,
  Fatal,
}

extension LogLevelEx on LogLevel {
  static int getLevelValue(LogLevel curLevel) {
    switch (curLevel) {
      case LogLevel.Debug:
        return 0;
        break;
      case LogLevel.Info:
        return 1;
        break;
      case LogLevel.Warn:
        return 2;
        break;
      case LogLevel.Error:
        return 3;
        break;
      case LogLevel.Fatal:
        return 4;
        break;
      default:
        return 0;
    }
  }
}

class InfoModel {
  String message;
}

class Logger {
  static final String _logFileName = "cashbox.log";
  static LogLevel _filterLevel = LogLevel.Debug;
  final String _logThreadName = "LogThread";
  final int _fileSizeLimit = 30 * 1024 * 1024; // 30 * 1024 * 1024  bytes = 30M
  bool _isLogThreadStarted = false; // is already start log thread
  SendPort _sendPort;

  factory Logger() => _getInstance();

  static Logger _instance;

  Logger._internal() {
    //init data
  }

  static Logger getInstance() {
    return _getInstance();
  }

  static Logger _getInstance() {
    if (_instance == null) {
      _instance = Logger._internal();
    }
    return _instance;
  }

  // return Logger in order to chain style call
  // eg: Logger.setLogLevel(LogLevel.Error).d("tag","msg")
  Logger setLogLevel(LogLevel filterLevel) {
    _filterLevel = filterLevel;
    return this;
  }

  LogLevel getLogLevel() {
    return _filterLevel;
  }

  _registerAndListeningLogThread() async {
    final rPort = ReceivePort();
    bool onceRegister = IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
    if (onceRegister) {
      _isLogThreadStarted = true;
    }
    rPort.listen((message) async {
      if (!(message is InfoModel)) {
        return;
      }
      try {
        File mainLogFile = await _logFile(_logFileName);
        if (mainLogFile == null) {
          return;
        }
        File backupLogFile = await _logFile(_logFileName + ".backup");
        if (backupLogFile == null) {
          return;
        }
        if (mainLogFile.lengthSync() > _fileSizeLimit) {
          // file name exchange with a temporary fileName.   such as: t=a,a=b,b=a;
          File tempFile = mainLogFile.renameSync(mainLogFile.path + ".backup.temp");
          mainLogFile = backupLogFile.renameSync(mainLogFile.path);
          mainLogFile.writeAsStringSync(""); // clear the file
          backupLogFile = tempFile.renameSync(mainLogFile.path + ".backup");
        }
        mainLogFile.writeAsStringSync(message.message, flush: true, mode: FileMode.append);
      } catch (e) {
        print("printOut error is --->" + e.toString());
      }
    });
  }

  Future<File> _logFile(String fileName) async {
    Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
    String filePath = directory.path + "/" + fileName;
    try {
      if (!File(filePath).existsSync()) {
        File(filePath).createSync();
      }
      return File(filePath);
    } catch (e) {
      print("logFile error is " + e.toString());
      return null;
    }
  }

  _isMatchOutputLevel(LogLevel logLevel) {
    if (LogLevelEx.getLevelValue(logLevel) >= LogLevelEx.getLevelValue(_filterLevel)) {
      return true;
    }
    return false;
  }

  void d(String tag, String message, {bool isSave2File = true}) async {
    var recordInfo = LogLevel.Debug.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);
    if (_isMatchOutputLevel(LogLevel.Debug) && isSave2File) {
      sendToLogThread(recordInfo);
    }
  }

  void i(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = LogLevel.Info.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);
    if (_isMatchOutputLevel(LogLevel.Info) && isSave2File) {
      sendToLogThread(recordInfo);
    }
  }

  void w(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = LogLevel.Warn.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);
    if (_isMatchOutputLevel(LogLevel.Warn) && isSave2File) {
      sendToLogThread(recordInfo);
    }
  }

  void e(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = LogLevel.Error.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo); // show it on console terminal
    if (_isMatchOutputLevel(LogLevel.Error) && isSave2File) {
      sendToLogThread(recordInfo);
    }
  }

  void f(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = LogLevel.Fatal.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo); // show it on console terminal
    if (_isMatchOutputLevel(LogLevel.Fatal) && isSave2File) {
      sendToLogThread(recordInfo);
    }
  }

  void sendToLogThread(String recordInfo) {
    if (!_isLogThreadStarted) {
      // case:  need save recordInfo to file and not yet register the log thread,
      //        here do register and listen the log thread
      _registerAndListeningLogThread();
    }
    if (_sendPort == null) {
      _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    }
    _sendPort?.send(InfoModel()..message = recordInfo);
  }
}
