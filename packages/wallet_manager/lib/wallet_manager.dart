import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class WalletManager {
  static const MethodChannel _channel = const MethodChannel('wallet_manager');

  // 创建助记词，待验证正确通过，由底层创建钱包完成，应用层做保存
  // apiNo:MM00
  static Future<Map<dynamic, dynamic>> mnemonicGenerate(count) async {
    Map<dynamic, dynamic> mneMap =
        await _channel.invokeMethod('mnemonicGenerate', {"count": count});
    return mneMap;
  }

  // 是否已有钱包
  // apiNo:WM01
  static Future<bool> isContainWallet() async {
    Map<dynamic, dynamic> containMap =
        await _channel.invokeMethod('isContainWallet');
    var isContain = containMap["isContainWallet"];
    return isContain;
  }

  //从数据库 加载出 所有钱包数据
  //导出所有钱包
  // apiNo:WM02
  static Future<List<dynamic>> loadAllWalletList() async {
    List<dynamic> allWalletList =
        await _channel.invokeMethod('loadAllWalletList');
    return allWalletList;
  }

  // 保存钱包,钱包导入。  通过助记词创建钱包流程
  // apiNo:WM03
  static Future<Map<dynamic, dynamic>> saveWallet(String walletName,
      Uint8List pwd, Uint8List mnemonic, int walletType) async {
    Map<dynamic, dynamic> wallet = await _channel.invokeMethod('saveWallet', {
      "walletName": walletName,
      "pwd": pwd,
      "mnemonic": mnemonic,
      "walletType": walletType
    });
    print("saveWallet===>" + wallet["walletName"]);
    return null;
  }

  // 钱包导出。 恢复钱包
  // apiNo:WM04
  static Future<Map<dynamic, dynamic>> exportWallet(
      String walletId, Uint8List pwd) async {
    Map<dynamic, dynamic> wallet = await _channel
        .invokeMethod('exportWallet', {pwd: pwd, walletId: walletId});
    return wallet;
  }

  //获取当前钱包
  // apiNo:WM05
  static Future<String> getNowWallet() async {
    String nowWalletId = await _channel.invokeMethod('getNowWallet');
    return nowWalletId;
  }

  //设置当前钱包 bool是否成功
  //  apiNo:WM06
  static Future<bool> setNowWallet(String walletId) async {
    bool isSuccess =
        await _channel.invokeMethod('setNowWallet', {"walletId": walletId});
    return isSuccess;
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

  //删除钱包。 钱包设置可删除，链设置隐藏。
  // apiNo:WM07
  static Future<bool> deleteWallet(String walletId) async {
    bool isSuccess =
        await _channel.invokeMethod('deleteWallet', {"walletId": walletId});
    return isSuccess;
  }

  // 重置钱包密码。
  // apiNo:WM08
  static Future<bool> resetPwd(
      String walletId, Uint8List newPwd, Uint8List oldPwd) async {
    print("begin to resetPwd==>");
    bool isSuccess = await _channel.invokeMethod(
        'resetPwd', {"walletId": walletId, "newPwd": newPwd, "oldPwd": oldPwd});
    return isSuccess;
  }

  // 重置钱包名
  // apiNo:WM09
  static Future<bool> rename(String walletName, String walletId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'rename', {"walletName": walletName, "walletId": walletId});
    return null;
  }

  // 显示链
  // apiNo:WM10
  static Future<bool> showChain(String walletId, int chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'showChain', {"walletId": walletId, "chainType": chainType});
    return null;
  }

  // 隐藏链
  // apiNo:WM11
  static Future<bool> hideChain(String walletId, int chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'deleteChain', {"walletId": walletId, "chainType": chainType});
    return null;
  }

  // 获取当前链
  // apiNo:WM12
  static Future<Map<dynamic, dynamic>> getNowChain(String walletId) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('getNowChain');
    return allWalletList;
  }

  // 设置当前链
  // apiNo:WM13
  static Future<bool> setNowChain(String walletId, int chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'setNowChain', {"walletId": walletId, "chainType": chainType});
    return false;
  }

  // 显示代币
  // apiNo:WM14
  static Future<bool> showDigit(
      String walletId, String chainId, String digitId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'showDigit',
        {"walletId": walletId, "chainId": chainId, "digitId": digitId});
    return null;
  }

  // 隐藏代币
  // apiNo:WM15
  static Future<bool> hideDigit(
      String walletId, String chainId, String digitId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod(
        'hideDigit',
        {"walletId": walletId, "chainId": chainId, "digitId": digitId});
    return null;
  }

  // 添加代币 todo 2.0 待确定数据格式
  static Future<bool> addDigit(digit) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('addDigit', digit);
    return null;
  }

  // 添加代币list todo 2.0 待确定数据格式
  static Future<bool> addDigitList(digitlist) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('addDigitList', digitlist);
    return null;
  }

  // 删除代币 todo 2.0 待确定数据格式
  static Future<bool> deleteDigit(digit) async {
    Map<dynamic, dynamic> allWalletList =
        await _channel.invokeMethod('deleteDigit', digit);
    return null;
  }
}
