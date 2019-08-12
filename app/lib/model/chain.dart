import 'Digit.dart';
import 'package:wallet_manager/wallet_manager.dart';

class Chain {
  String chainId; //链Id
  String walletId; //钱包Id
  String chainAddress; //链地址
  List<Digit> digitsList;
  bool isVisible = true; //默认链可见
  ChainType chainType;

  Digit createNowChainDigit() {
    return Digit(chainId);
  }

  // 显示代币
  // apiNo:WM14
  Future<bool> showDigit(String digitId) async {
    var isSuccess = await WalletManager.showDigit(walletId, chainId, digitId);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return isSuccess;
  }

  // 隐藏代币
  // apiNo:WM15
  Future<bool> hideDigit(String digitId) async {
    var isSuccess = await WalletManager.hideDigit(walletId, chainId, digitId);
    if (isSuccess) {
      //todo 数据格式
      //chainList.remove(chain);
    }
    return isSuccess;
  }

  // 添加代币 todo 2.0 待确定数据格式
  Future<bool> addDigit(Digit digit) async {
    digitsList.add(digit);
    //todo 数据格式
/*    var isSuccess = await WalletManager.addDigit(
        digit.digitId,
        digit.chainId,
        digit.address,
        digit.balance,
        digit.contractAddress,
        digit.shortName,
        digit.fullName,
        digit.decimal);
    if (isSuccess) {
      digitsList.add(digit);
    }*/
    return null;
  }

  // 添加代币list todo 2.0 待确定数据格式
  Future<bool> addDigitList(List<Digit> digitList) async {
    //todo db操作 原子性
    var isSuccess = await WalletManager.addDigitList(digitList);
    if (isSuccess) {
      digitsList.addAll(digitList);
    }
    return isSuccess;
  }

  // 删除代币 todo 2.0 待确定数据格式
  Future<bool> deleteDigit(digit) async {
    //todo db操作 原子性
    var isSuccess = await WalletManager.deleteDigit(digit);
    if (isSuccess) {
      digitsList.remove(digit);
    }
    return isSuccess;
  }
}

enum ChainType { ETH, BTC, EEE }

class ChainETH extends Chain {
  ChainETH(chainId, walletId) {
    this.chainId = chainId;
    this.walletId = walletId;
  }

  @override
  ChainType get chainType => ChainType.ETH;
}

class ChainBTC extends Chain {
  ChainBTC(chainId, walletId) {
    this.chainId = chainId;
    this.walletId = walletId;
  }

  @override
  ChainType get chainType => ChainType.BTC;
}

class ChainEEE extends Chain {
  ChainEEE(chainId, walletId) {
    this.chainId = chainId;
    this.walletId = walletId;
  }

  @override
  ChainType get chainType => ChainType.EEE;
}
