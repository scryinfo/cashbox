import 'package:flutter/foundation.dart';

class WalletManagerProvide with ChangeNotifier {
  String _walletName;
  String _walletId;
  String _locale; //系统语言

  get walletName => _walletName;

  get walletId => _walletId;

  get locale => _locale;

  /*检查每次调用完毕，清理数据记录*/
  void emptyData() {
    this._walletName = null;
    this._walletId = null;
  }

  void setWalletName(String walletName) {
    this._walletName = walletName;
  }

  void setWalletId(String walletId) {
    this._walletId = walletId;
  }

  void setLocale(String locale) {
    this._locale = locale;
  }
}
