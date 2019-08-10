import 'package:wallet_manager/wallet_manager.dart';
import '../model/Wallet.dart';
import 'dart:typed_data';

//钱包管理
class WalletMgr {
  List<Wallet> allWalletList = List();
  Wallet nowWallet;

  //工厂单例类实现
  factory WalletMgr() => _getInstance();

  static WalletMgr get instance => _getInstance();
  static WalletMgr _instance;

  WalletMgr._internal() {
    //init data
  }

  static WalletMgr _getInstance() {
    if (_instance == null) {
      _instance = new WalletMgr._internal();
    }
    return _instance;
  }

  //是否已经有创建的钱包
  Future<bool> isExistWallet() async {
    //var isExist = await WalletAssist.isExistWallet();
    //return isExist;
    return null;
  }

  // 创建助记词，待验证正确通过，由底层创建钱包完成，应用层做保存
  Future<Uint8List> createMnemonic(int count) async {
    var result = await WalletManager.mnemonicGenerate(count);
    return null;
  }

  Future<Wallet> saveWallet(
      String walletName, String pwd, Uint8List mnemonic) async {
    Wallet wallet = Wallet();
    var result = await WalletManager.saveWallet(walletName, pwd, mnemonic);
    // 创建钱包接口，传参数 钱包名walletname+密码pwd，底层操作，创建好钱包、链、代币。
    // 返回是否创建钱包成功，跟钱包上所有关联的信息。
    // todo result数据格式转换，返回
    allWalletList.add(wallet);
    return null;
  }

  //钱包导出。 恢复钱包
  Future<Wallet> exportWallet(String pwd, String walletId) async {
    var result = await WalletManager.exportWallet(pwd, walletId);
    // todo result数据格式转换，返回
    return null;
  }

  //钱包导入。  通过助记词创建钱包流程
  Future<Wallet> importWallet(String mne, String pwd, String walletName) async {
    var result = await WalletManager.importWallet(mne, pwd, walletName);
    // todo result数据格式转换，返回
    //allWalletList.add(result);
    return null;
  }

  //从数据库 加载出 所有钱包数据
  Future<List<Wallet>> loadAllWalletList() async {
    var allWalletList = await WalletManager.loadAllWalletList();
    // todo 数据格式转换，返回
    return null;
  }

  //获取当前钱包
  Future<Wallet> getNowWallet() async {
    var nowWallet = await WalletManager.getNowWallet();
    // todo 数据格式转换，返回
    return null;
  }

  //设置当前钱包 bool是否成功
  Future<bool> setNowWallet(String walletId) async {
    var isSuccess = await WalletManager.setNowWallet({"walletId": walletId});
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowWallet = nowWallet;
    }
    return isSuccess;
  }

  //删除钱包。 钱包设置可删除，链设置隐藏。
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
