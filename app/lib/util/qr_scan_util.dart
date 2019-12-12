import 'package:app/generated/i18n.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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

  Map checkQrInfoByDiamondSignAndQr(String qrInfo, BuildContext context) {
    if (qrInfo.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_null);
      return null;
    }
    //------------拼装url里面的参数------------
    var paramIndex = qrInfo.indexOf("?");
    if (paramIndex <= 0 || paramIndex == qrInfo.length - 1) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_wrong); //信息里面没? 或者就一个?
      return null;
    }
    List paramsList = qrInfo.substring(paramIndex + 1).split("&");
    Map paramsMap = Map();
    paramsList.forEach((oneParamStr) {
      int oneParamIndex = oneParamStr.indexOf("=");
      if (oneParamIndex < 0) {
        return;
      }
      var key = oneParamStr.substring(0, oneParamIndex);
      if (!paramsMap.containsKey(key)) {
        var value = oneParamStr.toString().substring(oneParamStr.indexOf("=") + 1, oneParamStr.length);
        paramsMap[key] = value;
      }
    });

    if (paramsMap.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_wrong); //信息里面没? 或者就一个?
      return null;
    }
    //------------检查参数------------
    print("begin verify timestamp======>");
    if (!paramsMap.containsKey("tl") || !verifyTimeStamp(paramsMap["tl"])) {
      Fluttertoast.showToast(msg: S.of(context).qr_info_is_out_of_date);
      return null; //有效期有问题
    }
    print("begin verify chainType======>");
    if (!paramsMap.containsKey("ct")) {
      Fluttertoast.showToast(msg: S.of(context).not_sure_chain_type);
      return null; //不知道是哪条链
    }
    print("begin verify v======>");
    if (!paramsMap.containsKey("v")) {
      //Fluttertoast.showToast(msg: S.of(context).not_sure_operation_type);
      return null; //不知道内容是什么
    }
    print("begin verify ot======>");
    if (!paramsMap.containsKey("ot")) {
      Fluttertoast.showToast(msg: S.of(context).not_sure_operation_type);
      return null; //不知道要做什么操作
    }
    var operationType = paramsMap["ot"];
    if (operationType == "ds" && paramsMap.containsKey("dtt") && paramsMap.containsKey("v")) {
      //确认是签名类型，且信息足够
      return paramsMap;
    }
    return null;
  }

  //签名  abandon （重新设计，让给你单一，扫描功能类就只负责扫码）
  doSignTx(Map paramsMap, BuildContext context) {
    var chainType = paramsMap["ct"];
    switch (chainType) {
      case "0": //BTC
        break;
      case "60": //ETH
        break;
      case "66": //substrate链
        if (paramsMap.containsKey("dt") && paramsMap["dt"] == "0") {
          //0代表diamond项目
          var dtt = paramsMap["dtt"]; //签名操作类型 标识  01：授权原始地址  02：授权业务员
          var value = paramsMap["v"]; //待签名交易信息
          var waitToSignInfo = dtt + value; //待签名交易信息
          Fluttertoast.showToast(msg: "waitToSignInfo is ===>" + waitToSignInfo);
          print("wait to sign info is=======>" + waitToSignInfo);
          Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitToSignInfo);
        } else {
          var waitSignTx = paramsMap["v"]; //待签名交易信息
          Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitSignTx);
        }
        NavigatorUtils.push(context, Routes.signTxPage);
        paramsMap = null; //置空扫描数据
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
