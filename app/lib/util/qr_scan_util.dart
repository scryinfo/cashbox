import 'package:flutter/services.dart';

import 'log_util.dart';

class QrScanUtil {
  static const methodPlugin = const MethodChannel('qr_scan_channel');

  static Future<String> qrscan() async {
    String callbackResult = await methodPlugin.invokeMethod('qr_scan_method');
    if (callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  static checkQrInfo(String qrInfo) {
    if (qrInfo.isEmpty) {
      return;
    }
    //拼好url里面的参数
    var paramIndex = qrInfo.indexOf("?");
    List paramsList = qrInfo.substring(paramIndex + 1).split("&");
    Map paramMap = Map();
    paramsList.forEach((oneParamStr) {
      var key = oneParamStr.substring(0, oneParamStr.indexOf("="));
      if (!paramMap.containsKey(key)) {
        var value = oneParamStr.toString().substring(oneParamStr.indexOf("="), oneParamStr.length);
        paramMap[key] = oneParamStr.substring(0, value);
      }
    });
    //检查参数
    if (!paramMap.containsKey("tl") || !verifyTimeStamp(paramMap["tl"])) {
      return; //有效期有问题
    }
    if (!paramMap.containsKey("ct")) {
      return; //不知道是哪条链
    }
    if (!paramMap.containsKey("ot")) {
      return; //不知道要做什么操作
    }
    var operationType = paramMap["ot"];
    switch (operationType) {
      case "t":
        break;
      case "ds":
        doSignTx(paramMap);
        break;
      default:
        LogUtil.e("QrScanUtil", "unknown operation type ======>" + operationType);
        break;
    }
  }

  //签名
  static doSignTx(Map paramMap) {
    var chainType = paramMap["ct"];
    switch (chainType) {
      case "0": //BTC
        break;
      case "60": //ETH
        break;
      case "66": //substrate链
        //todo 1、输入密码
        //todo 2、调用给substrate交易签名的JNI
        var waitSignTx = paramMap["v"]; //待签名交易信息
        break;
      default:
        LogUtil.e("QrScanUtil", "unknown chainType ======>" + chainType);
        break;
    }
  }

  static bool verifyTimeStamp(String qrTimeStamp) {
    if (qrTimeStamp.isEmpty) {
      return false; //时间戳有问题，
    }
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch; //当前时间戳
    int qrTime = int.parse(qrTimeStamp);
    if (qrTime > nowTimeStamp) {
      return true; //数据正常，且还在有效期内
    }
    return false;
  }
}
