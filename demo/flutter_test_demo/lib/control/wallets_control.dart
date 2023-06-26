import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test_demo/control/balance_control.dart';
import 'package:flutter_test_demo/control/eth_chain_control.dart';
import 'package:flutter_test_demo/model/token_rate.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/kits.dart';

class WalletsControl {
  factory WalletsControl() => getInstance();

  static late WalletsControl _instance;

  WalletsControl._internal();

  static WalletsControl getInstance() {
    if (_instance == null) {
      _instance = new WalletsControl._internal();
    }
    return _instance;
  }

  Future<Wallets> initWallet() async {
    Wallets wallets = Wallets.mainIsolate();
    var initP = new InitParameters();
    {
      Directory directory =
          await getExternalStorageDirectory(); // path:  Android/data/
      initP.dbName.path = directory.path;
      initP.dbName.prefix = "test_"; // todo remove
      initP.dbName = Wallets.dbName(initP.dbName); // todo remove
    }
    var errObj = wallets.init(initP);
    if (errObj.isSuccess()) {
      print("success  initWallet --->" + errObj.toString());
      return wallets;
    } else {
      print("err initWallet--->" + errObj.toString());
      return wallets;
    }
  }

  String generateMnemonic(int count) {
    var mneObj = Wallets.mainIsolate().generateMnemonic(count);
    if (!mneObj.isSuccess()) {
      Logger.getInstance().e("wallet_control ",
          "generateMnemonic error is false --->" + mneObj.err.toString());
      return "";
    }
    return mneObj.data1;
  }

  Wallet createWallet(String mnemonic, WalletType walletType, String walletName,
      Uint8List pwd) {
    CreateWalletParameters createWalletParameters = CreateWalletParameters();
    createWalletParameters.walletType = walletType.toEnumString();
    createWalletParameters.mnemonic = mnemonic;
    createWalletParameters.name = walletName;
    createWalletParameters.password = String.fromCharCodes(pwd);
    var newWalletObj =
        Wallets.mainIsolate().createWallet(createWalletParameters);
    if (!newWalletObj.isSuccess()) {
      Logger.getInstance().d("wallet_control ",
          "createWallet error is  ====>" + newWalletObj.err.toString());
      return null;
    }
    return newWalletObj.data1;
  }

  List<Wallet> walletsAll() {
    var allWalletObj = Wallets.mainIsolate().all();
    if (!allWalletObj.isSuccess()) {
      Logger.getInstance().d("wallet_control",
          "walletsAll error is ====> " + allWalletObj.err.toString());
      return null;
    }
    return allWalletObj.data1;
  }

  double getWalletMoney(Wallet wallet) {
    // todo wallet's chain's tokens * price
    double allMoneyValue = 0.0;
    EthChainControl.getInstance().getVisibleTokenList().forEach((element) {
      allMoneyValue = allMoneyValue + TokenRate.instance.getMoney(element);
    });
    // todo BtcChainControl
    // todo EeeChainControl
    return allMoneyValue;
  }

  bool hasAny() {
    var hasAnyObj = Wallets.mainIsolate().hasAny();
    if (!hasAnyObj.isSuccess()) {
      return false;
    }
    return hasAnyObj.data1;
  }

  Wallet currentWallet() {
    var curWalletIdObj = Wallets.mainIsolate().currentWalletChain();
    if (curWalletIdObj.isSuccess()) {
      var walletObj =
          Wallets.mainIsolate().findById(curWalletIdObj.data1.walletId);
      if (walletObj.isSuccess()) {
        return walletObj.data1;
      } else {
        Logger.getInstance().e("wallet_control",
            "findById error is --->" + walletObj.err.toString());
      }
    } else {
      Logger.getInstance().e("wallet_control",
          "currentWalletChain error is --->" + curWalletIdObj.err.toString());
      return null;
    }
    return null;
  }

  removeWallet(String walletId, Uint8List pwd) {
    Error err = Wallets.mainIsolate().removeWallet(walletId, pwd);
    Logger.getInstance()
        .d("wallet_control ", "removeWallet err --->" + err.toString());
  }

  renameWallet(String walletId, String newWalletName) {
    var err = Wallets.mainIsolate().renameWallet(newWalletName, walletId);
    Logger.getInstance()
        .d("wallet_control", "renameWallet err is --->" + err.toString());
  }

  saveCurrentWalletChain(String walletId, ChainType chainType) {
    var err = Wallets.mainIsolate().saveCurrentWalletChain(walletId, chainType);
    Logger.getInstance()
        .d("wallet_control ", "saveCurrentWalletChain err" + err.toString());
  }

  List<TokenAddress> getTokenAddress(String walletId, NetType netType) {
    var tokenAddressObj = Wallets.mainIsolate().getTokenAddress(walletId);
    if (!tokenAddressObj.isSuccess()) {
      return null;
    }
    Logger.getInstance().d("wallet_control ",
        "getTokenAddress err" + tokenAddressObj.data1.toString());
    return tokenAddressObj.data1;
  }
}
