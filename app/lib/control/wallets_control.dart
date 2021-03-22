import 'dart:io';
import 'dart:typed_data';

import 'package:app/control/balance_control.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart' as WalletM;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/enums.dart' as EnumKit;
import 'package:wallets/enums.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/kits.dart';

class WalletsControl {
  factory WalletsControl() => getInstance();

  static WalletsControl _instance;

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
      Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
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
      return null;
    }
  }

  String generateMnemonic(int count) {
    var mneObj = Wallets.mainIsolate().generateMnemonic(count);
    if (!mneObj.isSuccess()) {
      Logger.getInstance().e("wallet_control ", "generateMnemonic error is false --->" + mneObj.err.toString());
      return null;
    }
    return mneObj.data1;
  }

  Wallet createWallet(Uint8List mnemonic, EnumKit.WalletType walletType, String walletName, Uint8List pwd) {
    CreateWalletParameters createWalletParameters = CreateWalletParameters();
    createWalletParameters.walletType = walletType.toEnumString();
    createWalletParameters.mnemonic = String.fromCharCodes(mnemonic);
    createWalletParameters.name = walletName;
    createWalletParameters.password = String.fromCharCodes(pwd);
    var newWalletObj = Wallets.mainIsolate().createWallet(createWalletParameters);
    if (!newWalletObj.isSuccess()) {
      Logger.getInstance().e("wallet_control ", "createWallet error is  ====>" + newWalletObj.err.toString());
      return null;
    }
    return newWalletObj.data1;
  }

  List<WalletM.Wallet> walletsAll() {
    var allWalletObj = Wallets.mainIsolate().all();
    if (!allWalletObj.isSuccess()) {
      Logger.getInstance().e("wallet_control", "walletsAll error is ====> " + allWalletObj.err.toString());
      return null;
    }
    List<WalletM.Wallet> walletMList = [];
    allWalletObj.data1.forEach((element) {
      WalletM.Wallet tempWallet = WalletM.Wallet();
      tempWallet.walletName = element.name;
      tempWallet.walletId = element.id;
      tempWallet.accountMoney = getWalletMoney(element).toStringAsFixed(6);

      // todo isShowChain tempWallet.chainList =
      ChainETH chainETH = ChainETH()..isVisible = true; // todo element.ethChain.chainShared.visible;
      ChainBTC chainBTC = ChainBTC()..isVisible = false; // todo element.ethChain.chainShared.visible;
      ChainEEE chainEEE = ChainEEE()..isVisible = true; // todo element.ethChain.chainShared.visible;
      switch (element.walletType.toWalletType()) {
        case EnumKit.WalletType.Test:
          chainETH..chainType = ChainType.EthTest;
          chainBTC..chainType = ChainType.BtcTest;
          chainEEE..chainType = ChainType.EeeTest;
          break;
        default:
          chainETH..chainType = ChainType.ETH;
          chainBTC..chainType = ChainType.BTC;
          chainEEE..chainType = ChainType.EEE;
          break;
      }
      tempWallet.chainList..add(chainETH)..add(chainBTC)..add(chainEEE);
      walletMList.add(tempWallet);
    });
    return walletMList;
  }

  // todo
  bool isCurWallet(WalletM.Wallet wallet) {
    if (currentWallet().id == wallet.walletId) {
      return true;
    }
    return false;
  }

  double getWalletMoney(Wallet wallet) {
    // todo wallet's chain's tokens * price
    double allMoneyValue = 0.0;
    EthChainControl.getInstance().getVisibleTokenList(wallet).forEach((element) {
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

  String currentChainAddress() {
    try {
      String address = WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address;
      return address;
    } catch (e) {
      Logger.getInstance().e("wallet_control", "currentChainAddress error is --->" + e.toString());
      return null;
    }
  }

  EnumKit.ChainType currentChainType() {
    var curWalletIdObj = Wallets.mainIsolate().currentWalletChain();
    if (curWalletIdObj.isSuccess()) {
      return curWalletIdObj.data1.chainType;
    } else {
      Logger.getInstance().e("wallet_control", "currentWalletChain error is --->" + curWalletIdObj.err.toString());
      return null;
    }
  }

  Wallet currentWallet() {
    var curWalletIdObj = Wallets.mainIsolate().currentWalletChain();
    if (curWalletIdObj.isSuccess()) {
      var walletObj = Wallets.mainIsolate().findById(curWalletIdObj.data1.walletId);
      if (walletObj.isSuccess()) {
        return walletObj.data1;
      } else {
        Logger.getInstance().e("wallet_control", "findById error is --->" + walletObj.err.toString());
      }
    } else {
      Logger.getInstance().e("wallet_control", "currentWalletChain error is --->" + curWalletIdObj.err.toString());
      return null;
    }
    return null;
  }

  removeWallet(String walletId, String pwd) {
    Error err = Wallets.mainIsolate().removeWallet(walletId, pwd);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance().e("wallet_control ", "removeWallet err is --->" + err.code.toString() + "||" + err.message.toString());
    return false;
  }

  renameWallet(String walletId, String newWalletName) {
    var err = Wallets.mainIsolate().renameWallet(newWalletName, walletId);
    Logger.getInstance().d("wallet_control", "renameWallet err is --->" + err.toString());
  }

  bool saveCurrentWalletChain(String walletId, EnumKit.ChainType chainType) {
    Error err = Wallets.mainIsolate().saveCurrentWalletChain(walletId, chainType);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance().d("wallet_control ", "saveCurrentWalletChain err" + err.toString());
    return false;
  }

  List<TokenAddress> getTokenAddress(String walletId, EnumKit.ChainType chainType) {
    var tokenAddressObj = Wallets.mainIsolate().getTokenAddress(walletId, chainType);
    if (!tokenAddressObj.isSuccess()) {
      return null;
    }
    Logger.getInstance().d("wallet_control ", "getTokenAddress err" + tokenAddressObj.data1.toString());
    return tokenAddressObj.data1;
  }
}
