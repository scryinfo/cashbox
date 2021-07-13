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

  Future<String> approveLogIn(String addr) async {
    var approveLogIn = "approveLogIn";
    String callbackResult = await methodPlugin.invokeMethod(approveLogIn, {'addr': addr});
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  Future<String> approveTx(String id, String from, String to, String data, String gas, String gasPrice, String nonce) async {
    var approveTx = "approveTx";
    String callbackResult = await methodPlugin
        .invokeMethod(approveTx, {'id': id, 'from': from, 'to': to, 'data': data, 'gas': gas, 'gasPrice': gasPrice, 'nonce': nonce});
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }

  Future<String> rejectLogIn(String id) async {
    var rejectLogIn = "rejectLogIn";
    String callbackResult = await methodPlugin.invokeMethod(rejectLogIn, {'id': id});
    if (callbackResult == null || callbackResult.isEmpty) {
      callbackResult = "";
    }
    return callbackResult;
  }
}
