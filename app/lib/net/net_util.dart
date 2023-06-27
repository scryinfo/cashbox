import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/global.dart';
import 'package:logger/logger.dart';

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
