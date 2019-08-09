import 'dart:async';
import 'package:flutter/services.dart';

class WalletAssist {
  static const MethodChannel _channel = const MethodChannel('walletassist');

  static Future<Map<dynamic, dynamic>> mnemonicGenerate(count) async {
    Map<dynamic, dynamic> mneMap =
        await _channel.invokeMethod('mnemonicGenerate', {"count": count});
    return mneMap;
  }

  static Future<Map<dynamic, dynamic>> loadAllWalletList() async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('loadAllWalletList');
    return allWalletList;
  }

  static Future<Map<dynamic, dynamic>> getNowWallet() async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('getNowWallet');
    return allWalletList;
  }

  static Future<bool> setNowWallet(nowWallet) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('setNowWallet', nowWallet);
    return false;
  }

  static Future<Map<dynamic, dynamic>> getNowChain() async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('getNowChain');
    return allWalletList;
  }

  static Future<bool> setNowChain(nowChain) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('setNowChain');
    return false;
  }

  static Future<Map<dynamic, dynamic>> createNewWallet() async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('createNewWallet');
    return null;
  }

  static Future<Map<dynamic, dynamic>> mnemonicSave(mnemonic, pwd) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('mnemonicSave', {mnemonic, pwd});
    return null;
  }

  static Future<Map<dynamic, dynamic>> mnemonicExport(mnemonic, pwd) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('mnemonicExport', {mnemonic, pwd});
    return null;
  }

  static Future<bool> deleteWallet(wallet) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('deleteWallet', wallet);
    return null;
  }

  static Future<bool> addChain(chain) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('addChain', chain);
    return null;
  }

  static Future<bool> deleteChain(chain) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('deleteChain', chain);
    return null;
  }

  static Future<bool> addDigit(digit) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('addDigit', digit);
    return null;
  }

  static Future<bool> addDigitList(digitlist) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('addDigitList', digitlist);
    return null;
  }

  static Future<bool> deleteDigit(digit) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('deleteDigit', digit);
    return null;
  }
}
