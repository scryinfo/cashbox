import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class CreateWalletProcessProvide with ChangeNotifier {
  String _walletName;
  Uint8List _pwd;
  Uint8List _mnemonic;

  get walletName => _walletName;

  get pwd => _pwd;

  get mnemonic => _mnemonic;

  /*检查每次调用完毕，清理数据记录*/
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
