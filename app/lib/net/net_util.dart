import 'dart:io';

import 'package:app/util/log_util.dart';
import 'package:dio/dio.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
Map<String, dynamic> _deviceData = <String, dynamic>{};

Future requestWithDeviceId(String url, {formData}) async {
  if (_deviceData != null && _deviceData.length > 0) {
    ///有设备信息记录
  } else {
    ///没有设备信息记录，去获取
    try {
      if (Platform.isAndroid) {
        _deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      _deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
  }
  //todo 应用签名信息
  ///
  ///
}

Future request(String url, {formData}) async {
  try {
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
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
    Dio dio = new Dio();
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
