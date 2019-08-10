import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class WalletManager {
  static const MethodChannel _channel = const MethodChannel('wallet_manager');

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

  static Future<Map<dynamic, dynamic>> importWallet(
      mne, pwd, walletName) async {
    Map<dynamic, dynamic> wallet = await _channel.invokeMethod(
        'importWallet', {mne: mne, pwd: pwd, walletName: walletName});
    return wallet;
  }

  static Future<Map<dynamic, dynamic>> exportWallet(pwd, walletId) async {
    Map<dynamic, dynamic> wallet = await _channel
        .invokeMethod('importWallet', {pwd: pwd, walletId: walletId});
    return wallet;
  }

  static Future<Map<dynamic, dynamic>> getNowWallet() async {
    Map<dynamic, dynamic> nowWallet =
        await _channel.invokeMethod('getNowWallet');
    return nowWallet;
  }

  static Future<bool> setNowWallet(nowWallet) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('setNowWallet', {"nowWallet": nowWallet});
    return false;
  }

  static Future<Map<dynamic, dynamic>> getNowChain(String walletId) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('getNowChain');
    return allWalletList;
  }

  static Future<bool> setNowChain(chainType) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('setNowChain', {"chainType": chainType});
    return false;
  }

  static Future<Map<dynamic, dynamic>> saveWallet(
      String walletName, String pwd, Uint8List mnemonic) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'saveWallet',
        {"walletName": walletName, "pwd": pwd, "mnemonic": mnemonic});
    return null;
  }

  static Future<Map<dynamic, dynamic>> mnemonicSave(mnemonic, pwd) async {
    Map<dynamic, dynamic> allWalletList = await _channel
        .invokeMethod('mnemonicSave', {"mnemonic": mnemonic, "pwd": pwd});
    return null;
  }

  static Future<Map<dynamic, dynamic>> mnemonicExport(mnemonic, pwd) async {
    Map<dynamic, dynamic> allWalletList = await _channel
        .invokeMethod('mnemonicExport', {"mnemonic": mnemonic, "pwd": pwd});
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

  static Future<bool> rename(String walletName, String walletId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'addChain', {"walletName": walletName, "walletId": walletId});
    return null;
  }

  static Future<bool> resetPwd(String newPwd, String oldPwd) async {
    Map<dynamic, dynamic> allWalletList = await _channel
        .invokeMethod('resetPwd', {"newPwd": newPwd, "oldPwd": oldPwd});
    return null;
  }

  static Future<bool> showChain(walletId, chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'showChain', {"walletId": walletId, chainType: chainType});
    return null;
  }

  static Future<bool> hideChain(walletId, chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'deleteChain', {"walletId": walletId, chainType: chainType});
    return null;
  }

  static Future<bool> showDigit(walletId, chainId, digitId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'showDigit',
        {"walletId": walletId, "chainId": chainId, "digitId": digitId});
    return null;
  }

  static Future<bool> hideDigit(walletId, chainId, digitId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'hideDigit',
        {"walletId": walletId, "chainId": chainId, "digitId": digitId});
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
