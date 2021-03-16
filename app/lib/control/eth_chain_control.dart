import 'package:app/control/balance_control.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/model/token.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

class EthChainControl {
  factory EthChainControl() => getInstance();

  static EthChainControl _instance;

  EthChainControl._internal();

  static EthChainControl getInstance() {
    if (_instance == null) {
      _instance = new EthChainControl._internal();
    }
    return _instance;
  }

  List<TokenM> _allTokenList = [];

  List<TokenM> getAllTokenList(Wallet nowWallet) {
    if (nowWallet == null) {
      return [];
    }
    List<EthChainToken> ethTokens = nowWallet.ethChain.tokens.data;
    TokenM newToken = TokenM();
    _allTokenList = [];
    // convert from ffiModel to uniform format
    ethTokens.forEach((element) {
      newToken = TokenM()
        ..fullName = element.ethChainTokenShared.tokenShared.name ?? ""
        ..shortName = element.ethChainTokenShared.tokenShared.symbol ?? ""
        ..urlImg = element.ethChainTokenShared.tokenShared.logoUrl ?? ""
        ..contractAddress = element.contractAddress ?? ""
        ..isVisible = element.show.isTrue()
        // ..tokenId = element.ethChainTokenShared.tokenShared.id
        ..decimal = element.ethChainTokenShared.decimal ?? 0;

      _allTokenList.add(newToken);
    });

    _allTokenList.forEach((element) {
      // todo getTokenBalance(tokenName)
      // element.balance = BalanceControl.getInstance().getBalanceByTokenId(); // todo lack element.ethChainTokenShared.tokenShared
      // todo .tokenId?
      // todo getTokenRate()
      element.money = TokenRate.instance.getPrice(element).toStringAsFixed(6);
    });

    return _allTokenList;
  }

  List<TokenM> getVisibleTokenList(Wallet nowWallet) {
    var visibleList = getAllTokenList(nowWallet);
    visibleList.retainWhere((element) {
      return element.isVisible;
    });
    return visibleList;
  }

  String decodeAdditionData(String encodeData) {
    var dataObj = Wallets.mainIsolate().chainEth.decodeAdditionData(encodeData);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  txSign(NetType netType, EthTransferPayload txPayload, NoCacheString password) {
    var dataObj = Wallets.mainIsolate().chainEth.txSign(netType, txPayload, password);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  rawTxSign(NetType netType, EthRawTxPayload rawTxPayload, NoCacheString password) {
    var dataObj = Wallets.mainIsolate().chainEth.rawTxSign(netType, rawTxPayload, password);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateAuthTokenList(ArrayCEthChainTokenAuth authTokens) {
    var dataObj = Wallets.mainIsolate().chainEth.updateAuthTokenList(authTokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }

  List<EthChainTokenAuth> getChainEthAuthTokenList(NetType netType, int startIndex, int endIndex) {
    var dataObj = Wallets.mainIsolate().chainEth.getChainEthAuthTokenList(netType, startIndex, endIndex);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  updateDefaultTokenList(ArrayCEthChainTokenDefault defaultTokens) {
    var dataObj = Wallets.mainIsolate().chainEth.updateDefaultTokenList(defaultTokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }

  addNonAuthDigit(ArrayCEthChainTokenAuth tokens) {
    var dataObj = Wallets.mainIsolate().chainEth.addNonAuthDigit(tokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }
}
