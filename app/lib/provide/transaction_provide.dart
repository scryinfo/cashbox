import 'package:app/model/chain.dart';
import 'package:flutter/foundation.dart';
import 'package:wallets/enums.dart';

class TransactionProvide with ChangeNotifier {
  String _toAddress;
  String _txValue;
  String _backup;
  String _digitName;
  String _fromAddress;
  String _gas;
  String _gasPrice;
  String _timeStamp;
  String _nonce;
  String _hash;
  int _decimal;
  String _contractAddress;
  String _cumulativeGasUsed;
  String _gasUsed;
  String _confirmations;
  String _balance;
  String _money;
  String _signInfo;
  ChainType _chainType;

  void emptyDataRecord() {
    _toAddress = "";
    _txValue = "";
    _backup = "";
    _hash = "";
    _decimal = 0;
    _gas = "";
    _gasPrice = "";
    _timeStamp = "";
    _nonce = "";
    _confirmations = "";
    _signInfo = "";
  }

  String get signInfo => _signInfo;

  setSignInfo(String value) {
    _signInfo = value;
  }

  ChainType get chainType => _chainType;

  setChainType(ChainType value) {
    _chainType = value;
  }

  String get balance => _balance;

  setBalance(String value) {
    _balance = value;
  }

  String get money => _money;

  setMoney(String value) {
    _money = value;
  }

  String get fromAddress => _fromAddress;

  void setFromAddress(String value) {
    _fromAddress = value;
  }

  int get decimal => _decimal;

  void setDecimal(int value) {
    _decimal = value;
  }

  String get nonce => _nonce;

  setNonce(String value) {
    _nonce = value;
  }

  String get gas => _gas;

  void setGas(String value) {
    _gas = value;
  }

  String get digitName => _digitName;

  void setDigitName(String value) {
    _digitName = value;
  }

  String get toAddress => _toAddress;

  void setToAddress(String value) {
    _toAddress = value;
  }

  String get txValue => _txValue;

  void setValue(String value) {
    _txValue = value;
  }

  String get backup => _backup;

  void setBackup(String value) {
    _backup = value;
  }

  String get gasPrice => _gasPrice;

  setGasPrice(String value) {
    _gasPrice = value;
  }

  String get timeStamp => _timeStamp;

  setTimeStamp(String value) {
    _timeStamp = value;
  }

  String get hash => _hash;

  setHash(String value) {
    _hash = value;
  }

  String get contractAddress => _contractAddress;

  setContractAddress(String value) {
    _contractAddress = value;
  }

  String get cumulativeGasUsed => _cumulativeGasUsed;

  setCumulativeGasUsed(String value) {
    _cumulativeGasUsed = value;
  }

  String get gasUsed => _gasUsed;

  setGasUsed(String value) {
    _gasUsed = value;
  }

  String get confirmations => _confirmations;

  setConfirmations(String value) {
    _confirmations = value;
  }
}
