import 'dart:typed_data';
import 'Chain.dart';
import 'package:walletassist/wallet_assist.dart';

class Wallet {
  String walletId; //钱包Id
  String walletName; //钱包名
  Uint8List mnemonic; //助记词
  Uint8List secretKey; //私钥
  String jsonFilePath; //私钥加密文件jsonFile路径
  String creationTime; //钱包创建时间
  List<Chain> chainList; //钱包内包含链列表

  Chain createNowWalletChain(chainType) {
    Chain chainCls = Chain();
    chainCls.walletId = walletId;
    switch (chainType) {
      case ChainType.ETH:
        chainCls.chainType = ChainType.ETH;
        break;
      case ChainType.BTC:
        chainCls.chainType = ChainType.BTC;
        break;
    }
    return chainCls;
  }

  Future<bool> addChain(chain) async {
    //todo 数据格式
    var isSuccess = await WalletAssist.addChain(chain);
    if (isSuccess) {
      chainList.add(chain);
    }
    return isSuccess;
  }

  Future<bool> deleteChain(chain) async {
    //todo 数据格式
    var isSuccess = await WalletAssist.deleteChain(chain);
    if (isSuccess) {
      chainList.remove(chain);
    }
    return isSuccess;
  }
}
