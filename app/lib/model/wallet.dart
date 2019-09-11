import 'dart:typed_data';

import 'package:app/util/log_util.dart';
import 'package:wallet_manager/wallet_manager.dart';

import 'chain.dart';

enum WalletType { TEST_WALLET, WALLET } //0,1

class Wallet {
  int status; //接口数据，返回状态码
  String walletId; //钱包Id
  String walletName; //钱包名
  String money; //
  Uint8List mnemonic; //助记词,                  /* 参数传递，及时释放*/
  Uint8List secretKey; //私钥                    /* 参数传递，及时释放*/
  String jsonFilePath; //私钥加密文件jsonFile路径
  String creationTime; //钱包创建时间
  List<Chain> chainList = []; //钱包内包含链列表
  String nowChainId; //钱包内，当前链chainId
  WalletType walletType;
  bool isNowWallet; //是否是当前钱包
  //todo load chain

  // 重置钱包密码
  // apiNo:WM08
  Future<Map> resetPwd(Uint8List newPwd, Uint8List oldPwd) async {
    Map resetPwdMap = await WalletManager.resetPwd(walletId, newPwd, oldPwd);
    int status = resetPwdMap["status"];
    if (status == null) {
      LogUtil.e("resetPwd=>", "not find status code");
      return null;
    }
    if (status == 200) {
      return resetPwdMap;
    } else {
      String message = resetPwdMap["message"];
      LogUtil.e("isContainWallet=>", "error status is=>" + status.toString() + "||message is=>" + message.toString());
    }
    return resetPwdMap;
  }

  // 重置钱包名
  // apiNo:WM09
  Future<bool> rename(String walletName) async {
    Map walletRenameMap = await WalletManager.rename(walletId, walletName);
    int status = walletRenameMap["status"];
    String message = walletRenameMap["message"];
    if (status == null) {
      LogUtil.e("rename=>", "not find status code");
      return false;
    }
    if (status == 200) {
      this.walletName = walletName; //jni操作完成，更改model
      return walletRenameMap["isRename"];
    } else {
      LogUtil.e("isContainWallet=>", "error status is=>" + walletRenameMap["status"].toString() + "||message is=>" + message.toString());
      return false;
    }
  }

  // 显示链
  // apiNo:WM10
  Future<bool> showChain(int chainType) async {
    Map showChainMap = await WalletManager.showChain(walletId, chainType);
    print("showChain  showChainMap=>" + showChainMap.toString());
    int status = showChainMap["status"];
    String message = showChainMap["message"];
    bool isShowChain = showChainMap["message"];
    print("showChain  status=>" + status.toString());
    print("showChain  message=>" + message.toString());
    print("showChain  isShowChain=>" + isShowChain.toString());

    //if (isSuccess) {
    //todo 数据格式
    //chainList.remove(chain);
    //}
    return null;
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
      //todo
    }
    return isSuccess;
  }

  Chain getChainByChainId(String chainId) {
    Chain nowChain;
    for (int i = 0; i < chainList.length; i++) {
      Chain chain = chainList[i];
      if (chain.chainId == chainId) {
        nowChain = chain;
        break;
      }
    }
    return nowChain;
  }
}
