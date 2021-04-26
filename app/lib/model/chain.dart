import 'package:app/model/token.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/wallets_c.dc.dart';

abstract class Chain {
  String chainId; //Chain Id
  String walletId; //Wallet Id
  String chainAddress; //Chain address
  Address walletAddress;
  String pubKey; //Chain address
  List<TokenM> digitsList = [];
  List<TokenM> _visibleDigitsList = [];
  bool isVisible = true; //The default chain is visible
  ChainType chainType;

  //List of visible tokens: digit.isVisible = true type
  List<TokenM> getVisibleDigitList() {
    if (_visibleDigitsList != null && _visibleDigitsList.length != 0) {
      return _visibleDigitsList;
    }
    _visibleDigitsList = [];
    digitsList.forEach((element) {
      if (element.isVisible) {
        _visibleDigitsList.add(element);
      }
    });
    return _visibleDigitsList;
  }
}

class ChainETH extends Chain {}

class ChainBTC extends Chain {}

class ChainEEE extends Chain {}
