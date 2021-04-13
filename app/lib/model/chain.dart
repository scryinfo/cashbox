import 'dart:typed_data';

import 'package:app/model/token.dart';
import 'package:wallet_manager/wallet_manager.dart';
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

  /*static String chainTypeToValue(ChainType chainType) {
    switch (chainType) {
      case ChainType.BTC:
        return "BTC";
      case ChainType.BTC_TEST:
        return "BTC_TEST";
      case ChainType.ETH:
        return "ETH";
      case ChainType.ETH_TEST:
        return "ETH_TEST";
      case ChainType.EEE:
        return "EEE";
      case ChainType.EEE_TEST:
        return "EEE_TEST";
      default:
        return ""; //UNKNOWN
    }
  }

  //At the jni interface, the definition is the same NativeLib.Chain Type
  static int chainTypeToInt(ChainType chainType) {
    switch (chainType) {
      case ChainType.BTC:
        return 1;
      case ChainType.BTC_TEST:
        return 2;
      case ChainType.ETH:
        return 3;
      case ChainType.ETH_TEST:
        return 4;
      case ChainType.EEE:
        return 5;
      case ChainType.EEE_TEST:
        return 6;
      default:
        return 0;
    }
  }

  static ChainType intToChainType(int chainTypeInt) {
    ChainType chainType;
    switch (chainTypeInt) {
      *//*Mark: Definition needs to be consistent with JNI*//*
      case 1:
        chainType = ChainType.BTC;
        break;
      case 2:
        chainType = ChainType.BTC_TEST;
        break;
      case 3:
        chainType = ChainType.ETH;
        break;
      case 4:
        chainType = ChainType.ETH_TEST;
        break;
      case 5:
        chainType = ChainType.EEE;
        break;
      case 6:
        chainType = ChainType.EEE_TEST;
        break;
      default:
        chainType = ChainType.UNKNOWN;
    }
    return chainType;
  }*/

  // Show tokens
  // apiNo:WM14
  Future<bool> showDigit(TokenM digit) async {
    /*Map showDigitMap = await WalletManager.showDigit(walletId, Chain.chainTypeToInt(chainType), digit.digitId);
    int status = showDigitMap["status"];
    bool isShowDigit = showDigitMap["isShowDigit"];
    if (status == 200) {
      if (isShowDigit) {
        //execution succeed
        for (int i = 0; i < digitsList.length; i++) {
          var element = digitsList[i];
          if (element.digitId == digit.digitId) {
            digitsList[i].isVisible = true;
            break;
          }
        }
        digit.isVisible = true;
        return isShowDigit;
      }
    }*/
    return false; //Execution failed
  }

  // Hidden tokens
  // apiNo:WM15
  Future<bool> hideDigit(TokenM digit) async {
    /*Map hideDigitMap = await WalletManager.hideDigit(walletId, Chain.chainTypeToInt(chainType), digit.digitId);
    int status = hideDigitMap["status"];
    bool isHideDigit = hideDigitMap["isHideDigit"];
    if (status == 200) {
      if (isHideDigit == true) {
        for (int i = 0; i < digitsList.length; i++) {
          var element = digitsList[i];
          if (element.digitId == digit.digitId) {
            digitsList[i].isVisible = false;
            break;
          }
        }
        digit.isVisible = false;
        return isHideDigit; //execution succeed
      }
    }*/
    return false;
  }
}

class ChainETH extends Chain {}

class ChainBTC extends Chain {}

class ChainEEE extends Chain {
  Future<Map<dynamic, dynamic>> eeeEnergyTransfer(String from, Uint8List pwd, String to, String value, String extendMsg) async {
    Map map = await WalletManager.eeeEnergyTransfer(from, pwd, to, value, extendMsg);
    return map;
  }
}
