import 'package:app/model/wallet.dart';
import 'package:app/util/log_util.dart';
import 'package:wallet_manager/wallet_manager.dart';

import 'dart:typed_data';

import 'chain.dart';
import 'digit.dart';
import 'ffi/wallet_ffi.dart';

//钱包管理
class Wallets {
  List<Wallet> allWalletList = List();
  Wallet nowWallet;

  //工厂单例类实现
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

  // 创建助记词，待验证正确通过，由底层创建钱包完成，应用层做保存
  // apiNo:MM00
  Future<Uint8List> createMnemonic(int count) async {
    Map resultMap = await WalletManager.mnemonicGenerate(count);
    int status = resultMap["status"];
    if (status == null) {
      LogUtil.e("createMnemonic=>", "not find status code");
      return null;
    }
    if (resultMap["status"] == 200) {
      return resultMap["mn"];
    } else {
      LogUtil.e("createMnemonic=>", "error status is=>" + resultMap["status"].toString() + "||message is=>" + resultMap["message"].toString());
      return null;
    }
  }

  // 是否已有钱包
  // apiNo:WM01
  Future<bool> isContainWallet() async {
    Map containWalletMap = await WalletManager.isContainWallet();
    int status = containWalletMap["status"];
    String message = containWalletMap["message"];
    if (status == null) {
      LogUtil.e("isContainWallet=>", "not find status code");
      return false;
    }
    if (status == 200) {
      return containWalletMap["isContainWallet"];
    } else {
      LogUtil.e("isContainWallet=>", "error status is=>" + containWalletMap["status"].toString() + "||message is=>" + message.toString());
      return false;
    }
  }

