import 'package:dio/dio.dart';
import 'dart:io';

Future request(url, {formData}) async {
  try {
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

Future download(url, savePath) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    response = await Dio().download(url, savePath);
    print("downloadHttp response==>" + response.toString());
    return response;
  } catch (e) {
    print("downloadHttp error is" + e);
  }
}
