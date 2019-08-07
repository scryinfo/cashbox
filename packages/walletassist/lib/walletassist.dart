import 'dart:async';

import 'package:flutter/services.dart';

class Walletassist {
  static const MethodChannel _channel = const MethodChannel('walletassist');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> mnemonicGenerate() async {
    final String mnemonicGenerate = await _channel.invokeMethod('mnemonicGenerate');
    return mnemonicGenerate;
  }
}
