import 'package:flutter/foundation.dart';

class CreateWalletProcessProvide with ChangeNotifier {
  String _walletName;
  Uint8List _pwd;
  Uint8List _mnemonic;

  get walletName => _walletName;

  get pwd => _pwd;

  get mnemonic => _mnemonic;

  /*Check the completion of each call, clean up the data record*/
  void emptyData() {
    this._walletName = null;
    this._pwd = null;
    this._mnemonic = null;
  }

  void setWalletName(String walletName) {
    this._walletName = walletName;
  }

  void setPwd(Uint8List pwd) {
    this._pwd = pwd;
  }

  void setMnemonic(Uint8List mnemonic) {
    this._mnemonic = mnemonic;
  }
}
