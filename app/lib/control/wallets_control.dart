import 'dart:io';
import 'dart:typed_data';

import 'package:app/control/balance_control.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/model/wallet.dart' as WalletM;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/enums.dart' as EnumKit;
import 'package:wallets/kits.dart';
import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

class WalletsControl {
  factory WalletsControl() => getInstance();

  static final WalletsControl _instance = new WalletsControl._internal();

  WalletsControl._internal();

  static WalletsControl getInstance() {
    return _instance;
  }

  Future<void> initWallet() async {
    var initP = new InitParameters();
    try {
      Directory? directory = await getExternalStorageDirectory(); // path:  Android/data/
      if (directory == null) {
        return;
      }
      initP.dbName.path = directory.path;
      initP.dbName.prefix = "scry_";
      initP.dbName = Wallets.dbName(initP.dbName);
      Wallets wallets = Wallets.mainIsolate();
      var errObj = wallets.init(initP);
      if (!errObj.isSuccess()) {
        Logger.getInstance().e("initWallet ", "errObj is --->" + errObj.message.toString());
        return;
      }
      changeNetType(getCurrentNetType());
      return;
    } catch (e) {
      Logger.getInstance().e("Wallets.dbName ", "error is --->" + e.toString());
    }
  }

  String generateMnemonic(int count) {
    var mneObj = Wallets.mainIsolate().generateMnemonic(count);
    if (!mneObj.isSuccess()) {
      Logger.getInstance().e("wallet_control ", "generateMnemonic error is false --->" + mneObj.err.toString());
      return "";
    }
    return mneObj.data1;
  }

  EnumKit.NetType getCurrentNetType() {
    var curNetTypeObj = Wallets.mainIsolate().getCurrentNetType();
    if (!curNetTypeObj.isSuccess()) {
      Logger.getInstance().e("wallet_control ", "getCurrentNetType error is  --->" + curNetTypeObj.err.message.toString());
      return EnumKit.NetType.Main;
    }
    return curNetTypeObj.data1;
  }

