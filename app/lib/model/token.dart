class TokenM {
  String tokenId = ""; //Token id
  String chainId = ""; //Chain id
  String shortName = ""; //Abbreviated name
  String fullName = ""; //full name
  String balance = ""; //Quantity
  int decimal = 0; //Precision, number of digits after decimal point
  String money = "0"; //Amount = market price rate * quantity balance
  String address = ""; //Token address
  String contractAddress = ""; //Token contract address
  String urlImg = ""; //Token icon icon address
  bool isVisible = true; //Is the token visible
  String lastTxInfo = ""; //The last transaction on the chain
  String gasPrice = "0.0"; // unit: Gwei  sync with server end
  int gasLimit = 0;
}

class EeeToken extends TokenM {}

class BtcToken extends TokenM {}

class EthToken extends TokenM {}
