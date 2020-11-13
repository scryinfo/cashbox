import 'dart:typed_data';

import 'package:app/util/log_util.dart';
import 'package:wallet_manager/wallet_manager.dart';

import 'chain.dart';

enum WalletType { TEST_WALLET, WALLET } //0,1  /*Mark: Definition needs to be consistent with JNI*/

class Wallet {
  int status; //Interface data, return status code
  String walletId; //Wallet Id
  String walletName; //Wallet name
  String accountMoney; // Current wallet Current chain Total token balance
  Uint8List mnemonic; //Mnemonic                 /* Parameter transfer, timely release*/
  Uint8List secretKey; //Private key             /* Parameter transfer, timely release*/
  String jsonFilePath; //Private key encrypted file jsonFile path
  String creationTime; //Wallet creation time
  List<Chain> chainList = []; //The wallet contains a list of chains
  List<Chain> visibleChainList = []; //List of visible chains
  String nowChainId; //In the wallet, the current chain chainId
  Chain nowChain;
  WalletType walletType;
  bool isNowWallet; //Whether it is the current wallet
  //todo load chain

  List<Chain> getVisibleChainList({bool isForceLoad = false}) {
    if (chainList == null || chainList.length == 0) {
      return [];
    }
    //visibleChainList have cache data
    if (!isForceLoad && (visibleChainList != null) && (visibleChainList.length > 0)) {
      return visibleChainList;
    }
    visibleChainList = [];
    chainList.forEach((element) {
      if (element.isVisible) {
        visibleChainList.add(element);
      }
    });
    return visibleChainList;
  }

  // Reset wallet password
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

  // Reset wallet name
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
      this.walletName = walletName; //The jni operation is complete, change the model
      return walletRenameMap["isRename"];
    } else {
      LogUtil.e("isContainWallet=>", "error status is=>" + walletRenameMap["status"].toString() + "||message is=>" + message.toString());
      return false;
    }
  }

  // Display chain
  // apiNo:WM10
  Future<bool> showChain(int chainType) async {
    Map showChainMap = await WalletManager.showChain(walletId, chainType);
    int status = showChainMap["status"];
    String message = showChainMap["message"];
    bool isShowChain = showChainMap["message"];
    return null;
  }

  // Hidden chain
  // apiNo:WM11
  Future<bool> hideChain(int chainType) async {
    var isSuccess = await WalletManager.hideChain(walletId, chainType);
    if (isSuccess) {
      //todo Data Format
      //chainList.remove(chain);
    }
    return null;
  }

  // Get the current chain
  // apiNo:WM12
  Future<ChainType> getNowChainType() async {
    Map getNowChainMap = await WalletManager.getNowChain(walletId);
    int status = getNowChainMap["status"];
    String message = getNowChainMap["message"];
    if (status == null) {
      LogUtil.e("getNowChain=>", "not find status code");
      return ChainType.UNKNOWN; //0===UNKNOWN
    }
    if (status == 200) {
      this.walletName = walletName; //The jni operation is complete, change the model
      ChainType chainType = Chain.intToChainType(getNowChainMap["getNowChainType"]);
      return chainType;
    } else {
      LogUtil.e("getNowChain=>", "error status is=>" + getNowChainMap["status"].toString() + "||message is=>" + message.toString());
      return ChainType.UNKNOWN; //0===UNKNOWN
    }
  }

  // Set current chain
  // apiNo:WM13
  Future<bool> setNowChainType(Chain chain) async {
    int chainTypeInt = Chain.chainTypeToInt(chain.chainType);
    Map setNowChainMap = await WalletManager.setNowChainType(walletId, chainTypeInt);
    int status = setNowChainMap["status"];
    bool isSetNowChain = setNowChainMap["isSetNowChain"];
    nowChain = chain;
    if (status == null) {
      return false;
    }
    if (status == 200) {
      return isSetNowChain;
    } else {
      LogUtil.e("setNowChainType message ===>", setNowChainMap["message"].toString());
      return false;
    }
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

  Chain getChainByChainType(ChainType chainType) {
    Chain nowChain;
    for (int i = 0; i < chainList.length; i++) {
      Chain chain = chainList[i];
      if (chain.chainType == chainType) {
        nowChain = chain;
        break;
      }
    }
    return nowChain;
  }

  Future<Chain> getNowChain() async {
    ChainType chainType = await getNowChainType();
    Chain chain = getChainByChainType(chainType);
    return chain;
  }
}
