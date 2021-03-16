import 'package:app/model/token_rate.dart';

class TokenM {
  String tokenId; //Token id
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
  TokenRate tokenRate; //market price
  String lastTxInfo; //The last transaction on the chain
}
