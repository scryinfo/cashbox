import 'package:app/model/rate.dart';

class Digit {
  String digitId; //代币id
  String chainId; //链id
  String shortName; //缩写名称
  String fullName; //全名
  String balance; //数量
  int decimal; //精度，小数点后的位数
  String money; //金额 = 市场价格rate * 数量balance
  String address; //代币地址
  String urlImg; //代币图标icon地址
  bool isVisible; //代币是否可见
  DigitRate digitRate; //市场价格
  String lastTxInfo; //链上最后一笔交易
}

class EeeDigit extends Digit {
  EeeDigit(digitId, chainId) {
    this.chainId = chainId;
    this.digitId = digitId;
  }
}

class BtcDigit extends Digit {
  BtcDigit(digitId, chainId) {
    this.chainId = chainId;
    this.digitId = digitId;
  }
}

class EthDigit extends Digit {
  EthDigit(digitId, chainId) {
    this.chainId = chainId;
    this.digitId = digitId;
  }

  String contractAddress; //合约地址
}
