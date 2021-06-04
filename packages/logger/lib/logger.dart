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
  static SendPort? _sendPort;
  static Logger? _instance;

  LogLevel _filterLevel = LogLevel.Debug;

  factory Logger() {
    // add judge whether _sendPort is null
    // that is aim to avoid the case that only initialize instance ok while _registerAndListeningLogThread() failure
    // 加入判断_sendPort，防止instance初始化好了，但注册方法失败了.
    if (_instance == null || _sendPort == null) {
      _instance = Logger._logger();
    }
    return _instance!;
  }

  Logger._logger() {
    _registerAndListeningLogThread();
  }

  static Logger getInstance() {
    return Logger();
  }

  // return Logger in order to chain style call
  // eg: Logger.setLogLevel(LogLevel.Error).d("tag","msg")
  // note that : only change current thread's LogLevel, when it comes to multi-threads, set this value individual
  Logger setLogLevel(LogLevel filterLevel) {
    _filterLevel = filterLevel;
    return this;
  }

  LogLevel getLogLevel() {
    return _filterLevel;
  }

  _registerAndListeningLogThread() async {
    if (_sendPort != null) {
      return;
    }
    // note that: use _sendPort as a flag to check whether ReceivePort has already registered
    // if _sendPort!=null that means lookupPortByName() is ok and registerPortWithName() procedure has already finished
    _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    // make sure only multiThread register once and register to same port
    if (_sendPort != null) {
      return;
    }
    ReceivePort rPort = ReceivePort();
    try {
      // First time register ok, return ok. Next duplicated register will return false;
      bool onceRegisterOk = IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
      if (!onceRegisterOk) {
        // register failure or double register
        rPort.close();
        return;
      }
      _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    } catch (e) {
      rPort.close();
      _sendPort = null;
      print("error!  register thread procedure, error detail is --->" + e.toString());
      return;
    }
    rPort.listen(_writeMsgToFile);
  }

  _writeMsgToFile(message) async {
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
      mainLogFile.writeAsStringSync(message, flush: true, mode: FileMode.append); //flush : true --- avoid missing cache,we'd better play it safe
    } catch (e) {
      print("printOut error is --->" + e.toString());
    }
  }

  Future<File?> _logFile(String fileName) async {
    String directoryPath = "";
    if (Platform.isWindows) {
      directoryPath = pathLib.current;
    } else {
      Directory directory = (await getExternalStorageDirectory())!; // path:  Android/data/
      directoryPath = directory.path;
    }
    String filePath = pathLib.join(directoryPath, fileName);
    try {
      var objFile = File(filePath);
      if (!objFile.existsSync()) {
        objFile.createSync();
      }
      return objFile;
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
      print("sendToLogThread failure，_sendPort==null");
      return;
    }
    _sendPort?.send(recordInfo);
  }
}
