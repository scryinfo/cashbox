import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

enum Level {
  Debug,
  Info,
  Warn,
  Error,
}

class InfoModel {
  String fileName;
  String message;
  SendPort sendPort;
  bool isSaveToFile;
}

class Logger {
  static String _logFileName = "cashbox.log";
  final String _logThreadName = "LogThread";
  final int _fileSizeLimit = 30 * 1024 * 1024;
  SendPort _sendPort;

  factory Logger({String logFileName = "cashbox.log"}) => _getInstance(logFileName);

  static Logger _instance;

  Logger._internal(logFileName) {
    //init data
  }

  initConfig() async {
    final rPort = ReceivePort();
    IsolateNameServer.registerPortWithName(rPort.sendPort, _logThreadName);
    rPort.listen((message) async {
      if (!(message is InfoModel)) {
        return;
      }
      print(message.message); // show it on console terminal
      if (!message.isSaveToFile) {
        return;
      }
      try {
        File mainLogFile = await _logFile(message.fileName);
        if (mainLogFile == null) {
          return;
        }
        File backupLogFile = await _logFile(message.fileName + ".backup");
        if (backupLogFile == null) {
          return;
        }
        int mainLogFileLength = await mainLogFile.length();
        int backupLogFileLength = await backupLogFile.length();
        if (mainLogFileLength < _fileSizeLimit) {
          await mainLogFile.writeAsStringSync(message.message, flush: true, mode: FileMode.append);
          if (mainLogFileLength >= _fileSizeLimit) {
            await backupLogFile.writeAsString(""); // clear the file
          }
        } else if (backupLogFileLength < _fileSizeLimit) {
          await backupLogFile.writeAsStringSync(message.message, flush: true, mode: FileMode.append);
          if (backupLogFileLength >= _fileSizeLimit) {
            await mainLogFile.writeAsString(""); // clear the file
          }
        }
      } catch (e) {
        print("printOut error is --->" + e.toString());
      }
    });
  }

  static Logger _getInstance(String logFileName) {
    if (_instance == null || logFileName != _logFileName) {
      _logFileName = logFileName;
      _instance = Logger._internal(_logFileName);
    }
    return _instance;
  }

  Future<File> _logFile(String fileName) async {
    Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
    String filePath = directory.path + "/" + fileName;
    try {
      if (!await File(filePath).exists()) {
        File(filePath).create();
      }
      return File(filePath);
    } catch (e) {
      print("logFile error is " + e.toString());
      return null;
    }
  }

  void d(String tag, String message, {bool isSave2File = true}) async {
    var recordInfo = Level.Debug.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    sendToLogThread(recordInfo, isSave2File);
  }

  void i(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = Level.Info.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    sendToLogThread(recordInfo, isSave2File);
  }

  void w(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = Level.Warn.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    sendToLogThread(recordInfo, isSave2File);
  }

  void e(String tag, String message, {bool isSave2File = true}) {
    var recordInfo = Level.Error.toString() + "|" + DateTime.now().toString() + "|" + tag + ":" + message + "\n";
    sendToLogThread(recordInfo, isSave2File);
  }

  void sendToLogThread(String recordInfo, bool isSave2File) {
    _sendPort = IsolateNameServer.lookupPortByName(_logThreadName);
    _sendPort?.send(InfoModel()
      ..message = recordInfo
      ..isSaveToFile = isSave2File
      ..fileName = _logFileName);
  }
}
