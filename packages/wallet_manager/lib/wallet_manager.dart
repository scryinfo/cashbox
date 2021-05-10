import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

/*
*   功能说明： WalletManager只负责 定义接口&&中转数据。
*   具体 数据内异常判断、数据获取，均由dart数据模型层再做处理。
*/
class WalletManager {
  static const MethodChannel _channel = const MethodChannel('wallet_manager');

  //代币查询 范围（名称 + 合约地址）
  static queryDigit(int chainType, String name, String contract_addr) async {
    Map<dynamic, dynamic> updateMap =
        await _channel.invokeMethod("queryDigit", {"chainType": chainType, "name": name, "contract_addr": contract_addr});
    return updateMap;
  }

  static cleanWalletsDownloadData() async {
    Map<dynamic, dynamic> cleanMap = await _channel.invokeMethod("cleanWalletsDownloadData");
    return cleanMap;
  }
}
