import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
//todo 1 从使用的包来看，没有flutter 是否可以去掉对flutter的依赖 2 readme中说日志文件是可选的，实现是不可选
enum LogLevel {
  Debug,
  Info,
  Warn,
  Error,
  Fatal,
}
//todo enum与int的转换，使用dart自身提供的方式，更为简单，也不会有常量出现
extension LogLevelEx on LogLevel {
  static int getLevelValue(LogLevel curLevel) {
    switch (curLevel) {
      case LogLevel.Debug:
        return 0;
      case LogLevel.Info:
        return 1;
      case LogLevel.Warn:
        return 2;
      case LogLevel.Error:
        return 3;
      case LogLevel.Fatal:
        return 4;
      default:
        return 0;
    }
  }
}
//todo 1 名字？, 2 可以不定义这个类型吗？
class InfoModel {
  String message;
}

//todo 字段方法之间的先后顺序，混乱。我们明确一个先后，写入规范中
class Logger {
  final String _logFileName = "cashbox.log";
  final String _logThreadName = "LogThread";
  final int _fileSizeLimit = 30 * 1024 * 1024; // 30 * 1024 * 1024  bytes = 30M
  static LogLevel _filterLevel = LogLevel.Debug; //todo 单例中只需要一个static字段
  bool _isStartedLogThread = false; // is already start log thread
  SendPort _sendPort;//todo _sendPort == null 与 _isStartedLogThread字段含义一至，可以去掉 _isStartedLogThread

  factory Logger() => _getInstance();

  static Logger _instance;

  Logger._internal() {
    //init data //todo 值已经在字段定义时初始化了，没有需要初始的内容
  }

  static Logger getInstance() {
    return _getInstance();
  }

  static Logger _getInstance() {//todo 可以考虑去掉这个方法，只保留 getInstance方法
    if (_instance == null) {
      _instance = new Logger._internal();
    }
    return _instance;
  }

  // return Logger in order to chain style call
  // eg: Logger.setLogLevel(LogLevel.Error).d("tag","msg")
  Logger setLogLevel(LogLevel filterLevel) {//todo 实例方法直接修改静态字段，不合理
    _filterLevel = filterLevel;
    return this;
  }

  LogLevel getLogLevel() {
    return _filterLevel;
  }

  _registerAndListeningLogThread() async {
    final rPort = ReceivePort();

    if (!_isStartedLogThread) {
      // First time register ok, return ok. Next duplicated register will return false;
      bool onceRegisterOk = IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
      if (onceRegisterOk) {
        _isStartedLogThread = true;
      }//todo 如果出错怎么办？处理所有的出错
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
        if (mainLogFile.lengthSync() > _fileSizeLimit) {
          File backupLogFile = await _logFile(_logFileName + ".backup");
          if (backupLogFile == null) {
            return;
          }
          // file name exchange with a temporary fileName.   such as: t=a,a=b,b=a;//todo 这个过程多做了一次文件改名
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

  Future<File> _logFile(String fileName) async {//todo 有大量的初始工作，放到一个地方统一初始化
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

  _isMatchOutputLevel(LogLevel logLevel) {//todo 这个函数与 logLevel.index >= _filterLevel.index 功能类似，所以可以更简化
    if (LogLevelEx.getLevelValue(logLevel) >= LogLevelEx.getLevelValue(_filterLevel)) {//todo 从这里看 _filterLevel的类型为整数更为合适，如果想要看代码更方法，可以增加一个整数字段
      return true;
    }
    return false;
  }

  void d(String tag, String message) async {
    var recordInfo = LogLevel.Debug.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);//todo 控制台为什么不考虑 log level
    if (_isMatchOutputLevel(LogLevel.Debug)) {
      sendToLogThread(recordInfo);
    }
  }

  void i(String tag, String message) {//todo d i w ...等方法非常类似，可以再合并
    var recordInfo = LogLevel.Info.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);
    if (_isMatchOutputLevel(LogLevel.Info)) {
      sendToLogThread(recordInfo);
    }
  }

  void w(String tag, String message) {
    var recordInfo = LogLevel.Warn.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo);
    if (_isMatchOutputLevel(LogLevel.Warn)) {
      sendToLogThread(recordInfo);
    }
  }

  void e(String tag, String message) {
    var recordInfo = LogLevel.Error.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo); // show it on console terminal
    if (_isMatchOutputLevel(LogLevel.Error)) {
      sendToLogThread(recordInfo);
    }
  }

  void f(String tag, String message) {
    var recordInfo = LogLevel.Fatal.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    print(recordInfo); // show it on console terminal
    if (_isMatchOutputLevel(LogLevel.Fatal)) {
      sendToLogThread(recordInfo);
    }
  }

  void sendToLogThread(String recordInfo) {
    if (!_isStartedLogThread) {
      // case:  need save recordInfo to file and not yet register the log thread,
      //        here do register and listen the log thread
      _registerAndListeningLogThread();
    }
    if (_sendPort == null) {
      _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    }//todo 如果 _sendPort 为空时怎么办？
    _sendPort?.send(InfoModel()..message = recordInfo);
  }
}
