import 'Digit.dart';
import 'package:walletassist/walletassist.dart';

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

  Future<bool> addDigit(Digit digit) async {
    digitsList.add(digit);
    //todo 数据格式
    var isSuccess = await WalletAssist.addDigit(digit);
    if (isSuccess) {
      digitsList.add(digit);
    }
    return isSuccess;
  }

  Future<bool> addDigitList(List<Digit> digitList) async {
    //todo db操作 原子性
    var isSuccess = await WalletAssist.addDigitList(digitList);
    if (isSuccess) {
      digitsList.addAll(digitList);
    }
    return isSuccess;
  }

  Future<bool> deleteDigit(digit) async {
    //todo db操作 原子性
    var isSuccess = await WalletAssist.deleteDigit(digit);
    if (isSuccess) {
      digitsList.remove(digit);
    }
    return isSuccess;
  }
}

enum ChainType { ETH, BTC }

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
