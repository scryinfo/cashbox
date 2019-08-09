class Digit {
  String digitId; //代币id
  String chainId; //链id
  String shortName; //缩写名称
  String fullName; //全名
  String balance; //数量
  String money; //金额
  String address; //代币地址
  String contractAddress; //合约地址
  String urlImg; //代币图标icon地址
  bool isVisible; //是否可见
  int decimals; //精度，小数点后的位数
  Digit(chainId) {
    this.chainId = chainId;
  }
}
