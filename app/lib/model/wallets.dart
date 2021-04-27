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

  // Create mnemonic words, to be verified correctly, the wallet is created by the bottom layer, and the application layer is saved
  // apiNo:MM00
  Future<Uint8List> createMnemonic(int count) async {
    Map resultMap = await WalletManager.mnemonicGenerate(count);
    int status = resultMap["status"];
    if (status == null) {
      Logger().e("createMnemonic=>", "not find status code");
      return null;
    }
    if (resultMap["status"] == 200) {
      return resultMap["mn"];
    } else {
      Logger().e("createMnemonic=>", "error status is=>" + resultMap["status"].toString() + "||message is=>" + resultMap["message"].toString());
      return null;
    }
  }

  // Whether you already have a wallet
  // apiNo:WM01
  Future<bool> isContainWallet() async {
    Map containWalletMap = await WalletManager.isContainWallet();
    int status = containWalletMap["status"];
    String message = containWalletMap["message"];
    if (status == null) {
      Logger().e("isContainWallet=>", "not find status code");
      return false;
    }
    if (status == 200) {
      return containWalletMap["isContainWallet"];
    } else {
      Logger().e("isContainWallet=>", "error status is=>" + containWalletMap["status"].toString() + "||message is=>" + message.toString());
      return false;
    }
  }

  Future<Wallet> getWalletByWalletId(String walletId) async {
    Wallet chooseWallet;
    for (int i = 0; i < allWalletList.length; i++) {
      int index = i;
      if (allWalletList[index].walletId == walletId) {
        chooseWallet = allWalletList[index];
        break; //Find, terminate the loop
      }
    }
    return chooseWallet;
  }

  Future<Map> eeeSign(String walletId, Uint8List pwd, String rawTx) async {
    Map eeeTxSignMap = await WalletManager.eeeSign(walletId, pwd, rawTx);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }

  Future<Map> queryDigit(Chain chain, String param) async {
    if (param == null || param.isEmpty) {
      return null;
    }

    Map resultMap = Map();
    List resultAuthDigitList = [];
    Map updateMap = Map();
    // todo
    // if (Utils.checkByEthAddressFormat(param)) {
    //   updateMap = await WalletManager.queryDigit(Chain.chainTypeToInt(chain.chainType), "", param);
    // } else {
    //   updateMap = await WalletManager.queryDigit(Chain.chainTypeToInt(chain.chainType), param, "");
    // }
    int status = updateMap["status"];
    resultMap["status"] = status;
    if (status == null || status != 200) {
      Logger().e("queryDigit=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());

      return resultMap;
    }
    int count = updateMap["count"];
    int startItem = updateMap["startItem"];
    List authDigitList = updateMap["authDigit"];

    resultMap["count"] = count;
    resultMap["startItem"] = startItem;

    if (authDigitList == null || authDigitList.length == 0) {
      return resultMap;
    }
    authDigitList.forEach((element) {
      var fullName = element["name"];
      var decimal = element["decimal"];
      var contract = element["contract"];
      var symbol = element["symbol"];
      switch (chain.chainType) {
        case ChainType.ETH:
        case ChainType.EthTest:
          TokenM ethDigit = new EthToken();
          ethDigit.shortName = symbol;
          ethDigit.fullName = fullName;
          ethDigit.decimal = decimal;
          ethDigit.contractAddress = contract;
          resultAuthDigitList.add(ethDigit);
          break;
        case ChainType.BTC:
        case ChainType.BtcTest:
          break;
        case ChainType.EEE:
        case ChainType.EeeTest:
          break;
        default:
          break;
      }
    });
    resultMap["authDigit"] = resultAuthDigitList;
    return resultMap;
  }

  btcStart() async {
    await WalletManager.btcStart();
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