  // 导出所有钱包
  // apiNo:WM02
  Future<List<Wallet>> loadAllWalletList({bool isForceLoadFromJni = false}) async {
    ///判是否需要重新从JNI再获取一次，加载过就是有缓存的。
    if (!isForceLoadFromJni) {
      return allWalletList;
    }
    allWalletList = [];
    List jniList = await WalletManager.loadAllWalletList();
    if (jniList == null || jniList.isEmpty || jniList.length == 0) {
      return allWalletList;
    }
    print("loadAllWalletList  => jniList is=====>" + jniList.toString());
    for (int i = 0; i < jniList.length; i++) {
      int walletIndex = i;
      Wallet walletM = Wallet();
      int walletStatus = jniList[walletIndex]["status"];
      if (walletStatus == null || walletStatus != 200) {
        LogUtil.e("loadAllWalletList=>", "error status code is" + walletStatus.toString() + "||message is=>" + jniList[walletIndex]["message"]);
        continue; //这个钱包数据有问题，跳过取下个wallet
      }
      walletM
        ..walletName = jniList[walletIndex]["walletName"].toString()
        ..walletId = jniList[walletIndex]["walletId"].toString()
        ..nowChainId = jniList[walletIndex]["nowChainId"].toString()
        ..creationTime = jniList[walletIndex]["creationTime"].toString()
        ..isNowWallet = jniList[walletIndex]["isNowWallet"];
      //..walletType = jniList[walletIndex]["walletType"];//todo 数据格式更改
      {
        var eeeChain = jniList[walletIndex]["eeeChain"];
        Chain chainEeeM = ChainEEE();
        chainEeeM
          ..chainId = eeeChain["chainId"]
          ..chainAddress = eeeChain["chainAddress"]
          ..chainType = chainEeeM.intToChainType(eeeChain["chainType"])
          ..isVisible = eeeChain["isVisible"]
          ..walletId = eeeChain["walletId"];
        List eeeChainDigitList = eeeChain["eeeChainDigitList"];
        for (int j = 0; j < eeeChainDigitList.length; j++) {
          Map digitInfoMap = eeeChainDigitList[j];
          Digit digitM = EeeDigit();
          digitM
            ..digitId = digitInfoMap["digitId"]
            ..chainId = digitInfoMap["chainId"]
            ..contractAddress = digitInfoMap["contractAddress"]
            ..address = digitInfoMap["address"]
            ..shortName = digitInfoMap["shortName"]
            ..fullName = digitInfoMap["fullName"]
            ..balance = digitInfoMap["balance"]
            ..isVisible = digitInfoMap["isVisible"]
            ..decimal = digitInfoMap["decimal"]
            ..urlImg = digitInfoMap["urlImg"];
          chainEeeM.digitsList.add(digitM);
        }
        walletM.chainList.add(chainEeeM); ////将chain 添加到chainList里面
      }
      {
        //ETH
        Chain chainEthM = ChainETH();
        var ethChain = jniList[walletIndex]["ethChain"];
        chainEthM
          ..chainId = ethChain["chainId"]
          ..chainAddress = ethChain["chainAddress"]
          ..chainType = chainEthM.intToChainType(ethChain["chainType"])
          ..isVisible = true
          ..walletId = jniList[walletIndex]["walletId"];
        //todo add digit to ETH chain
        List ethChainDigitList = ethChain["ethChainDigitList"];
        for (int j = 0; j < ethChainDigitList.length; j++) {
          Map digitInfoMap = ethChainDigitList[j];
          Digit digitM = EthDigit();
          digitM
            ..digitId = digitInfoMap["digitId"]
            ..chainId = digitInfoMap["chainId"]
            ..contractAddress = digitInfoMap["contractAddress"]
            ..address = digitInfoMap["address"]
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
      //todo    BTC 链信息还没有加入
      {
        //BTC
      }

      allWalletList.add(walletM); ////将wallet 添加到walletList里面

    }

    return allWalletList;
  }

  // 保存钱包,钱包导入。  通过助记词创建钱包流程
  // apiNo:WM03           //todo 2.0 优化saveWallet接口，返回值类型
  Future<bool> saveWallet(String walletName, Uint8List pwd, Uint8List mnemonic, WalletType walletType) async {
    int walletTypeToInt = 0;
    switch (walletType) {
      case WalletType.WALLET:
        walletTypeToInt = 0;
        break;
      default:
        walletTypeToInt = 1;
        break;
    }
    Map saveWalletMap = await WalletManager.saveWallet(walletName, pwd, mnemonic, walletTypeToInt);
    if (saveWalletMap["status"] == null) {
      LogUtil.e("saveWallet=>", "not find status code");
      return false;
    }
    if (saveWalletMap["status"] == 200) {
      return true;
    }
    return false;
  }

  // 钱包导出。 恢复钱包   /* 此处有助记词生成。注意及时释放*/
  // apiNo:WM04
  Future<Map> exportWallet(String walletId, Uint8List pwd) async {
    Map mnemonicMap = await WalletManager.exportWallet(walletId, pwd);
    return mnemonicMap;
  }

  //获取当前钱包
  // apiNo:WM05
  Future<String> getNowWalletId() async {
    var walletId = await WalletManager.getNowWalletId();
    return walletId;
  }

  Future<Wallet> getNowWalletModel() async {
    String walletId = await getNowWalletId();
    Wallet walletModel = await getWalletByWalletId(walletId);
    return walletModel;
  }

  Future<Wallet> getWalletByWalletId(String walletId) async {
    Wallet chooseWallet;
    for (int i = 0; i < allWalletList.length; i++) {
      int index = i;
      if (allWalletList[index].walletId == walletId) {
        chooseWallet = allWalletList[index];
        break; //找到，终止循环
      }
    }
    return chooseWallet;
  }

  //设置当前钱包 bool是否成功
  //  apiNo:WM06
  Future<bool> setNowWallet(String walletId) async {
    Map setNowWalletMap = await WalletManager.setNowWallet(walletId);
    int status = setNowWalletMap["status"];
    if (status == null) {
      LogUtil.e("setNowWallet=>", "not find status code");
      return false;
    }
    if (status == 200) {
      return setNowWalletMap["isSetNowWallet"];
    } else {
      LogUtil.e("setNowWallet=>", "error status code is" + status.toString() + "||message is=>" + setNowWalletMap["message"]);
      return false;
    }
  }

  //删除钱包。 钱包设置可删除，链设置隐藏。
  // apiNo:WM07.
  Future<Map> deleteWallet(String walletId, Uint8List pwd) async {
    Map deleteWalletMap = await WalletManager.deleteWallet(walletId, pwd);
    int status = deleteWalletMap["status"];
    bool isSuccess = deleteWalletMap["isDeletWallet"];
    if (status == null) {
      LogUtil.e("deleteWallet=>", "not find status code");
      return null;
    }
    if (status == 200 && isSuccess) {
      // 数据模型层移除
      allWalletList.remove(getWalletByWalletId(walletId));
      return deleteWalletMap;
    } else {
      LogUtil.e("deleteWallet=>", "error status code is" + status.toString() + "||message is=>" + deleteWalletMap["message"]);
      return deleteWalletMap;
    }
  }

  Future<Map> eeeTxSign(String walletId, Uint8List pwd, String rawTx) async {
    Map eeeTxSignMap = await WalletManager.eeeTxSign(walletId, pwd, rawTx);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }

  Future<Map> ethTxSign(String walletId, int chainType,String fromAddress, String toAddress, String contractAddress,
      String value, String backup, Uint8List pwd, String gasPrice,String gasLimit,String nonce) async {
    // WalletFFI walletFFI = new WalletFFI();
    // // todo ffi  assemble TX
    // var txResultString = walletFFI.assembleEthTx(walletId, value, fromAddress, toAddress, backup);
    // if (txResultString.isEmpty || txResultString.trim() == "") {
    //   LogUtil.e("ethTxSign=======>", "txResultString.isEmpty");
    //   return new Map();
    // }
    Map ethTxSignMap = await WalletManager.ethTxSign(walletId, chainType,fromAddress,toAddress,contractAddress,value,backup,pwd,  gasPrice,gasLimit,nonce);
    // todo Sign assembled TxInfo
    int status = ethTxSignMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + ethTxSignMap["message"]);
    }
    return ethTxSignMap;
  }

  Future<Map> eeeSign(String walletId, Uint8List pwd, String rawTx) async {
    Map eeeTxSignMap = await WalletManager.eeeSign(walletId, pwd, rawTx);
    int status = eeeTxSignMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("eeeTxSign=>", "error status code is" + status.toString() + "||message is=>" + eeeTxSignMap["message"]);
    }
    return eeeTxSignMap;
  }
}
