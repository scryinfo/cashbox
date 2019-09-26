import 'package:app/generated/i18n.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'log_util.dart';

class QrScanUtil {
  static const methodPlugin = const MethodChannel('qr_scan_channel');

  //工厂单例类实现
  factory QrScanUtil() => _getInstance();

  static QrScanUtil get instance => _getInstance();
  static QrScanUtil _instance;

  QrScanUtil._internal() {
    //init data
  }

  static QrScanUtil _getInstance() {
    if (_instance == null) {
      _instance = new QrScanUtil._internal();
    }
    return _instance;
  }

  Future<String> qrscan() async {
    String callbackResult = await methodPlugin.invokeMethod('qr_scan_method');
    if (callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  checkQrInfo(String qrInfo, BuildContext context) {
    if (qrInfo.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_null);
      return;
    }
    //------------拼装url里面的参数------------
    var paramIndex = qrInfo.indexOf("?");
    if (paramIndex <= 0 || paramIndex == qrInfo.length - 1) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_wrong); //信息里面没? 或者就一个?
      return;
    }
    List paramsList = qrInfo.substring(paramIndex + 1).split("&");
    Map paramMap = Map();
    paramsList.forEach((oneParamStr) {
      int oneParamIndex = oneParamStr.indexOf("=");
      if (oneParamIndex < 0) {
        return;
      }
      var key = oneParamStr.substring(0, oneParamIndex);
      if (!paramMap.containsKey(key)) {
        var value = oneParamStr.toString().substring(oneParamStr.indexOf("=") + 1, oneParamStr.length);
        paramMap[key] = value;
      }
    });
    //------------检查参数------------
    print("begin verify timestamp======>");
    if (!paramMap.containsKey("tl") || !verifyTimeStamp(paramMap["tl"])) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_out_of_date);
      return; //有效期有问题
    }
    print("begin verify chainType======>");
    if (!paramMap.containsKey("ct")) {
      Fluttertoast.showToast(msg: S.of(context).not_sure_chain_type);
      return; //不知道是哪条链
    }
    print("begin verify ot======>");
    if (!paramMap.containsKey("ot")) {
      Fluttertoast.showToast(msg: S.of(context).not_sure_operation_type);
      return; //不知道要做什么操作
    }
    var operationType = paramMap["ot"];
    switch (operationType) {
      case "t":
        break;
      case "ds":
        print("begin to doSignTx======>");
        doSignTx(paramMap, context);
        break;
      default:
        Fluttertoast.showToast(msg: S.of(context).not_sure_operation_type);
        LogUtil.e("QrScanUtil", "unknown operation type ======>" + operationType);
        break;
    }
  }

  //签名
  doSignTx(Map paramMap, BuildContext context) {
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
        print("wait to sing info is======>" + waitSignTx);
        break;
      default:
        Fluttertoast.showToast(msg: S.of(context).not_sure_chain_type);
        LogUtil.e("QrScanUtil", "unknown chainType ======>" + chainType);
        break;
    }
  }

  bool verifyTimeStamp(String qrTimeStamp) {
    if (qrTimeStamp.isEmpty) {
      return false; //时间戳有问题，
    }
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch; //当前时间戳
    print("qrTimeStamp===>" + qrTimeStamp);
    print("qrTimeStamp===>" + qrTimeStamp.runtimeType.toString());
    int qrTime = int.parse(qrTimeStamp);
    if (qrTime > nowTimeStamp) {
      return true; //数据正常，且还在有效期内
    }
    return false;
  }
}
