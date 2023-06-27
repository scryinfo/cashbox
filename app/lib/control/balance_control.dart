import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

class BalanceControl {
  var _tokenAddressList = [];

  factory BalanceControl() => getInstance();

  static BalanceControl _instance;

  BalanceControl._internal() {
    var curWalletObj = Wallets.mainIsolate().currentWalletChain();
    if (!curWalletObj.isSuccess()) {
      return;
    }
    var tokenAddressObj = Wallets.mainIsolate().getTokenAddress(curWalletObj.data1.walletId);
    if (tokenAddressObj.isSuccess()) {
      _tokenAddressList = tokenAddressObj.data1;
    }
  }

  static BalanceControl getInstance() {
    if (_instance == null) {
      _instance = new BalanceControl._internal();
    }
    return _instance;
  }

  // when change curWallet ,then need to reload balance info
  static BalanceControl reloadInstance() {
    _instance = new BalanceControl._internal();
    return _instance;
  }

  String getBalanceByTokenId(String tokenId) {
    if (_tokenAddressList == null || _tokenAddressList.length == 0) {
      return "";
    }
    try {
      TokenAddress tokenAddress = _tokenAddressList.firstWhere((element) {
        return tokenId.toLowerCase() == element.tokenId.toLowerCase();
      });
      return tokenAddress.balance ?? "0.0";
    } catch (e) {
      return "0.0";
    }
  }
}
