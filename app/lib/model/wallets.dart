import 'package:app/model/token.dart';
import 'package:app/model/wallet.dart';
import 'package:logger/logger.dart';
import 'package:wallet_manager/wallet_manager.dart';
import 'package:wallets/enums.dart';
import 'dart:typed_data';
import 'chain.dart';

//Wallet management
class Wallets {
  List<Wallet> allWalletList = List();
  Wallet nowWallet;

  //Factory singleton class implementation
  factory Wallets() => _getInstance();

  static Wallets get instance => _getInstance();
  static Wallets _instance;

  Wallets._internal() {
    //init data
  }

  static Wallets _getInstance() {
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    return _instance;
  }

  Future<Map> cleanWalletsDownloadData() async {
    Map cleanMap = await WalletManager.cleanWalletsDownloadData();
    int status = cleanMap["status"];
    if (status == null || status != 200) {
      Logger().e("cleanWalletsDownloadData=>", "error status code is" + status.toString() + "||message is=>" + cleanMap["message"].toString());
      return cleanMap;
    }
    return cleanMap;
  }
}
