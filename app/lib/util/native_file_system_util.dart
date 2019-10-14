import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeFileSystemUtils {
  static const methodPlugin = const MethodChannel('file_system_channel');

  factory NativeFileSystemUtils() => _getInstance();

  static NativeFileSystemUtils get instance => _getInstance();
  static NativeFileSystemUtils _instance;

  NativeFileSystemUtils._internal() {
    //init data
  }

  static NativeFileSystemUtils _getInstance() {
    if (_instance == null) {
      _instance = new NativeFileSystemUtils._internal();
    }
    return _instance;
  }

  Future<String> getFileSystem() async {
    String filePath = await methodPlugin.invokeMethod('file_system_method');
    print("filePath is ============>" + filePath);
    if (filePath.isEmpty) {
      filePath = "";
    }
    return filePath;
  }
}
