import 'package:app/model/rate.dart';

abstract class Digit {
  String digitId; //Token id
  String chainId; //Chain id
  String shortName; //Abbreviated name
  String fullName; //full name
  String balance; //Quantity
  int decimal; //Precision, number of digits after decimal point
  String money = "0"; //Amount = market price rate * quantity balance
  String address; //Token address
  String contractAddress = ""; //Token contract address
  String urlImg; //Token icon icon address
  bool isVisible = true; //Is the token visible
  DigitRate digitRate; //market price
  String lastTxInfo; //The last transaction on the chain
}

class EeeDigit extends Digit {}

class BtcDigit extends Digit {}

class EthDigit extends Digit {
  String contractAddress; //Contract address

  @override
  void set balance(String _balance) {
    super.balance = _balance;
  }

  @override
  String get balance => super.balance;
}
