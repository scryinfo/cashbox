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

  factory Logger() {//todo review factory Logger() 与 static Logger getInstance()功能一样，建议只保留 getInstance函数
    if (_instance == null) {
      _instance = Logger._logger();
    }
    return _instance ?? Logger._logger();//todo review 这里已经包含是否为空的判断，与上面的if 重复
  }

  Logger._logger() {
    _registerAndListeningLogThread();
  }

  static Logger getInstance() {
    return _instance ??= Logger();
  }

  // return Logger in order to chain style call
  // eg: Logger.setLogLevel(LogLevel.Error).d("tag","msg")
  Logger setLogLevel(LogLevel filterLevel) {//todo review,多线程下，此方法只修改当前线程的日志等级，可以在 rPort.listen((message) async {中实现
    _filterLevel = filterLevel;
    return this;
  }

  LogLevel getLogLevel() {
    return _filterLevel;
  }

  _registerAndListeningLogThread() async {
    _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);//todo review 把下面的条件判断提到，第一行来，如果有值就直接返回，没有必须再取一次
    // make sure only multiThread register once and register to same port
    if (_sendPort != null) {
      return;
    }
    ReceivePort rPort = ReceivePort();
    try {
      // First time register ok, return ok. Next duplicated register will return false;
      bool onceRegisterOk = IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
      if (onceRegisterOk) {
        _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
      }//todo review，else 分支时，需要 rPort.close()，且要返回
    } catch (e) {
      print("error!  register thread procedure, error detail is --->" + e.toString());//todo review 这里发生的不可恢复的错误，再运行会发生不确定的结果
    }
    rPort.listen((message) async {//todo review 没有创建线程，直接在当前线程中运行，rPort.sendPort与 _sendPort可能不相等
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
        mainLogFile.writeAsStringSync(message, flush: true, mode: FileMode.append);//todo review flush为false应该会有更好的性能
      } catch (e) {
        print("printOut error is --->" + e.toString());
      }
    });
  }

  Future<File?> _logFile(String fileName) async {
    String directoryPath = "";
    if (Platform.isWindows) {
      directoryPath = pathLib.current;
    } else {
      Directory directory = (await getExternalStorageDirectory())!; // path:  Android/data/
      directoryPath = directory.path;
    }
    String filePath = directoryPath + "/" + fileName;//todo review 建议使用 join方法，不使用“/”常量，可能会有是两个
    try {
      if (!File(filePath).existsSync()) //todo review 下面有三处理使用File(filePath)，定义一个变量
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
      _sendPort = IsolateNameServer.lookupPortByName(_logThreadName)//todo review 这里可以不用再使用 lookupPortByName，因为在构造时，做过一次。如果为空，可以增加控制台输出
    }
    _sendPort?.send(recordInfo);
  }
}
