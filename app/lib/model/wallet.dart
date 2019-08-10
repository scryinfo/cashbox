import 'dart:typed_data';
import 'Chain.dart';
import 'package:wallet_manager/wallet_manager.dart';

class Wallet {
  String walletId; //钱包Id
  String walletName; //钱包名

  Uint8List mnemonic; //助记词,
  Uint8List secretKey; //私钥
  String jsonFilePath; //私钥加密文件jsonFile路径
  String creationTime; //钱包创建时间
  List<Chain> chainList; //钱包内包含链列表
  Chain nowChain;

  //todo load chain

  Future<bool> resetPwd(String newPwd, String oldPwd) async {
    var isSuccess = await WalletManager.resetPwd(newPwd, oldPwd);
    return null;
  }

  Future<bool> rename(String walletName) async {
    //todo 数据格式
    var isSuccess = await WalletManager.rename(walletName, walletId);

    return null;
  }

  Future<bool> addChain(chain) async {
    //todo 数据格式
    var isSuccess = await WalletManager.addChain(chain);
    if (isSuccess) {
      chainList.add(chain);
    }
    return isSuccess;
  }

  Future<bool> showChain(String chainType) async {
    var isSuccess = await WalletManager.showChain(walletId, chainType);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return isSuccess;
  }

  Future<bool> hideChain(chainType) async {
    var isSuccess = await WalletManager.hideChain(walletId, chainType);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return null;
  }

  //获取当前链
  Future<Chain> getNowChain() async {
    var allWalletList = await WalletManager.getNowChain(walletId);
    // todo 数据格式转换，返回
    return null;
  }

  //设置当前链
  Future<bool> setNowChain(chainType) async {
    var isSuccess = await WalletManager.setNowChain(chainType);
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowChain = nowChain;
    }
    return isSuccess;
  }
}
