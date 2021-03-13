import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/util/app_info_util.dart';
import 'package:logger/logger.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

Map<String, dynamic> _deviceData = <String, dynamic>{}; //Device Information
String appSignInfo; //Application signature information
String deviceId = ""; //Device unique ID
// Add parameters when accessing the background interface
// 1, device id deviceId
// 2, application signature information appSignInfo
Future requestWithDeviceId(String url, {formData}) async {
  if (_deviceData == null || _deviceData.length == 0 || _deviceData["id"] == null) {
    ///No device information record, go to get
    var deviceId = await AppInfoUtil.instance.getDeviceId();
    if (deviceId == null || deviceId == "") {
      return;
    }
  }
  if (appSignInfo == null || appSignInfo.trim() == "") {
    try {
      appSignInfo = await AppInfoUtil.instance.getAppSignInfo();
    } catch (e) {
      Logger().e("requestWithDeviceId request() error is", "${e}");
      return;
    }
  }
  if (formData == null) formData = {};
  formData["deviceId"] = deviceId;
  formData["signature"] = appSignInfo;
  return request(url, formData: formData);
}

Future requestWithConfigVersion(String url, {formData}) async {
  if (formData == null) formData = {};
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String apkVersion = packageInfo.version;
  formData["apkVersion"] = apkVersion;

  Config config = await HandleConfig.instance.getConfig();
  formData["appConfigVersion"] = config.privateConfig.configVersion;
  return requestWithDeviceId(url, formData: formData);
}

Future requestWithConfigCheckParam(String url, {formData}) async {
  if (formData == null) formData = {};
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String apkVersion = packageInfo.version;
  formData["apkVersion"] = apkVersion;

  Config config = await HandleConfig.instance.getConfig();
  formData["authTokenListVersion"] = config.privateConfig.authDigitVersion;
  formData["defaultTokenListVersion"] = config.privateConfig.defaultDigitVersion;
  formData["appConfigVersion"] = config.privateConfig.configVersion;

  return requestWithDeviceId(url, formData: formData);
}

//Access network request, url + parameter object
Future request(String url, {formData}) async {
  try {
    // print('开始获取数据...............' + url + "||formData :" + formData.toString());
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    //String cerData = await rootBundle.loadString("assets/crt.pem"); ///加入 可信证书 （可自签）

    //不验证证书实现方式
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    //print("formData ======>"+formData.toString());
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    // print("response===>" + response.toString());
    if (response.statusCode == 200) {
      // print("net 访问返回数据结果是：" + response.data.toString());
      return response.data;
    } else {
      print("后端接口出现异常，请检测代码和服务器情况.........");
      Logger().e("后端接口出现异常，请检测代码和服务器情况 ", url.toString());
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    Logger().e("net_util request() error is", "${e}");
    return print('ERROR:======>${e}');
  }
}

Future download(url, savePath) async {
  try {
    Response response;
    //Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await Dio().download(url, savePath);
    Logger().d("net_util download() response is", "${response}");
    return response;
  } catch (e) {
    Logger().e("net_util download() error is", "${e}");
  }
}
