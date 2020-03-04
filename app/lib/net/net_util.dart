import 'package:app/util/log_util.dart';
import 'package:dio/dio.dart';
import 'dart:io';

Future request(String url, {formData}) async {
  try {
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    print("response===>" + response.toString());
    if (response.statusCode == 200) {
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
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await Dio().download(url, savePath);
    print("downloadHttp response==>" + response.toString());
    LogUtil.d("net_util download() response is", "${response}");
    return response;
  } catch (e) {
    LogUtil.e("net_util download() error is", "${e}");
    print("downloadHttp error is" + e);
  }
}
