import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pathLib;

enum LogLevel {
  Debug,
  Info,
  Warn,
  Error,
  Fatal,
}

// 按照属性、构造方法、类方法的顺序定义。  各个属性之间，先带final的属性，后静态属性，后常规属性。
class Logger {
  final int _fileSizeLimit = 30 * 1024 * 1024; // 30 * 1024 * 1024  bytes = 30M
  final String _logFileName = "cashbox.log";
  final String _logThreadName = "LogThread";

  LogLevel _filterLevel = LogLevel.Debug;
  SendPort? _sendPort;

  static Logger? _instance;

  factory Logger() => _instance ??= Logger._logger();

  Logger._logger();

  static Logger getInstance() {
    return _instance ??= Logger();
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
    if (_sendPort == null) {
      try {
        // First time register ok, return ok. Next duplicated register will return false;
        bool onceRegisterOk = IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
        if (onceRegisterOk) {
          _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
        }
      } catch (e) {
        print("error!  register thread procedure, error detail is --->" + e.toString());
      }
    }

    rPort.listen((message) async {
      try {
        File? mainLogFile = (await _logFile(_logFileName));
        if (mainLogFile == null) {
          return;
        }
        if (mainLogFile.lengthSync() > _fileSizeLimit) {
          File? backupLogFile = await _logFile(_logFileName + ".backup");
          if (backupLogFile == null) {
            return;
          }
          // file name exchange with a temporary fileName.   such as: t=a,a=b,b=t;
          File tempFile = mainLogFile.renameSync(mainLogFile.path + ".backup.temp");
          mainLogFile = backupLogFile.renameSync(mainLogFile.path);
          mainLogFile.writeAsStringSync(""); // clear the file
          backupLogFile = tempFile.renameSync(mainLogFile.path + ".backup");
        }
        mainLogFile.writeAsStringSync(message, flush: true, mode: FileMode.append);
      } catch (e) {
        print("printOut error is --->" + e.toString());
      }
    });
  }

  Future<File?> _logFile(String fileName) async {
    //todo 有大量的初始工作，放到一个地方统一初始化
    String directoryPath = "";
    if (Platform.isWindows) {
      directoryPath = pathLib.current;
    } else {
      Directory directory = (await getExternalStorageDirectory())!; // path:  Android/data/
      directoryPath = directory.path;
    }
    String filePath = directoryPath + "/" + fileName;
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

  void d(String tag, String message) async {
    doRecordAndPrint(LogLevel.Debug, tag, message);
  }

  void i(String tag, String message) {
    doRecordAndPrint(LogLevel.Info, tag, message);
  }

  void w(String tag, String message) {
    doRecordAndPrint(LogLevel.Warn, tag, message);
  }

  void e(String tag, String message) {
    doRecordAndPrint(LogLevel.Error, tag, message);
  }

  void f(String tag, String message) {
    doRecordAndPrint(LogLevel.Fatal, tag, message);
  }

  void doRecordAndPrint(LogLevel logLevel, String tag, String message) {
    if (getLogLevel().index <= logLevel.index) {
      var recordInfo = logLevel.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
      print(recordInfo);
      sendToLogThread(recordInfo);
    }
  }

  void sendToLogThread(String recordInfo) {
    if (_sendPort == null) {
      _registerAndListeningLogThread();
      _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    }
    _sendPort?.send(recordInfo);
  }
}
