import 'package:flutter/foundation.dart';

class TransactionProvide with ChangeNotifier {
  String _toAddress;
  String _txValue;
  String _backup;
  String _digitName;

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
}
