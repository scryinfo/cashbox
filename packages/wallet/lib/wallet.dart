import 'dart:async';

import 'package:flutter/services.dart';

class Wallet {
  static const MethodChannel _channel =
      const MethodChannel('wallet');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  static String mnemonicGenerate(int count) {
    final String mnemonic = _channel.invokeMethod('mnemonicGenerate'); //todo
    return mnemonic;
  }

}
