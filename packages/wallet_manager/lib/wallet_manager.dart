import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

/*
*   功能说明： WalletManager只负责 定义接口&&中转数据。
*   具体 数据内异常判断、数据获取，均由dart数据模型层再做处理。
*/
class WalletManager {
  static const MethodChannel _channel = const MethodChannel('wallet_manager');

  // 创建助记词，待验证正确通过，由底层创建钱包完成，应用层做保存
  // apiNo:MM00
  static Future<Map<dynamic, dynamic>> mnemonicGenerate(count) async {
    Map<dynamic, dynamic> mneMap = await _channel.invokeMethod('mnemonicGenerate', {"count": count});
    return mneMap;
  }

  // 是否已有钱包
  // apiNo:WM01
  static Future<Map<dynamic, dynamic>> isContainWallet() async {
    Map<dynamic, dynamic> containMap = await _channel.invokeMethod('isContainWallet');
    return containMap;
  }

  static Future<Map<dynamic, dynamic>> initWalletBasicData() async {
    Map<dynamic, dynamic> containMap = await _channel.invokeMethod('initWalletBasicData');
    return containMap;
  }

  static Future<Map<dynamic, dynamic>> updateWalletDbData(String newVersion) async {
    Map<dynamic, dynamic> containMap = await _channel.invokeMethod('updateWalletDbData', {"newVersion": newVersion});
    return containMap;
  }

  //从数据库 加载出 所有钱包数据
  //导出所有钱包
  // apiNo:WM02
  static Future<List<dynamic>> loadAllWalletList() async {
    List<dynamic> allWalletList = await _channel.invokeMethod('loadAllWalletList');
    return allWalletList;
  }

  // 保存钱包,钱包导入。  通过助记词创建钱包流程
  // apiNo:WM03
  static Future<Map<dynamic, dynamic>> saveWallet(String walletName, Uint8List pwd, Uint8List mnemonic, int walletType) async {
    Map<dynamic, dynamic> isSuccessMap =
        await _channel.invokeMethod('saveWallet', {"walletName": walletName, "pwd": pwd, "mnemonic": mnemonic, "walletType": walletType});
    return isSuccessMap;
  }

  // 钱包导出。 恢复钱包
  // apiNo:WM04
  static Future<Map<dynamic, dynamic>> exportWallet(String walletId, Uint8List pwd) async {
    Map<dynamic, dynamic> mnemonicMap = await _channel.invokeMethod('exportWallet', {"pwd": pwd, "walletId": walletId});
    return mnemonicMap;
  }

  //设置当前钱包 bool是否成功
  //  apiNo:WM06
  static Future<Map<dynamic, dynamic>> setNowWallet(String walletId) async {
    Map<dynamic, dynamic> isSetNowWalletMap = await _channel.invokeMethod('setNowWallet', {"walletId": walletId});
    return isSetNowWalletMap;
  }

  // 重置钱包密码。
  // apiNo:WM08
  static Future<Map> resetPwd(String walletId, Uint8List newPwd, Uint8List oldPwd) async {
    print("begin to resetPwd==>");
    Map resetPwdMap = await _channel.invokeMethod('resetPwd', {"walletId": walletId, "newPwd": newPwd, "oldPwd": oldPwd});
    return resetPwdMap;
  }

  // 重置钱包名
  // apiNo:WM09
  static Future<Map<dynamic, dynamic>> rename(String walletId, String walletName) async {
    Map<dynamic, dynamic> walletRenameMap = await _channel.invokeMethod('rename', {"walletId": walletId, "walletName": walletName});
    return walletRenameMap;
  }

  // 显示链
  // apiNo:WM10
  static Future<Map<dynamic, dynamic>> showChain(String walletId, int chainType) async {
    Map<dynamic, dynamic> showChainMap = await _channel.invokeMethod('showChain', {"walletId": walletId, "chainType": chainType});
    print("showChain  showChainMap=>" + showChainMap.toString());
    return showChainMap;
  }

  // 隐藏链
  // apiNo:WM11
  static Future<bool> hideChain(String walletId, int chainType) async {
    Map<dynamic, dynamic> hideChainMap = await _channel.invokeMethod('deleteChain', {"walletId": walletId, "chainType": chainType});
    print("hideChain  hideChainMap=>" + hideChainMap.toString());
    return null;
  }

