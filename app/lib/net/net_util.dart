import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/app_info_control.dart';
import 'package:flutter_translate/global.dart';
import 'package:logger/logger.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
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
    var deviceId = await AppInfoControl.instance.getDeviceId();
    if (deviceId == null || deviceId == "") {
      return;
    }
  }
  if (appSignInfo == null || appSignInfo.trim() == "") {
    try {
      appSignInfo = await AppInfoControl.instance.getAppSignInfo();
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
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      Logger().e(translate('server_interface_error'), url.toString());
      throw Exception(translate('server_interface_error'));
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
