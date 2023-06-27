import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'config.dart';

class HandleConfig {
  factory HandleConfig() => _getInstance();

  static HandleConfig get instance => _getInstance();
  static late HandleConfig _instance;
  static String configDocumentPath = "/scry";
  static String configFileName = "config.json";
  static String defaultConfigFilePath = "assets/config/config.json";

  HandleConfig._internal() {
    //
  }

  static HandleConfig _getInstance() {
    if (_instance == null) {
      _instance = new HandleConfig._internal();
    }
    return _instance;
  }

  Future<Config> getConfig() async {
    File file = await _getConfigFile(configFileName);
    Config config = Config();
    try {
      String fileContent = await file.readAsString();
      Map<String, dynamic> configMap = jsonDecode(fileContent);
      config = Config.fromJson(configMap);
      return config;
    } catch (e) {
      file.writeAsString("", flush: true);
      return config;
    }
  }

  Future<bool> saveConfig(final Config config) async {
    if (config == null) {
      return false;
    }
    try {
      File file = await _getConfigFile(configFileName);
      String fileString = jsonEncode(config.toJson());
      file.writeAsStringSync(fileString, flush: true);
    } catch (e) {
      Logger.getInstance().e("saveConfig", "error info is" + e.toString());
      return false;
    }
    return true;
  }

  // 更新Config里面的vendorConfig，如果参数不为空则更新，为空则不覆盖更新。
  Future<bool> addOrUpdateVendorConfig(final String jsonString) async {
    if (jsonString == null) {
      return false;
    }
    try {
      Config config = await this.getConfig();
      var applyMap = config.privateConfig.toJson();
      PrivateConfig.fromJson(json.decode(jsonString)).toJson().forEach((key, value) {
        if (key.isNotEmpty && value != null && value != "") {
          applyMap[key] = value;
        }
      });
      config.privateConfig = PrivateConfig.fromJson(applyMap);
      this.saveConfig(config);
    } catch (e) {
      return false;
    }
    return true;
  }

  // 获取Config配置文件
  Future<File> _getConfigFile(String fileName) async {
    String docPath = await _getDirectoryPath();
    final filePath = docPath + "/" + fileName;
    File file = File(filePath);
    if (!file.existsSync() || file.lengthSync() <= 0) {
      file.createSync();
      String jsonStr = await rootBundle.loadString(defaultConfigFilePath);
      file.writeAsStringSync(jsonStr, flush: true); // creates the file for writing and truncates
    }
    return file;
  }

  // Config配置文件的文件夹路径
  Future<String> _getDirectoryPath() async {
    final filepath = await getApplicationDocumentsDirectory();
    var file = Directory(filepath.path + configDocumentPath);
    try {
      bool exists = file.existsSync();
      if (!exists) {
        file.createSync();
      }
    } catch (e) {
      Logger().e("_getDirectoryPath ", e.toString());
    }
    return file.path;
  }
}