  // 获取当前链
  // apiNo:WM12
  static Future<Map<dynamic, dynamic>> getNowChain(String walletId) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod('getNowChain');
    return allWalletList;
  }

  // 设置当前链
  // apiNo:WM13
  static Future<Map<dynamic, dynamic>> setNowChainType(String walletId, int chainType) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod('setNowChainType', {"walletId": walletId, "chainType": chainType});
    return allWalletList;
  }

  // 添加代币
  static Future<Map<dynamic, dynamic>> addDigit(String walletId, int chainType, String digitId) async {
    Map<dynamic, dynamic> addDigitMap = await _channel.invokeMethod('addDigit', {"walletId": walletId, "chainType": chainType, "digitId": digitId});
    return addDigitMap;
  }

  // 添加代币list todo 2.0 待确定数据格式
  static Future<bool> addDigitList(digitlist) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod('addDigitList', digitlist);
    return null;
  }

  // 删除代币 todo 2.0 待确定数据格式
  static Future<bool> deleteDigit(digit) async {
    Map<dynamic, dynamic> allWalletList = await _channel.invokeMethod('deleteDigit', digit);
    return null;
  }

  //转账 能量 fixed
  static Future<Map<dynamic, dynamic>> eeeEnergyTransfer(String from, Uint8List pwd, String to, String value, String extendMsg) async {
    Map<dynamic, dynamic> eeeEnergyMap =
        await _channel.invokeMethod('eeeEnergyTransfer', {"from": from, "pwd": pwd, "to": to, "value": value, "extendMsg": extendMsg});
    return eeeEnergyMap;
  }

  //信息签名
  static Future<Map<dynamic, dynamic>> eeeTxSign(String walletId, Uint8List pwd, String rawTx) async {
    Map<dynamic, dynamic> eeeTxSignMap = await _channel.invokeMethod("eeeTxSign", {"rawTx": rawTx, "mnId": walletId, "pwd": pwd});
    return eeeTxSignMap;
  }

  //Eth交易签名
  static Future<Map<dynamic, dynamic>> ethTxSign(String mnId, int chainType, String fromAddress, String toAddress, String contractAddress,
      String value, String backup, Uint8List pwd, String gasPrice, String gasLimit, String nonce,
      {int decimal = 18}) async {
    Map<dynamic, dynamic> ethTxSignMap = await _channel.invokeMethod("ethTxSign", {
      "mnId": mnId,
      "chainType": chainType,
      "fromAddress": fromAddress,
      "toAddress": toAddress,
      "contractAddress": contractAddress,
      "value": value,
      "backup": backup,
      "pwd": pwd,
      "gasPrice": gasPrice,
      "gasLimit": gasLimit,
      "nonce": nonce,
      "decimal": decimal
    });
    return ethTxSignMap;
  }

  //Eth raw 交易签名
  static Future<Map<dynamic, dynamic>> ethRawTxSign(String rawTx, int chainType, String fromAddress, Uint8List pwd) async {
    Map<dynamic, dynamic> ethRawTxSignMap = await _channel.invokeMethod("ethRawTxSign", {
      "rawTx": rawTx,
      "chainType": chainType,
      "fromAddress": fromAddress,
      "pwd": pwd,
    });
    return ethRawTxSignMap;
  }

  static Future<Map<dynamic, dynamic>> eeeSign(String walletId, Uint8List pwd, String rawTx) async {
    Map<dynamic, dynamic> eeeTxSignMap = await _channel.invokeMethod("eeeSign", {"rawTx": rawTx, "mnId": walletId, "pwd": pwd});
    return eeeTxSignMap;
  }

  static Future<Map<dynamic, dynamic>> eeeTransfer(String from, String to, String value, int index, Uint8List pwd) async {
    Map<dynamic, dynamic> eeeTxSignMap =
        await _channel.invokeMethod("eeeTransfer", {"from": from, "to": to, "value": value, "index": index, "pwd": pwd});
    return eeeTxSignMap;
  }

  static Future<Map<dynamic, dynamic>> tokenXTransfer(String from, String to, String value, String extData, int index, Uint8List pwd) async {
    Map<dynamic, dynamic> tokenXTxSignMap =
        await _channel.invokeMethod("tokenXTransfer", {"from": from, "to": to, "value": value, "extData": extData, "index": index, "pwd": pwd});
    return tokenXTxSignMap;
  }

  static decodeAdditionData(String input) async {
    Map<dynamic, dynamic> decodeMap = await _channel.invokeMethod("decodeAdditionData", {"input": input});
    return decodeMap;
  }

  static updateDigitBalance(String address, String digitId, String balance) async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("updateDigitBalance", {"address": address, "digitId": digitId, "balance": balance});
    return updateMap;
  }

  static decodeAccountInfo(String encodeData) async {
    Map<dynamic, dynamic> decodeMap = await _channel.invokeMethod("decodeAccountInfo", {"encodeData": encodeData});
    return decodeMap;
  }

  static eeeStorageKey(String module, String storageItem, String accountStr) async {
    Map<dynamic, dynamic> eeeStorageMap =
        await _channel.invokeMethod("eeeStorageKey", {"module": module, "storageItem": storageItem, "account_str": accountStr});
    return eeeStorageMap;
  }

  static getEeeSyncRecord() async {
    Map<dynamic, dynamic> syncRecordMap = await _channel.invokeMethod("getEeeSyncRecord");
    return syncRecordMap;
  }

  static updateEeeSyncRecord(String account, int chainType, int blockNum, String blockHash) async {
    Map<dynamic, dynamic> updateRecordMap = await _channel
        .invokeMethod("updateEeeSyncRecord", {"account": account, "chain_type": chainType, "block_num": blockNum, "block_hash": blockHash});
    return updateRecordMap;
  }

  static saveEeeExtrinsicDetail(String infoId, String account, String eventDetail, String blockHash, String extrinsics) async {
    Map<dynamic, dynamic> updateRecordMap = await _channel.invokeMethod("saveExtrinsicDetail",
        {"infoId": infoId, "accountId": account, "eventDetail": eventDetail, "blockHash": blockHash, "extrinsics": extrinsics});
    return updateRecordMap;
  }

  //在 当前钱包、当前链下，增加新代币的数据模型
  static addDigitToChainModel(String walletId, int chainType, String digitId) async {
    Map<dynamic, dynamic> decodeMap = await _channel.invokeMethod("addDigit", {"walletId": walletId, "chainType": chainType, "digitId": digitId});
    return decodeMap;
  }

  static loadEeeChainTxHistory(String account, String tokenName, int startIndex, int offset) async {
    Map<dynamic, dynamic> decodeMap = await _channel
        .invokeMethod("loadEeeChainTxListHistory", {"account": account, "tokenName": tokenName, "startIndex": startIndex, "offset": offset});
    return decodeMap;
  }

  //更新本地存储的 默认代币 列表（全量更新）
  static updateDefaultDigitList(String digitData) async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("updateDefaultDigitList", {"digitData": digitData});
    return updateMap;
  }

  //更新本地存储的 认证代币 列表（全量更新）
  static updateAuthDigitList(String digitData) async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("updateAuthDigitList", {"digitData": digitData});
    return updateMap;
  }

  // //本地 列表中 未经过认证的代币，如用户自编写的erc20。todo 现版本用不到
  // static getNativeUnAuthDigitList(int chainType, bool isAuth, int startIndex, int pageSize) async {
  //   Map<dynamic, dynamic> updateMap =
  //       await _channel.invokeMethod("getDigitList", {"chainType": chainType, "isAuth": false, "startIndex": startIndex, "pageSize": pageSize});
  //   return updateMap;
  // }

  // 获取本地认证代币列表  分页获取（startIndex + offset）
  static getNativeAuthDigitList(int chainType, int startIndex, int pageSize) async {
    Map<dynamic, dynamic> updateMap =
        await _channel.invokeMethod("getDigitList", {"chainType": chainType, "isAuth": true, "startIndex": startIndex, "pageSize": pageSize});
    return updateMap;
  }

  //代币查询 范围（名称 + 合约地址）
  static queryDigit(int chainType, String name, String contract_addr) async {
    Map<dynamic, dynamic> updateMap =
        await _channel.invokeMethod("queryDigit", {"chainType": chainType, "name": name, "contract_addr": contract_addr});
    return updateMap;
  }

  static btcStart() async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("btcStart");
    return updateMap;
  }

  static getSubChainBasicInfo(String genesisHash, int specVersion, int txVersion) async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("getSubChainBasicInfo", {
      "genesisHash": genesisHash,
      "specVersion": specVersion,
      "txVersion": txVersion,
    });
    return updateMap;
  }

  static updateSubChainBasicInfo(String infoId, int runtimeVersion, int txVersion, String genesisHash, String metadata, int ss58Format,
      int tokenDecimals, String tokenSymbol, bool isDefault) async {
    Map<dynamic, dynamic> updateMap = await _channel.invokeMethod("updateSubChainBasicInfo", {
      "infoId": infoId,
      "runtimeVersion": runtimeVersion,
      "txVersion": txVersion,
      "genesisHash": genesisHash,
      "metadata": metadata,
      "ss58Format": ss58Format,
      "tokenDecimals": tokenDecimals,
      "tokenSymbol": tokenSymbol,
      "isDefault": isDefault,
    });
    return updateMap;
  }

  static cleanWalletsDownloadData() async {
    Map<dynamic, dynamic> cleanMap = await _channel.invokeMethod("cleanWalletsDownloadData");
    return cleanMap;
  }
}
