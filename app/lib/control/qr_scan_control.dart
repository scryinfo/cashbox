import 'package:app/provide/sign_info_provide.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class QrScanControl {
  static const methodPlugin = const MethodChannel('qr_scan_channel');

  //Factory singleton class implementation
  factory QrScanControl() => _getInstance();

  static QrScanControl get instance => _getInstance();
  static final QrScanControl _instance = new QrScanControl._internal();

  QrScanControl._internal() {
    //init data
  }

  static QrScanControl _getInstance() {
    return _instance;
  }

  Future<String> qrscan() async {
    String callbackResult = await methodPlugin.invokeMethod('qr_scan_method');
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  bool checkByWcProtocol(String qrInfo, BuildContext context) {
    if (qrInfo.isEmpty) {
      Fluttertoast.showToast(msg: translate('qr_info_is_null'));
      return false;
    }
    if (!qrInfo.startsWith("wc:") || !qrInfo.contains("bridge") || !qrInfo.contains("key")) {
      return false;
    }
    return true;
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
    Logger.getInstance().i("paramsMap======>", paramsMap.toString());
    if (!paramsMap.containsKey("tl") || !verifyTimeStamp(paramsMap["tl"])) {
      Fluttertoast.showToast(msg: translate('qr_info_is_out_of_date'));
      return null; //There is a problem with the validity period
    }
    if (!paramsMap.containsKey("ct") || paramsMap["ct"] != "60") {
      Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
      return null; //Don't know which chain
    }
    if (!paramsMap.containsKey("ot") || paramsMap["ot"] != "t") {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return null; //Don't know what to do
    }

    // print("begin verify contract address======>");
    // if (!paramsMap.containsKey("ca") || paramsMap["ca"].toLowerCase() != DddTestNetContractAddress.toLowerCase()) {
    //   Fluttertoast.showToast(msg: "合约地址不匹配");
    //   return null; //Don't know what to do
    // }

    if (!paramsMap.containsKey("ta")) {
      Fluttertoast.showToast(msg: "缺少转账目的地址");
      return null; //Don't know what to do
    }

    if (!paramsMap.containsKey("v") || double.parse(paramsMap["v"]) < 0) {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return null; //Not sure how much to transfer
    }

    var toAddress = paramsMap["ta"];
    var contractAddress = paramsMap["ca"];
    var backup = paramsMap["bu"];
    var value = paramsMap["v"];
    context.read<TransactionProvide>()
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
      return {};
    }
    //------------Assemble the parameters in the url------------
    var paramIndex = qrInfo.indexOf("?");
    if (paramIndex <= 0 || paramIndex == qrInfo.length - 1) {
      Fluttertoast.showToast(msg: translate('qr_info_is_wrong')); //Not in the message? Or just one?
      return {};
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
      return {};
    }
    //------------Check parameters------------
    if (!paramsMap.containsKey("tl") || !verifyTimeStamp(paramsMap["tl"])) {
      Fluttertoast.showToast(msg: translate('qr_info_is_out_of_date'));
      return {}; //There is a problem with the validity period
    }
    if (!paramsMap.containsKey("ct")) {
      Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
      return {}; //Don't know which chain
    }
    if (!paramsMap.containsKey("v")) {
      //Fluttertoast.showToast(msg: translate('not_sure_operation_type);
      return {}; //Don't know what the content is
    }
    if (!paramsMap.containsKey("ot")) {
      Fluttertoast.showToast(msg: translate('not_sure_operation_type'));
      return {}; //Don't know what to do
    }
    var operationType = paramsMap["ot"];
    if (operationType == "ds" && paramsMap.containsKey("dtt") && paramsMap.containsKey("v")) {
      //Confirm that it is a signature type and the information is sufficient
      return paramsMap;
    }
    return {};
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
          var dtt =
              paramsMap["dtt"]; //Signature operation type ID 01: authorized original address 02: authorized salesperson
          var value = paramsMap["v"]; //Transaction information to be signed
          var waitToSignInfo = dtt + value; //Transaction information to be signed
          Fluttertoast.showToast(msg: "waitToSignInfo is ===>" + waitToSignInfo);
          context.read<SignInfoProvide>().setWaitToSignInfo(waitToSignInfo);
        } else {
          var waitSignTx = paramsMap["v"]; //Transaction information to be signed
          context.read<SignInfoProvide>().setWaitToSignInfo(waitSignTx);
        }
        NavigatorUtils.push(context, Routes.signTxPage);
        paramsMap = {}; //Blank scan data
        break;
      default:
        Fluttertoast.showToast(msg: translate('not_sure_chain_type'));
        Logger().e("QrScanControl", "unknown chainType ======>" + chainType);
        break;
    }
  }

  bool verifyTimeStamp(String qrTimeStamp) {
    if (qrTimeStamp.isEmpty) {
      return false; //There is a problem with the time stamp，
    }
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch; //Current timestamp
    int qrTime = int.parse(qrTimeStamp);
    if (qrTime * 1000 > nowTimeStamp) {
      return true; //The data is normal and still within the validity period
    }
    return false;
  }
}
