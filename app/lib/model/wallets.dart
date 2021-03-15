import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/tx_model/eee_transaction_model.dart';
import 'package:app/model/wallet.dart';
import 'package:logger/logger.dart';
import 'package:app/util/utils.dart';
import 'package:wallet_manager/wallet_manager.dart';
import 'package:wallets/enums.dart';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'chain.dart';
import 'digit.dart';

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

  initAppConfig() async {
    initDatabaseAndDefaultDigits(); //init wallet Database Info
  }

  initDatabaseAndDefaultDigits() async {
    Config config = await HandleConfig.instance.getConfig();
    if (config.isInitedConfig == null || config.isInitedConfig == false) {
      {
        //init defaultDigit
        config.privateConfig.defaultTokens.toString();
        String digitParam = "[";
        config.privateConfig.defaultTokens.forEach((element) {
          digitParam = digitParam + convert.jsonEncode(element) + ",";
        });
        digitParam = digitParam.substring(0, digitParam.length - 1) + "]";
        if (digitParam != null && digitParam != "") {
          Map updateMap = await Wallets.instance.updateDefaultDigitList(digitParam);
          int status = updateMap["status"];
          if (status == null || status != 200) {
            Logger().e("initWallet,updateDefaultDigitList error=>", updateMap["message"].toString());
          }
        }
      }
      {
        //init DB
        Map resultMap = await WalletManager.initWalletBasicData(); //Initialize some database data
        int status = resultMap["status"];
        if (status == null || status != 200) {
          Logger().e("initWalletBasicData error=>", "not find status code");
          return;
        }
        if (status == 200 && resultMap["isInitWalletBasicData"] == true) {
          config.isInitedConfig = true;
          HandleConfig.instance.saveConfig(config);
        }
      }
    }
  }

  Future<Map> updateWalletDbData(String newVersion) async {
    Map resultMap = await WalletManager.updateWalletDbData(newVersion); //Initialize some database data
    int status = resultMap["status"];
    if (status == null) {
      Logger().e("initWalletBasicData error=>", "not find status code");
      return null;
    }
    if (status == 200) {
      return resultMap;
    } else {
      Logger().e("initWalletBasicData=>", "error status is=>" + resultMap["status"].toString() + "||message is=>" + resultMap["message"].toString());
      return null;
    }
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

  // Export all wallets
  // apiNo:WM02
  Future<List<Wallet>> loadAllWalletList({bool isForceLoadFromJni = false}) async {
    ///Judge whether you need to get it from JNI again, it will be cached after loading.
    if (!isForceLoadFromJni) {
      return allWalletList;
    }
    allWalletList = [];
    List jniList = await WalletManager.loadAllWalletList();
    if (jniList == null || jniList.isEmpty || jniList.length == 0) {
      return allWalletList;
    }
    for (int i = 0; i < jniList.length; i++) {
      int walletIndex = i;
      Wallet walletM = Wallet();
      int walletStatus = jniList[walletIndex]["status"];
      if (walletStatus == null || walletStatus != 200) {
        Logger().e("loadAllWalletList=>", "error status code is" + walletStatus.toString() + "||message is=>" + jniList[walletIndex]["message"]);
        continue; //There is a problem with this wallet data, skip it, take down a wallet
      }
      int walletType = jniList[walletIndex]["walletType"];
      // if (walletType == 0) {
      //   walletM.walletType = WalletType.TEST_WALLET;
      // } else {
      //   walletM.walletType = WalletType.WALLET;
      // }
      walletM
        ..walletName = jniList[walletIndex]["walletName"].toString()
        ..walletId = jniList[walletIndex]["walletId"].toString()
        ..nowChainId = jniList[walletIndex]["nowChainId"].toString()
        ..creationTime = jniList[walletIndex]["creationTime"].toString()
        ..isNowWallet = jniList[walletIndex]["isNowWallet"];
      //  todo version1.0 without scryx chain display
      {
        var eeeChain = jniList[walletIndex]["eeeChain"];
        Chain chainEeeM = ChainEEE();
        chainEeeM
          ..chainId = eeeChain["chainId"]
          ..chainAddress = eeeChain["chainAddress"]
          ..chainType = ChainType.EEE
          ..isVisible = true
          ..pubKey = eeeChain["pubkey"]
          ..walletId = eeeChain["walletId"];
        List eeeChainDigitList = eeeChain["eeeChainDigitList"];
        for (int j = 0; j < eeeChainDigitList.length; j++) {
          Map digitInfoMap = eeeChainDigitList[j];
          Digit digitM = EeeDigit();
          digitM
            ..digitId = digitInfoMap["digitId"]
            ..chainId = digitInfoMap["chainId"]
            ..contractAddress = digitInfoMap["contractAddress"]
            ..address = eeeChain["chainAddress"] // !attention this differ
            ..shortName = digitInfoMap["shortName"]
            ..fullName = digitInfoMap["fullName"]
            ..balance = digitInfoMap["balance"]
            ..isVisible = digitInfoMap["isVisible"]
            ..decimal = digitInfoMap["decimal"]
            ..urlImg = digitInfoMap["urlImg"];
          chainEeeM.digitsList.add(digitM);
        }
        walletM.chainList.add(chainEeeM); ////Add chain to chainList
      }
      {
        //ETH
        ChainETH chainEthM = ChainETH();
        var ethChain = jniList[walletIndex]["ethChain"];
        chainEthM
          ..chainId = ethChain["chainId"]
          ..chainAddress = ethChain["chainAddress"]
          ..chainType = ChainType.ETH
          ..isVisible = true
          ..pubKey = ethChain["pubkey"]
          ..walletId = jniList[walletIndex]["walletId"];
        List ethChainDigitList = ethChain["ethChainDigitList"];
        if (ethChainDigitList != null && ethChainDigitList.length > 0) {
          for (int j = 0; j < ethChainDigitList.length; j++) {
            Map digitInfoMap = ethChainDigitList[j];
            Digit digitM = EthDigit();
            digitM
              ..digitId = digitInfoMap["digitId"]
              ..chainId = digitInfoMap["chainId"]
              ..contractAddress = digitInfoMap["contractAddress"]
              ..address = ethChain["chainAddress"] // !attention this differ
              ..shortName = digitInfoMap["shortName"]
              ..fullName = digitInfoMap["fullName"]
              ..balance = digitInfoMap["balance"]
              ..isVisible = digitInfoMap["isVisible"]
              ..decimal = digitInfoMap["decimal"]
              ..urlImg = digitInfoMap["urlImg"];
            chainEthM.digitsList.add(digitM);
          }
          walletM.chainList.add(chainEthM);
        }
      }
      /*{
        //BTC
        ChainBTC chainBtcM = ChainBTC();
        var btcChain = jniList[walletIndex]["btcChain"];
        chainBtcM
          ..chainId = btcChain["chainId"]
          ..chainAddress = btcChain["chainAddress"]
          ..chainType = Chain.intToChainType(btcChain["chainType"])
          ..isVisible = false //todo change Visible state
          ..pubKey = btcChain["pubkey"]
          ..walletId = jniList[walletIndex]["walletId"];
        List btcChainDigitList = btcChain["btcChainDigitList"];
        if (btcChainDigitList != null && btcChainDigitList.length > 0) {
          for (int j = 0; j < btcChainDigitList.length; j++) {
            Map digitInfoMap = btcChainDigitList[j];
            Digit digitM = BtcDigit();
            digitM
              ..digitId = digitInfoMap["digitId"]
              ..chainId = digitInfoMap["chainId"]
              ..address = digitInfoMap["address"]
              ..shortName = digitInfoMap["shortName"]
              ..fullName = digitInfoMap["fullName"]
              ..balance = digitInfoMap["balance"]
              ..isVisible = digitInfoMap["isVisible"]
              ..decimal = digitInfoMap["decimal"]
              ..urlImg = digitInfoMap["urlImg"];
            chainBtcM.digitsList.add(digitM);
          }
          walletM.chainList.add(chainBtcM);
        }
      }*/
      walletM.nowChain = walletM.getChainByChainId(walletM.nowChainId);
      if (walletM.isNowWallet) {
        this.nowWallet = walletM;
      }
      allWalletList.add(walletM); ////Add wallet to WalletList
    }
    return allWalletList;
  }

  // Save the wallet and import the wallet. Create a wallet process with mnemonic words
  // apiNo:WM03           //todo 2.0 optimize saveWallet interface, return value type
  Future<bool> saveWallet(String walletName, Uint8List pwd, Uint8List mnemonic) async {
    int walletTypeToInt = 0;

    Map saveWalletMap = await WalletManager.saveWallet(walletName, pwd, mnemonic, walletTypeToInt);
    if (saveWalletMap["status"] == null) {
      Logger().e("saveWallet=>", "not find status code");
      return false;
    }
    if (saveWalletMap["status"] == 200) {
      return true;
    }
    return false;
  }

  // Wallet export. Restore wallet.   /* There is mnemonic word generation here. Pay attention to release in time*/
  // apiNo:WM04
  Future<Map> exportWallet(String walletId, Uint8List pwd) async {
    Map mnemonicMap = await WalletManager.exportWallet(walletId, pwd);
    return mnemonicMap;
  }

  //Get current wallet
  // apiNo:WM05
  Future<String> getNowWalletId() async {
    var walletId = await WalletManager.getNowWalletId();
    return walletId;
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

  //Set whether the current wallet bool is successful
  //  apiNo:WM06
  Future<bool> setNowWallet(String walletId) async {
    Map setNowWalletMap = await WalletManager.setNowWallet(walletId);
    int status = setNowWalletMap["status"];
    if (status == null) {
      Logger().e("setNowWallet=>", "not find status code");
      return false;
    }
    if (status == 200) {
      //Change the model layer data
      this.allWalletList.forEach((w) {
        if (w.walletId.toLowerCase() == walletId.toLowerCase()) {
          w.isNowWallet = true;
          this.nowWallet = w;
        } else {
          w.isNowWallet = false;
        }
      });
      return setNowWalletMap["isSetNowWallet"];
    } else {
      Logger().e("setNowWallet=>", "error status code is" + status.toString() + "||message is=>" + setNowWalletMap["message"]);
      return false;
    }
  }

  //Delete the wallet. The wallet settings can be deleted, and the chain settings are hidden.
  // apiNo:WM07.
  Future<Map> deleteWallet(String walletId, Uint8List pwd) async {
    Map deleteWalletMap = await WalletManager.deleteWallet(walletId, pwd);
    int status = deleteWalletMap["status"];
    bool isSuccess = deleteWalletMap["isDeletWallet"];
    if (status == null) {
      Logger().e("deleteWallet=>", "not find status code");
      return null;
    }
    if (status == 200 && isSuccess) {
      // Data model layer removal
      allWalletList.remove(getWalletByWalletId(walletId));
      return deleteWalletMap;
    } else {
      Logger().e("deleteWallet=>", "error status code is" + status.toString() + "||message is=>" + deleteWalletMap["message"]);
      return deleteWalletMap;
    }
  }

  Future<Map> eeeTxSign(String walletId, Uint8List pwd, String rawTx) async {
    Map eeeTxSignMap = await WalletManager.eeeTxSign(walletId, pwd, rawTx);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }

  Future<Map> ethTxSign(String walletId, int chainType, String fromAddress, String toAddress, String contractAddress, String value, String backup,
      Uint8List pwd, String gasPrice, String gasLimit, String nonce,
      {int decimal = 18}) async {
    Map ethTxSignMap = await WalletManager.ethTxSign(
        walletId, chainType, fromAddress, toAddress, contractAddress, value, backup, pwd, gasPrice, gasLimit, nonce,
        decimal: decimal);
    int status = ethTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("ethTxSign=>", "error status code is" + status.toString() + "||message is=>" + ethTxSignMap["message"]);
    }
    return ethTxSignMap;
  }

  Future<Map> ethRawTxSign(String rawTx, int chainType, String fromAddress, Uint8List pwd) async {
    Map ethRawTxSignMap = await WalletManager.ethRawTxSign(rawTx, chainType, fromAddress, pwd);
    int status = ethRawTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("ethRawTxSign=>", "error status code is" + status.toString() + "||message is=>" + ethRawTxSignMap["message"]);
    }
    return ethRawTxSignMap;
  }

  Future<Map> eeeSign(String walletId, Uint8List pwd, String rawTx) async {
    Map eeeTxSignMap = await WalletManager.eeeSign(walletId, pwd, rawTx);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }

  Future<Map> eeeTransfer(String from, String to, String value, int index, Uint8List pwd) async {
    Map eeeTxSignMap = await WalletManager.eeeTransfer(from, to, value, index, pwd);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }

  Future<Map> tokenXTransfer(String from, String to, String value, String extData, int index, Uint8List pwd) async {
    Map tokenXTxSignMap = await WalletManager.tokenXTransfer(from, to, value, extData, index, pwd);
    int status = tokenXTxSignMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + tokenXTxSignMap["message"]);
    }
    return tokenXTxSignMap;
  }

  Future<Map> decodeAdditionData(String inputData) async {
    if (inputData == null || inputData.trim() == "") {
      return null;
    }
    Map decodeMap = await WalletManager.decodeAdditionData(inputData);
    int status = decodeMap["status"];
    if (status == null || status != 200) {
      Logger().e("decodeAdditionData=>", "error status code is" + status.toString() + "||message is=>" + decodeMap["message"].toString());
    }
    return decodeMap;
  }

  //Database update balance information
  Future<Map> updateDigitBalance(String address, String digitId, String balance) async {
    if (!Utils.checkByEthAddressFormat(address)) {
      return null;
    }
    try {
      if (double.parse(balance) <= 0 || balance.trim() == "") {
        return null;
      }
    } catch (e) {
      Logger().e("updateDigitBalance=>", "error status code is" + e.toString());
    }
    Map updateMap = await WalletManager.updateDigitBalance(address, digitId, balance);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("updateDigitBalance=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
    } else {
      var index = this.nowWallet.nowChain.digitsList.indexWhere((element) => (element.digitId == digitId));
      if (index != -1) {
        this.nowWallet.nowChain.digitsList[index].balance = balance;
      }
    }
    return updateMap;
  }

  //
  eeeStorageKey(String module, String storageItem, String accountStr) async {
    Map<dynamic, dynamic> eeeStorageMap = await WalletManager.eeeStorageKey(module, storageItem, accountStr);
    int status = eeeStorageMap["status"];
    if (status == null || status != 200) {
      Logger().e("eeeStorageMap=>", "error status code is" + status.toString() + "||message is=>" + eeeStorageMap["message"].toString());
    }
    return eeeStorageMap;
  }

  //
  Future<Map> decodeEeeAccountInfo(String encodeData) async {
    Map<dynamic, dynamic> decodeEeeAccountInfoMap = await WalletManager.decodeAccountInfo(encodeData);
    int status = decodeEeeAccountInfoMap["status"];
    if (status == null || status != 200) {
      Logger()
          .e("decodeEeeAccountInfo=>", "error status code is" + status.toString() + "||message is=>" + decodeEeeAccountInfoMap["message"].toString());
    }
    return decodeEeeAccountInfoMap;
  }

  getEeeSyncRecord() async {
    Map<dynamic, dynamic> getEeeSyncRecordMap = await WalletManager.getEeeSyncRecord();
    int status = getEeeSyncRecordMap["status"];
    if (status == null || status != 200) {
      Logger().e("getEeeSyncRecordMap=>", "error status code is" + status.toString() + "||message is=>" + getEeeSyncRecordMap["message"].toString());
    }
    return getEeeSyncRecordMap;
  }

  updateEeeSyncRecord(String account, int chainType, int blockNum, String blockHash) async {
    Map<dynamic, dynamic> updateEeeSyncRecordMap = await WalletManager.updateEeeSyncRecord(account, chainType, blockNum, blockHash);
    int status = updateEeeSyncRecordMap["status"];
    if (status == null || status != 200) {
      Logger()
          .e("updateEeeSyncRecord=>", "error status code is" + status.toString() + "||message is=>" + updateEeeSyncRecordMap["message"].toString());
    }
    return updateEeeSyncRecordMap;
  }

  Future<Map> saveEeeExtrinsicDetail(String infoId, String account, String eventDetail, String blockHash, String extrinsic) async {
    Map<dynamic, dynamic> saveEeeExtrinsicDetailMap = await WalletManager.saveEeeExtrinsicDetail(infoId, account, eventDetail, blockHash, extrinsic);
    int status = saveEeeExtrinsicDetailMap["status"];
    if (status == null || status != 200) {
      Logger().e("saveEeeExtrinsicDetail=>",
          "error status code is" + status.toString() + "||message is=>" + saveEeeExtrinsicDetailMap["message"].toString());
    }
    return saveEeeExtrinsicDetailMap;
  }

  Future<List> loadEeeChainTxHistory(String account, String tokenName, int startIndex, int offset) async {
    List<EeeTransactionModel> resultList = new List();
    Map loadEeeChainTxMap = await WalletManager.loadEeeChainTxHistory(account, tokenName, startIndex, offset);
    int status = loadEeeChainTxMap["status"];
    if (status == null || status != 200) {
      Logger().e("loadEeeChainTxHistory=>", "error status code is" + status.toString() + "||message is=>" + loadEeeChainTxMap["message"].toString());
    } else {
      List eeeChainTxList = loadEeeChainTxMap["eeeChainTxDetail"];
      for (int i = 0; i < eeeChainTxList.length; i++) {
        EeeTransactionModel eeeTransactionModel = new EeeTransactionModel();
        try {
          eeeTransactionModel
            ..blockHash = eeeChainTxList[i]["blockHash"]
            ..from = eeeChainTxList[i]["from"]
            ..to = eeeChainTxList[i]["to"]
            ..value = eeeChainTxList[i]["value"]
            ..txHash = eeeChainTxList[i]["txHash"]
            ..inputMsg = eeeChainTxList[i]["inputMsg"]
            ..gasFee = eeeChainTxList[i]["gasFee"]
            ..signer = eeeChainTxList[i]["signer"]
            ..isSuccess = eeeChainTxList[i]["isSuccess"];
          eeeTransactionModel.timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(eeeChainTxList[i]["timestamp"])).toString();
        } catch (e) {
          Logger().e("convert format error ", e.toString());
          return resultList;
        }
        resultList.add(eeeTransactionModel);
      }
    }
    return resultList;
  }

  //Add a new token data model to the current wallet and current chain
  addDigitToChainModel(String walletId, Chain chain, String digitId) async {
    /*Map addDigitModelMap =await WalletManager.addDigitToChainModel(walletId, Chain.chainTypeToInt(Wallets.instance.nowWallet.nowChain.chainType), digitId);
    int status = addDigitModelMap["status"];
    if (status == null || status != 200) {
      Logger().e("addDigitModelMap=>", "error status code is" + status.toString() + "||message is=>" + addDigitModelMap["message"].toString());
    } else {
      await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true); //Add this token model to digitList and reload
    }
    return addDigitModelMap;*/
  }

  updateDefaultDigitList(String digitData) async {
    if (digitData == null || digitData.isEmpty) {
      return Map();
    }
    Map updateMap = await WalletManager.updateDefaultDigitList(digitData);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("updateDefaultDigitList=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
    }
    return updateMap;
  }

  updateAuthDigitList(String digitData) async {
    if (digitData == null || digitData.isEmpty) {
      return Map();
    }
    Map updateMap = await WalletManager.updateAuthDigitList(digitData);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("updateAuthDigitList=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
    }
    return updateMap;
  }

  Future<Map> getNativeAuthDigitList(Chain chain, int startIndex, int pageSize) async {
    Map resultMap = Map();
    //Map updateMap = await WalletManager.getNativeAuthDigitList(Chain.chainTypeToInt(chain.chainType), startIndex, pageSize);
    Map updateMap = null; // todo
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("updateAuthDigitList=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
      return resultMap;
    }
    int count = updateMap["count"];
    int startItem = updateMap["startItem"];
    resultMap["count"] = count;
    resultMap["startItem"] = startItem;
    List authDigitList = updateMap["authDigit"];
    List<Digit> resultAuthDigitList = [];
    if (authDigitList == null || authDigitList.length == 0) {
      resultMap["authDigit"] = resultAuthDigitList;
      return resultMap;
    }
    authDigitList.forEach((element) {
      var fullName = element["name"];
      var decimal = element["decimal"];
      var contract = element["contract"];
      var symbol = element["symbol"];
      var digitId = element["id"];
      switch (chain.chainType) {
        case ChainType.ETH:
        case ChainType.EthTest:
          Digit ethDigit = new EthDigit();
          ethDigit.shortName = symbol;
          ethDigit.fullName = fullName;
          ethDigit.decimal = decimal;
          ethDigit.contractAddress = contract;
          ethDigit.digitId = digitId;
          ethDigit.isVisible =
              false; //Loaded from the token list, set the invisible first, and compare it with the local chain before determining whether it is visible
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
          Digit ethDigit = new EthDigit();
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

  Future<Map> getSubChainBasicInfo(String genesisHash, int specVersion, int txVersion) async {
    Map updateMap = await WalletManager.getSubChainBasicInfo(genesisHash, specVersion, txVersion);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("getSubChainBasicInfo=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
      return updateMap;
    }
    return updateMap;
  }

  //default change Eee ChainBasicInfo
  Future<Map> updateSubChainBasicInfo(
      String infoId, int runtimeVersion, int txVersion, String genesisHash, String metadata, int ss58Format, int tokenDecimals, String tokenSymbol,
      {bool isDefault = true}) async {
    Map updateMap = await WalletManager.updateSubChainBasicInfo(
        infoId, runtimeVersion, txVersion, genesisHash, metadata, ss58Format, tokenDecimals, tokenSymbol, isDefault);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      Logger().e("updateSubChainBasicInfo=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
      return updateMap;
    }
    return updateMap;
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
