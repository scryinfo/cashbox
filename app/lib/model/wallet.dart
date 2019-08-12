import 'dart:typed_data';
import 'Chain.dart';
import 'package:wallet_manager/wallet_manager.dart';

class Wallet {
  String walletId; //钱包Id
  String walletName; //钱包名

  Uint8List mnemonic; //助记词,                  /* 参数传递，及时释放*/
  Uint8List secretKey; //私钥                    /* 参数传递，及时释放*/
  String jsonFilePath; //私钥加密文件jsonFile路径
  String creationTime; //钱包创建时间
  List<Chain> chainList; //钱包内包含链列表
  Chain nowChain;

  //todo load chain

  // 重置钱包密码
  // apiNo:WM08
  Future<bool> resetPwd(String newPwd, String oldPwd) async {
    var isSuccess = await WalletManager.resetPwd(walletId, newPwd, oldPwd);
    return null;
  }

  // 重置钱包名
  // apiNo:WM09
  Future<bool> rename(String walletName) async {
    //todo 数据格式
    var isSuccess = await WalletManager.rename(walletId, walletName);
    return null;
  }

  // 显示链
  // apiNo:WM10
  Future<bool> showChain(int chainType) async {
    var isSuccess = await WalletManager.showChain(walletId, chainType);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return isSuccess;
  }

  // 隐藏链
  // apiNo:WM11
  Future<bool> hideChain(int chainType) async {
    var isSuccess = await WalletManager.hideChain(walletId, chainType);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return null;
  }

  // 获取当前链
  // apiNo:WM12
  Future<Chain> getNowChain() async {
    var allWalletList = await WalletManager.getNowChain(walletId);
    // todo 数据格式转换，返回
    return null;
  }

  // 设置当前链
  // apiNo:WM13
  Future<bool> setNowChain(int chainType) async {
    var isSuccess = await WalletManager.setNowChain(walletId, chainType);
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowChain = nowChain;
    }
    return isSuccess;
  }
}
