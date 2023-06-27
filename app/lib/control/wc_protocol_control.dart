import 'package:flutter/services.dart';

class WcProtocolControl {
  static const methodPlugin = const MethodChannel('wc_protocol_channel');

  factory WcProtocolControl() => getInstance();

  static WcProtocolControl _instance;

  WcProtocolControl._internal();

  static WcProtocolControl getInstance() {
    if (_instance == null) {
      _instance = new WcProtocolControl._internal();
    }
    return _instance;
  }

  Future<String> initSession(String qrInfo) async {
    var initSession = "initSession";
    return methodPlugin.invokeMethod(initSession, {'qrInfo': qrInfo});
  }

  Future<String> approveLogIn(String addr, String chainType) async {
    var approveLogIn = "approveLogIn";
    String callbackResult = await methodPlugin.invokeMethod(approveLogIn, {'addr': addr, "chainType": chainType});
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  Future<String> approveTx(String id, String data) async {
    var approveTx = "approveTx";
    String callbackResult = await methodPlugin.invokeMethod(approveTx, {'id': id, 'data': data});
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  Future rejectLogIn() async {
    var rejectLogIn = "rejectLogIn";
    await methodPlugin.invokeMethod(rejectLogIn);
  }

  Future<String> rejectTxReq(String txId) async {
    var rejectLogIn = "rejectTxReq";
    String callbackResult = await methodPlugin.invokeMethod(rejectLogIn);
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }
}