  bool changeNetType(EnumKit.NetType netType) {
    Error err = Wallets.mainIsolate().changeNetType(netType);
    if (!err.isSuccess()) {
      Logger.getInstance().e("wallet_control ", "changeNetType error is false --->" + err.message.toString());
      return false;
    }
    return true;
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
      Logger.getInstance().e("wallet_control", "walletsAll error is ====> " + allWalletObj.err.message.toString());
      return [];
    }
    List<WalletM.Wallet> walletMList = [];
    allWalletObj.data1.forEach((element) {
      WalletM.Wallet tempWallet = WalletM.Wallet();
      tempWallet.walletType = element.walletType.toWalletType();
      tempWallet.walletName = element.name;
      tempWallet.walletId = element.id;
      tempWallet.accountMoney = getWalletMoney(element).toStringAsFixed(6);

      ChainETH chainETH = ChainETH()
        ..isVisible = true // todo element.ethChain.chainShared.visible;
        ..walletAddress = element.ethChain.chainShared.walletAddress;
      ChainBTC chainBTC = ChainBTC()
        ..isVisible = false // todo element.ethChain.chainShared.visible;
        ..walletAddress = element.btcChain.chainShared.walletAddress;
      ChainEEE chainEEE = ChainEEE()
        ..isVisible = true // todo element.ethChain.chainShared.visible;
        ..walletAddress = element.eeeChain.chainShared.walletAddress;
      switch (element.walletType.toWalletType()) {
        case EnumKit.WalletType.Test:
          chainETH..chainType = EnumKit.ChainType.EthTest;
          chainBTC..chainType = EnumKit.ChainType.BtcTest;
          chainEEE..chainType = EnumKit.ChainType.EeeTest;
          break;
        default:
          chainETH..chainType = EnumKit.ChainType.ETH;
          chainBTC..chainType = EnumKit.ChainType.BTC;
          chainEEE..chainType = EnumKit.ChainType.EEE;
          break;
      }
      tempWallet.chainList
        ..add(chainETH)
        ..add(chainBTC)
        ..add(chainEEE);
      walletMList.add(tempWallet);
    });
    return walletMList;
  }

  bool isCurWallet(WalletM.Wallet wallet) {
    if (currentWallet().id == wallet.walletId) {
      return true;
    }
    return false;
  }

  double getWalletMoney(Wallet wallet) {
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
      Logger.getInstance().e("wallet_control", "hasAnyObj error is --->" + hasAnyObj.err.message.toString());
      return false;
    }
    return hasAnyObj.data1;
  }

  String currentChainAddress() {
    try {
      String address = "";
      switch (currentChainType()) {
        case EnumKit.ChainType.EthTest:
        case EnumKit.ChainType.ETH:
          address = WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address;
          break;
        case EnumKit.ChainType.EeeTest:
        case EnumKit.ChainType.EEE:
          address = WalletsControl.getInstance().currentWallet().eeeChain.chainShared.walletAddress.address;
          break;
        default:
          address = WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address;
          break;
      }
      return address;
    } catch (e) {
      Logger.getInstance().e("wallet_control", "currentChainAddress error is --->" + e.toString());
      return "";
    }
  }

  EnumKit.ChainType currentChainType() {
    DlResult1<CurrentWallet> curWalletIdObj = Wallets.mainIsolate().currentWalletChain();
    if (curWalletIdObj.isSuccess()) {
      return curWalletIdObj.data1.chainType;
    } else {
      Logger.getInstance().e("wallet_control", "currentWalletChain error is --->" + curWalletIdObj.err.message.toString());
      return null;
    }
  }

  Wallet currentWallet() {
    var curWalletIdObj = Wallets.mainIsolate().currentWalletChain();
    if (!curWalletIdObj.isSuccess()) {
      Logger.getInstance().e("wallet_control", "currentWalletChain error is --->" + curWalletIdObj.err.toString());
      return null;
    }
    var walletObj = Wallets.mainIsolate().findById(curWalletIdObj.data1.walletId);
    if (walletObj.isSuccess()) {
      return walletObj.data1;
    } else {
      Logger.getInstance().e("wallet_control", "findById error is --->" + walletObj.err.toString());
      return null;
    }
  }

  bool changeTokenStatus(WalletTokenStatus walletTokenStatus) {
    if (walletTokenStatus == null) {
      return false;
    }
    Error err = Wallets.mainIsolate().changeTokenStatus(walletTokenStatus);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance()
        .e("wallet_control ", "changeTokenStatus err is --->" + err.code.toString() + "||" + err.message.toString());
    return false;
  }

  bool updateBalance(TokenAddress tokenAddress) {
    Error err = Wallets.mainIsolate().updateBalance(tokenAddress);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance()
        .e("wallet_control ", "changeTokenStatus err is --->" + err.code.toString() + "||" + err.message.toString());
    return false;
  }

  bool removeWallet(String walletId, Uint8List pwd) {
    if (walletId == null || walletId == "" || pwd == null) {
      return false;
    }
    Error err = Wallets.mainIsolate().removeWallet(walletId, pwd);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance()
        .e("wallet_control ", "removeWallet err is --->" + err.code.toString() + "||" + err.message.toString());
    return false;
  }

  bool renameWallet(String walletId, String newWalletName) {
    if (walletId == null || walletId == "" || newWalletName == null) {
      return false;
    }
    var err = Wallets.mainIsolate().renameWallet(newWalletName, walletId);
    if (err.isSuccess()) {
      return true;
    }
    Logger.getInstance()
        .e("wallet_control ", "renameWallet err is --->" + err.code.toString() + "||" + err.message.toString());
    return false;
  }

  DlResult1<bool> resetPwd(String walletId, Uint8List oldPwd, Uint8List newPwd) {
    var err = Wallets.mainIsolate().resetPwdWallet(walletId, oldPwd, newPwd);
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    Logger.getInstance().e("wallet_control ", "resetPwd err is --->" + err.code.toString() + "||" + err.message.toString());
    return DlResult1(false, err);
  }

  String exportWallet(String walletId, Uint8List pwd) {
    var resultObj = Wallets.mainIsolate().exportWallet(walletId, pwd);
    if (resultObj.isSuccess()) {
      return resultObj.data1;
    }
    Logger.getInstance().e("wallet_control", "exportWallet err is --->" + resultObj.err.message.toString());
    return "";
  }

  bool saveCurrentWalletChain(String walletId, EnumKit.ChainType chainType) {
    Error err = Wallets.mainIsolate().saveCurrentWalletChain(walletId, chainType);
    if (err.isSuccess()) {
      BalanceControl.reloadInstance(); // change curWallet as well as refresh balance instance to wipe old cache
      return true;
    }
    Logger.getInstance().e("wallet_control ", "saveCurrentWalletChain err is --->" + err.message.toString());
    return false;
  }

  String getTokenAddressId(String walletId, EnumKit.ChainType chainType) {
    try {
      String tokenAddressId = "";
      switch (chainType) {
        case EnumKit.ChainType.EthTest:
        case EnumKit.ChainType.ETH:
          tokenAddressId = WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.id;
          break;
        case EnumKit.ChainType.EeeTest:
        case EnumKit.ChainType.EEE:
          tokenAddressId = WalletsControl.getInstance().currentWallet().eeeChain.chainShared.walletAddress.id;
          break;
        default:
          tokenAddressId = WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.id;
          break;
      }
      return tokenAddressId;
    } catch (e) {
      return "";
    }
  }

  List<TokenAddress> getTokenAddress(String walletId) {
    var tokenAddressObj = Wallets.mainIsolate().getTokenAddress(walletId);
    if (tokenAddressObj.isSuccess()) {
      return tokenAddressObj.data1;
    }
    Logger.getInstance().e("wallet_control ", "getTokenAddress err is --->" + tokenAddressObj.err.message.toString());
    return [];
  }
}
