import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class WalletAssist {
  static const MethodChannel _channel = const MethodChannel('walletassist');

  static Future<Mnemonic> mnemonicGenerate() async {
    Map<dynamic, dynamic> mneMap =
        await _channel.invokeMethod('mnemonicGenerate');
    Mnemonic mnemonic = new Mnemonic();
    mnemonic.mn = mneMap["mn"];
    mnemonic.mnId = mneMap["mnId"];
    mnemonic.status = mneMap["status"];
    return mnemonic;
  }
}

class Mnemonic {
  Uint8List mn;
  int mnId;
  int status;

  Mnemonic({this.mn, this.mnId, this.status});

  Mnemonic.fromJson(Map<String, dynamic> json) {
    mn = json['mn'];
    mnId = json['mnId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mn'] = this.mn;
    data['mnId'] = this.mnId;
    data['status'] = this.status;
    return data;
  }
}
