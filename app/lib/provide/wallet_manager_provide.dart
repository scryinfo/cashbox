import 'package:flutter/foundation.dart';

class WalletManagerProvide with ChangeNotifier {
  String _walletName;
  String _walletId;
  String _locale = ''; //Application language selection

  get walletName => _walletName;

  get walletId => _walletId;

  get locale => _locale;

  /*Check the completion of each call, clean up the data record*/
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
