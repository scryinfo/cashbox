import 'package:flutter/foundation.dart';

class WalletManagerProvide with ChangeNotifier {
  String _walletName;
  String _walletId;

  get walletName => _walletName;

  get walletId => _walletId;

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
}
