import 'package:app/configv/config/config.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'log_util.dart';

class QrScanUtil {
  static const methodPlugin = const MethodChannel('qr_scan_channel');

  //Factory singleton class implementation
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
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  checkByScryCityTransfer(String qrInfo, BuildContext context) {
    if (qrInfo.isEmpty) {
      Fluttertoast.showToast(msg: translate('qr_info_is_null'));
      return null;
    }
    //--------------------------Assemble the parameters in the url-----------------------
    var paramIndex = qrInfo.indexOf("?");
    if (paramIndex <= 0 || paramIndex == qrInfo.length - 1) {
      Fluttertoast.showToast(msg: translate('qr_info_is_wrong')); //Not in the message? Or just one?
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
        var value = oneParamStr.toString().substring(oneParamIndex + 1, oneParamStr.length);
        paramsMap[key] = value;
      }
    });
    if (paramsMap.isEmpty) {
      Fluttertoast.showToast(msg: translate('qr_info_is_wrong')); //Not in the message? Or just one?
      return null;
    }
    //--------------------------Check parameters-----------------------
    print("paramsMap======>" + paramsMap.toString());
    print("begin verify timestamp======>");
    if (!paramsMap.containsKey("tl") || !verifyTimeStamp(paramsMap["tl"])) {
      Fluttertoast.showToast(msg: translate('qr_info_is_out_of_date'));
      return null; //There is a problem with the validity period
    }
    print("begin verify chainType======>");
    if (!paramsMap.containsKey("ct") || paramsMap["ct"] != "60") {
      Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
      return null; //Don't know which chain
    }
    print("begin verify ot======>");
    if (!paramsMap.containsKey("ot") || paramsMap["ot"] != "t") {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return null; //Don't know what to do
    }

    // print("begin verify contract address======>");
    // if (!paramsMap.containsKey("ca") || paramsMap["ca"].toLowerCase() != DddTestNetContractAddress.toLowerCase()) {
    //   Fluttertoast.showToast(msg: "合约地址不匹配");
    //   return null; //Don't know what to do
    // }

    print("begin verify To Address======>");
    if (!paramsMap.containsKey("ta")) {
      Fluttertoast.showToast(msg: "缺少转账目的地址");
      return null; //Don't know what to do
    }

    print("begin verify values======>");
    if (!paramsMap.containsKey("v") || double.parse(paramsMap["v"]) < 0) {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return null; //Not sure how much to transfer
    }

    var toAddress = paramsMap["ta"];
    var contractAddress = paramsMap["ca"];
    var backup = paramsMap["bu"];
    var value = paramsMap["v"];
    Provider.of<TransactionProvide>(context)
      ..setContractAddress(contractAddress)
      ..setToAddress(toAddress)
      ..setValue(value)
      ..setBackup(backup);
    {
      NavigatorUtils.push(context, Routes.transferEthPage);
    }
  }

  Map checkQrInfoByDiamondSignAndQr(String qrInfo, BuildContext context) {
    if (qrInfo.isEmpty) {
      Fluttertoast.showToast(msg: translate('qr_info_is_null'));
      return null;
    }
    //------------Assemble the parameters in the url------------
    var paramIndex = qrInfo.indexOf("?");
    if (paramIndex <= 0 || paramIndex == qrInfo.length - 1) {
      Fluttertoast.showToast(msg: translate('qr_info_is_wrong')); //Not in the message? Or just one?
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
      Fluttertoast.showToast(msg: translate('qr_info_is_wrong')); //Not in the message? Or just one?
      return null;
    }
    //------------Check parameters------------
    print("begin verify timestamp======>");
    if (!paramsMap.containsKey("tl") || !verifyTimeStamp(paramsMap["tl"])) {
      Fluttertoast.showToast(msg: translate('qr_info_is_out_of_date'));
      return null; //There is a problem with the validity period
    }
    print("begin verify chainType======>");
    if (!paramsMap.containsKey("ct")) {
      Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
      return null; //Don't know which chain
    }
    print("begin verify v======>");
    if (!paramsMap.containsKey("v")) {
      //Fluttertoast.showToast(msg: translate('not_sure_operation_type);
      return null; //Don't know what the content is
    }
    print("begin verify ot======>");
    if (!paramsMap.containsKey("ot")) {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return null; //Don't know what to do
    }
    var operationType = paramsMap["ot"];
    if (operationType == "ds" && paramsMap.containsKey("dtt") && paramsMap.containsKey("v")) {
      //Confirm that it is a signature type and the information is sufficient
      return paramsMap;
    }
    return null;
  }

  //Signature abandon (redesigned to give you a single, scanning function class is only responsible for scanning code)
  doSignTx(Map paramsMap, BuildContext context) {
    var chainType = paramsMap["ct"];
    switch (chainType) {
      case "0": //BTC
        break;
      case "60": //ETH
        break;
      case "66": //substrate chain
        if (paramsMap.containsKey("dt") && paramsMap["dt"] == "0") {
          //0 represents the diamond project
          var dtt = paramsMap["dtt"]; //Signature operation type ID 01: authorized original address 02: authorized salesperson
          var value = paramsMap["v"]; //Transaction information to be signed
          var waitToSignInfo = dtt + value; //Transaction information to be signed
          Fluttertoast.showToast(msg: "waitToSignInfo is ===>" + waitToSignInfo);
          print("wait to sign info is=======>" + waitToSignInfo);
          Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitToSignInfo);
        } else {
          var waitSignTx = paramsMap["v"]; //Transaction information to be signed
          Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitSignTx);
        }
        NavigatorUtils.push(context, Routes.signTxPage);
        paramsMap = null; //Blank scan data
        break;
      default:
        Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
        LogUtil.e("QrScanUtil", "unknown chainType ======>" + chainType);
        break;
    }
  }

  bool verifyTimeStamp(String qrTimeStamp) {
    if (qrTimeStamp.isEmpty) {
      return false; //There is a problem with the time stamp，
    }
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch; //Current timestamp
    int qrTime = int.parse(qrTimeStamp);
    print("qrTimeStamp===>" + qrTimeStamp + " || nowTimeStamp===>" + nowTimeStamp.toString());
    if (qrTime * 1000 > nowTimeStamp) {
      return true; //The data is normal and still within the validity period
    }
    return false;
  }
}
