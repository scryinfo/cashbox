import 'package:wallet_manager/wallet_manager.dart';
import '../model/Wallet.dart';
import 'dart:typed_data';

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
    var result = await WalletManager.mnemonicGenerate(count);
    return result;
  }

  // 是否已有钱包
  // apiNo:WM01
  Future<bool> isContainWallet() async {
    var isExist = await WalletManager.isContainWallet();
    //'return isExist;
    return null;
  }

  // 导出所有钱包
  // apiNo:WM02
  Future<List<Wallet>> loadAllWalletList() async {
    var allWalletList = await WalletManager.loadAllWalletList();
    print("allWalleetList=>"+allWalletList.length.toString());
    // todo 数据格式转换，返回
    return null;
  }

  // 保存钱包,钱包导入。  通过助记词创建钱包流程
  // apiNo:WM03
  Future<Wallet> saveWallet(
      String walletName, Uint8List pwd, Uint8List mnemonic) async {
    Wallet wallet = Wallet();
    var result = await WalletManager.saveWallet(walletName, pwd, mnemonic);
    // 创建钱包接口，传参数 钱包名walletname+密码pwd，底层操作，创建好钱包、链、代币。
    // 返回是否创建钱包成功，跟钱包上所有关联的信息。
    // todo result数据格式转换，返回
    allWalletList.add(wallet);
    return null;
  }

  // 钱包导出。 恢复钱包   /* 此处有助记词生成。注意及时释放*/
  // apiNo:WM04
  Future<Wallet> exportWallet(String walletId, String pwd) async {
    var result = await WalletManager.exportWallet(walletId, pwd);
    // todo result数据格式转换，返回
    return null;
  }

  //获取当前钱包
  // apiNo:WM05
  Future<Wallet> getNowWallet() async {
    var nowWallet = await WalletManager.getNowWallet();
    // todo 数据格式转换，返回
    return null;
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
