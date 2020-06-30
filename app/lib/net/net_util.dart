import 'dart:convert';
import 'dart:io';

import 'package:app/util/app_info_util.dart';
import 'package:app/util/log_util.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
Map<String, dynamic> _deviceData = <String, dynamic>{}; //设备信息
String appSignInfo; //应用签名信息
String deviceId = ""; //设备唯一标识id

// 访问后台接口时，增加参数
// 1、设备id        deviceId
// 2、应用签名信息   appSignInfo
Future requestWithDeviceId(String url, {formData}) async {
  if (_deviceData == null || _deviceData.length == 0 || _deviceData["id"] == null) {
    ///没有设备信息记录，去获取
    try {
      if (Platform.isAndroid) {
        _deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        if (_deviceData != null) {
          deviceId = _deviceData["androidId"]; //目前各个android品台设备,唯一标识值，没有同意，暂取androidId这个值。
        }
      } else if (Platform.isIOS) {
        _deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      _deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
      LogUtil.e("requestWithDeviceId", "unknown target platform");
      return;
    } catch (e) {
      LogUtil.e("requestWithDeviceId", "${e}");
      return;
    }
  }
  if (appSignInfo == null || appSignInfo.trim() == "") {
    try {
      appSignInfo = await AppInfoUtil.instance.getAppSignInfo();
    } catch (e) {
      LogUtil.e("requestWithDeviceId request() error is", "${e}");
      return;
    }
  }
  formData["deviceId"] = deviceId;
  formData["signature"] = appSignInfo;
  return request(url, formData: formData);
}

//访问网络请求，url + 参数对象
Future request(String url, {formData}) async {
  try {
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    String cerData = await rootBundle.loadString("assets/ca.crt");  ///加入 可信证书 （可自签）
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      SecurityContext sc = new SecurityContext();
      sc.setTrustedCertificatesBytes(utf8.encode(cerData));
      HttpClient httpClient = new HttpClient(context: sc);
      return httpClient;
    };

    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    // print("response===>" + response.toString());
    if (response.statusCode == 200) {
      print("net 访问返回数据结果是：" + response.data.toString());
      return response.data;
    } else {
      print("后端接口出现异常，请检测代码和服务器情况.........");
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    LogUtil.e("net_util request() error is", "${e}");
    return print('ERROR:======>${e}');
  }
}

Future download(url, savePath) async {
  try {
    Response response;
    //Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await Dio().download(url, savePath);
    print("downloadHttp response==>" + response.toString());
    LogUtil.d("net_util download() response is", "${response}");
    return response;
  } catch (e) {
    LogUtil.e("net_util download() error is", "${e}");
    print("downloadHttp error is" + e);
  }
}

//记录android设备信息
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };
}

//记录ios设备信息
Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}
