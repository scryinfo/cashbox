import 'dart:typed_data';
import 'package:wallets/enums.dart';
import 'chain.dart';

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
}
