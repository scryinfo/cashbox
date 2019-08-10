import 'package:wallet_manager/wallet_manager.dart';
import '../model/Wallet.dart';
import '../model/Chain.dart';

//钱包管理
class WalletMgr {
  List<Wallet> allWalletList = List();
  Wallet nowWallet;
  Chain nowChain;

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

  //创建新钱包
  Future<Wallet> createNewWallet(String walletName, String pwd) async {
    Wallet wallet = Wallet();
    //var isSuccess = await WalletAssist.createNewWallet(walletName, pwd);
    // 创建钱包接口，传参数 钱包名walletname+密码pwd，底层操作，创建好钱包、链、代币。
    // 返回是否创建钱包成功，跟钱包上所有关联的信息。
    allWalletList.add(wallet);
    return null;
  }

  //todo export  ? manager / wallet

  //todo import ? manager /wallet

  //从数据库 加载出 所有钱包数据
  Future<List<Wallet>> loadAllWalletList() async {
    var allWalletList = await WalletManager.loadAllWalletList();
    // todo 数据格式转换，返回
    return null;
  }

  //获取当前钱包
  Future<Wallet> getNowWallet() async {
    var allWalletList = await WalletManager.getNowWallet();
    // todo 数据格式转换，返回
    return null;
  }

  //设置当前钱包 bool是否成功
  Future<bool> setNowWallet(Wallet nowWallet) async {
    var isSuccess = await WalletManager.setNowWallet(
        {"walletId": nowWallet.walletId, "walletName": nowWallet.walletName});
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowWallet = nowWallet;
    }
    return isSuccess;
  }

  //获取当前链
  Future<Chain> getNowChain() async {
    var allWalletList = await WalletManager.getNowChain();
    // todo 数据格式转换，返回
    return null;
  }

  //设置当前链
  Future<bool> setNowChain(nowChain) async {
    var isSuccess = await WalletManager.setNowChain(nowChain);
    //todo 等待底层处理完成，更改 数据模型处。
    if (isSuccess) {
      this.nowChain = nowChain;
    }
    return isSuccess;
  }

  //todo save wallet
  //todo remove to wallet
  //助记词 + 密码 --->助记词导入钱包流程
  Future<Wallet> mnemonicSave(mnemonic, pwd) async {
    var isSuccess = await WalletManager.mnemonicSave(mnemonic, pwd);
    //todo
    return null;
  }

  //根据密码 + 加密助记词, 恢复出钱包--->恢复钱包，备份流程
  Future<Wallet> mnemonicExport(encodeMne, pwd) async {
    var isSuccess = await WalletManager.mnemonicExport(encodeMne, pwd);
    //todo
    return null;
  }

  //删除钱包
  Future<bool> deleteWallet(wallet) async {
    var isSuccess = await WalletManager.deleteWallet(wallet);
    // 数据模型层移除
    // todo db移除
    if (isSuccess) {
      allWalletList.removeAt(wallet);
    }
    return isSuccess;
  }
}
