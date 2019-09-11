import 'dart:typed_data';

import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';

class WalletManagerTest {
  //fixed
  static void createMnemonic() async {
    var mnemonic = await Wallets.instance.createMnemonic(12);
  }

  //fixed  todo chainList
  static void saveWallet() async {
    var mnemonic = await Wallets.instance.createMnemonic(12);
    var wallet = await Wallets.instance.saveWallet("thisWall33etName", Uint8List.fromList("666".codeUnits), mnemonic, WalletType.WALLET);
  }

  //fixed
  static void isContainWallet() async {
    var isContainWallet = await Wallets.instance.isContainWallet();
    print("wallet_manager_test isContainWallet=>" + isContainWallet.toString());
  }

  static void loadAllWalletList() async {
    await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true);
  }

  static void getNowWallet() async {
    var getNowWallet = await Wallets.instance.getNowWallet();
    print("wallet_manager_test getNowWallet=>" + getNowWallet.toString());
  }

  static void setNowWallet() async {
    var isSuccess = await Wallets.instance.setNowWallet("fe3b3751739df1e3de9fd4fda4572c61877aef5b6761edd0ae417ca952779a4f");
    //fe3b3751739df1e3de9fd4fda4572c61877aef5b6761edd0ae417ca952779a4f
    print("wallet_manager_test setNowWallet=>" + isSuccess.toString());
  }

  static void deleteWallet() async {
    //var isSuccess = await Wallets.instance.deleteWallet("fe3b3751739df1e3de9fd4fda4572c61877aef5b6761edd0ae417ca952779a4f");
    //fe3b3751739df1e3de9fd4fda4572c61877aef5b6761edd0ae417ca952779a4f
    //print("wallet_manager_test deleteWallet=>" + isSuccess.toString());
  }

  static void resetPwd() async {
    var allWalletList = await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true);
    print("wallet_manager_test allWalletList=>" + allWalletList.length.toString());
    print("wallet_manager_test allWalletList=>" + allWalletList[0].toString());
    var isSuccess = allWalletList[0].resetPwd(Uint8List.fromList("777".codeUnits), Uint8List.fromList("666".codeUnits));
    print("wallet_manager_test resetPwd=>" + isSuccess.toString());
  }

  static void showChain(walletId,chainType) async {
    Wallet wallet = await Wallets.instance.getWalletByWalletId("ebe38fd2-30ee-4a10-a890-44cc391253bf");
    await  wallet.showChain(chainType);
  }
  static void hideChain(walletId,chainType) async {
    Wallet wallet = await Wallets.instance.getWalletByWalletId("ebe38fd2-30ee-4a10-a890-44cc391253bf");
    await  wallet.hideChain(chainType);
  }
}
