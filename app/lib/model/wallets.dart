import 'package:app/model/mnemonic.dart';
import 'package:app/model/wallet.dart';
import 'package:wallet_manager/wallet_manager.dart';

import 'dart:typed_data';

import 'Chain.dart';
import 'Digit.dart';

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
  Future<Mnemonic> createMnemonic(int count) async {
    var resultMap = await WalletManager.mnemonicGenerate(count);
    var mnemonic = Mnemonic();
    mnemonic.mn = resultMap["mn"];
    mnemonic.mnId = resultMap["mnId"];
    mnemonic.status = resultMap["status"];
    return mnemonic;
  }

  // 是否已有钱包
  // apiNo:WM01
  Future<bool> isContainWallet() async {
    var isExist = await WalletManager.isContainWallet();
    return isExist;
  }

  // 导出所有钱包
  // apiNo:WM02
  Future<List<Wallet>> loadAllWalletList() async {
    var allWalletList = List<Wallet>();
    var jniList = await WalletManager.loadAllWalletList();
    print("dart ==> jniList=====>" + jniList.toString());
    if (jniList.isNotEmpty) {
      for (var i = 0; i < jniList.length; i++) {
        var walletM = Wallet();
        walletM.walletName = jniList[i]["walletName"].toString();
        walletM.walletId = jniList[i]["walletId"].toString();
        //walletM.walletType = jniList[i]["walletType"];//todo 数据格式更改
        walletM.nowChainId = jniList[i]["nowChainId"].toString();
        walletM.creationTime = jniList[i]["creationTime"].toString();

        var eeeChain = jniList[i]["eeeChain"];

        Chain chainEeeM = ChainEEE();
        chainEeeM.chainId = eeeChain["chainId"];
        chainEeeM.chainAddress = eeeChain["chainAddress"];
        chainEeeM.chainType = eeeChain["chainType"];
        chainEeeM.isVisible = eeeChain["isVisible"];
        chainEeeM.walletId = eeeChain["walletId"];

        List eeeChainDigitList = eeeChain["eeeChainDigitList"];
        for (var j = 0; j < eeeChainDigitList.length; j++) {
          var digit = eeeChainDigitList[j];
          Digit digitM = EeeDigit();
          digitM.digitId = digit["digitId"];
          digitM.chainId = digit["chainId"];
          digitM.address = digit["address"];
          digitM.shortName = digit["shortName"];
          digitM.fullName = digit["fullName"];
          digitM.balance = digit["balance"];
          digitM.isVisible = digit["isVisible"];
          digitM.decimal = digit["decimal"];
          digitM.urlImg = digit["imgUrl"];

          ///将digit 添加到digitList里面
          chainEeeM.digitsList.add(digitM);
        }

        ///将chain 添加到chainList里面
        walletM.chainList.add(chainEeeM);

        ///将wallet 添加到walletList里面
        allWalletList.add(walletM);
      }
    }
    return allWalletList;
  }

  // 保存钱包,钱包导入。  通过助记词创建钱包流程
  // apiNo:WM03
  Future<Wallet> saveWallet(String walletName, Uint8List pwd,
      Uint8List mnemonic, WalletType walletType) async {
    Wallet wallet = Wallet();
    int walletTypeToInt = 0;
    switch (walletType) {
      case WalletType.WALLET:
        walletTypeToInt = 0;
        break;
      default:
        walletTypeToInt = 1;
        break;
    }
    var result = await WalletManager.saveWallet(
        walletName, pwd, mnemonic, walletTypeToInt);
    // 创建钱包接口，传参数 钱包名walletname+密码pwd，底层操作，创建好钱包、链、代币。
    // 返回是否创建钱包成功，跟钱包上所有关联的信息。
    // todo result数据格式转换，返回
    allWalletList.add(wallet);
    return null;
  }

  // 钱包导出。 恢复钱包   /* 此处有助记词生成。注意及时释放*/
  // apiNo:WM04
  Future<Wallet> exportWallet(String walletId, Uint8List pwd) async {
    var result = await WalletManager.exportWallet(walletId, pwd);
    // todo result数据格式转换，返回
    return null;
  }

  //获取当前钱包
  // apiNo:WM05
  Future<String> getNowWallet() async {
    var walletId = await WalletManager.getNowWallet();
    // todo 数据格式转换，返回
    return walletId;
  }

  //设置当前钱包 bool是否成功
  //  apiNo:WM06
  Future<bool> setNowWallet(String walletId) async {
    var isSuccess = await WalletManager.setNowWallet(walletId);
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowWallet = nowWallet;
    }
    return isSuccess;
  }

  //删除钱包。 钱包设置可删除，链设置隐藏。
  // apiNo:WM07.
  Future<bool> deleteWallet(String walletId) async {
    var isSuccess = await WalletManager.deleteWallet(walletId);
    // db移除 todo 数据格式转换
    Wallet wallet;
    if (isSuccess) {
      // 数据模型层移除
      allWalletList.remove(wallet);
    }
    return isSuccess;
  }
}
