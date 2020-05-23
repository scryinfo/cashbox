import 'package:app/global_config/global_config.dart';
import 'package:app/model/wallet.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/util/utils.dart';
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

  initWalletBasicData() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var isFinishInit = spUtil.getBool(GlobalConfig.isInitAppConfig);
    if (isFinishInit == null || !isFinishInit) {
      SharedPreferenceUtil.initVersion(); //初始化 接口ip、版本信息等 到本地文件保存
    }
    WalletManager.initWalletBasicData(); //初始化数据库部分数据
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
      int walletType = jniList[walletIndex]["walletType"];
      if (walletType == 0) {
        walletM.walletType = WalletType.TEST_WALLET;
      } else {
        walletM.walletType = WalletType.WALLET;
      }
      walletM
        ..walletName = jniList[walletIndex]["walletName"].toString()
        ..walletId = jniList[walletIndex]["walletId"].toString()
        ..nowChainId = jniList[walletIndex]["nowChainId"].toString()
        ..creationTime = jniList[walletIndex]["creationTime"].toString()
        ..isNowWallet = jniList[walletIndex]["isNowWallet"];
      {
        var eeeChain = jniList[walletIndex]["eeeChain"];
        Chain chainEeeM = ChainEEE();
        chainEeeM
          ..chainId = eeeChain["chainId"]
          ..chainAddress = eeeChain["chainAddress"]
          ..chainType = Chain.intToChainType(eeeChain["chainType"])
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
        ChainETH chainEthM = ChainETH();
        var ethChain = jniList[walletIndex]["ethChain"];
        chainEthM
          ..chainId = ethChain["chainId"]
          ..chainAddress = ethChain["chainAddress"]
          ..chainType = Chain.intToChainType(ethChain["chainType"])
          ..isVisible = true
          ..walletId = jniList[walletIndex]["walletId"];
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
      if (walletM.isNowWallet) {
        this.nowWallet = walletM;
        this.nowWallet.nowChain = this.nowWallet.getChainByChainId(this.nowWallet.nowChainId);
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
      case WalletType.TEST_WALLET:
        walletTypeToInt = 0;
        break;
      case WalletType.WALLET:
        walletTypeToInt = 1;
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
      //改model层数据
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

  Future<Map> ethTxSign(String walletId, int chainType, String fromAddress, String toAddress, String contractAddress, String value, String backup,
      Uint8List pwd, String gasPrice, String gasLimit, String nonce,
      {int decimal = 18}) async {
    Map ethTxSignMap = await WalletManager.ethTxSign(
        walletId, chainType, fromAddress, toAddress, contractAddress, value, backup, pwd, gasPrice, gasLimit, nonce,
        decimal: decimal);
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

  Future<Map> decodeAdditionData(String inputData) async {
    if (inputData == null || inputData.trim() == "") {
      return null;
    }
    Map decodeMap = await WalletManager.decodeAdditionData(inputData);
    int status = decodeMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("decodeAdditionData=>", "error status code is" + status.toString() + "||message is=>" + decodeMap["message"].toString());
    }
    return decodeMap;
  }

  //数据库 更新余额信息
  Future<Map> updateDigitBalance(String address, String digitId, String balance) async {
    if (!Utils.checkByEthAddressFormat(address)) {
      return null;
    }
    try {
      if (double.parse(balance) <= 0 || balance.trim() == "") {
        return null;
      }
    } catch (e) {
      LogUtil.e("updateDigitBalance=>", "error status code is" + e.toString());
    }
    Map updateMap = await WalletManager.updateDigitBalance(address, digitId, balance);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("updateDigitBalance=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
    } else {
      var index = this.nowWallet.nowChain.digitsList.indexWhere((element) => (element.digitId == digitId));
      if (index != -1) {
        this.nowWallet.nowChain.digitsList[index].balance = balance;
      }
    }
    return updateMap;
  }

  //
  eeeAccountInfoKey(String address) async {
    Map eeeAccountMap = await WalletManager.eeeAccountInfoKey(address);
    return eeeAccountMap;
  }

  //
  decodeAccountInfo(String encodeData) async {
    Map eeeAccountMap = await WalletManager.decodeAccountInfo(encodeData);
    return eeeAccountMap;
  }

  //在 当前钱包、当前链下，增加新代币的数据模型
  addDigitToChainModel(String walletId, Chain chain, String digitId) async {
    Map addDigitModelMap =
        await WalletManager.addDigitToChainModel(walletId, Chain.chainTypeToInt(Wallets.instance.nowWallet.nowChain.chainType), digitId);
    int status = addDigitModelMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("addDigitModelMap=>", "error status code is" + status.toString() + "||message is=>" + addDigitModelMap["message"].toString());
    } else {
      Wallets.instance.loadAllWalletList(isForceLoadFromJni: true); //在digitList增加这个代币model,重新加载
    }
    return addDigitModelMap;
  }

  updateAuthDigitList(String digitData) async {
    Map updateMap = await WalletManager.updateAuthDigitList(digitData);
    int status = updateMap["status"];
    if (status == null || status != 200) {
      LogUtil.e("updateAuthDigitList=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
    }
    return updateMap;
  }

  Future<Map> getNativeAuthDigitList(Chain chain, int startIndex, int pageSize) async {
    Map resultMap = Map();
    Map updateMap = await WalletManager.getNativeAuthDigitList(Chain.chainTypeToInt(chain.chainType), startIndex, pageSize);
    int status = updateMap["status"];
    print("getAuthDigitList status==>" + status.toString());
    if (status == null || status != 200) {
      LogUtil.e("updateAuthDigitList=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());
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
      print("count=====>" + count.toString() + "startItem=====>" + startItem.toString());
      return resultMap;
    }
    print("count=====>" + count.toString() + "startItem=====>" + startItem.toString() + "length=====>" + authDigitList.length.toString());
    authDigitList.forEach((element) {
      var name = element["name"];
      var decimal = element["decimal"];
      var contract = element["contract"];
      var symbol = element["symbol"];
      print("name=====>" + name + "decimal=====>" + decimal.toString() + "contract=====>" + contract + "symbol=====>" + symbol);
      switch (chain.chainType) {
        case ChainType.ETH:
        case ChainType.ETH_TEST:
          Digit ethDigit = new EthDigit();
          ethDigit.shortName = name;
          ethDigit.decimal = decimal;
          ethDigit.contractAddress = contract;
          resultAuthDigitList.add(ethDigit);
          break;
        case ChainType.BTC:
        case ChainType.BTC_TEST:
          break;
        case ChainType.EEE:
        case ChainType.EEE_TEST:
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
    if (Utils.checkByEthAddressFormat(param)) {
      updateMap = await WalletManager.queryDigit(Chain.chainTypeToInt(chain.chainType), "", param);
    } else {
      updateMap = await WalletManager.queryDigit(Chain.chainTypeToInt(chain.chainType), param, "");
    }
    int status = updateMap["status"];
    print("queryDigit status==>" + status.toString());
    if (status == null || status != 200) {
      LogUtil.e("queryDigit=>", "error status code is" + status.toString() + "||message is=>" + updateMap["message"].toString());

      return resultMap;
    }
    int count = updateMap["count"];
    int startItem = updateMap["startItem"];
    List authDigitList = updateMap["authDigit"];
    print("count=====>" + count.toString() + "startItem=====>" + startItem.toString());

    resultMap["count"] = count;
    resultMap["startItem"] = startItem;

    if (authDigitList == null || authDigitList.length == 0) {
      return resultMap;
    }
    authDigitList.forEach((element) {
      var name = element["name"];
      var decimal = element["decimal"];
      var contract = element["contract"];
      var symbol = element["symbol"];
      print("name=====>" + name + "decimal=====>" + decimal.toString() + "contract=====>" + contract + "symbol=====>" + symbol);
      switch (chain.chainType) {
        case ChainType.ETH:
        case ChainType.ETH_TEST:
          Digit ethDigit = new EthDigit();
          ethDigit.shortName = name;
          ethDigit.decimal = decimal;
          ethDigit.contractAddress = contract;
          resultAuthDigitList.add(ethDigit);
          break;
        case ChainType.BTC:
        case ChainType.BTC_TEST:
          break;
        case ChainType.EEE:
        case ChainType.EEE_TEST:
          break;
        default:
          break;
      }
    });
    resultMap["authDigit"] = resultAuthDigitList;
    return resultMap;
  }
}
