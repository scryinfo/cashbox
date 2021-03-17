import 'package:app/model/token.dart';
import 'package:app/model/token_rate.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';

class EeeChainControl{
  factory EeeChainControl() => getInstance();

  static EeeChainControl _instance;

  EeeChainControl._internal();

  static EeeChainControl getInstance() {
    if (_instance == null) {
      _instance = new EeeChainControl._internal();
    }
    return _instance;
  }

  List<TokenM> _allTokenList = [];

  List<TokenM> getAllTokenList(Wallet nowWallet) {
    if (nowWallet == null) {
      return [];
    }
    List<EeeChainToken> ethTokens = nowWallet.eeeChain.tokens.data;
    TokenM newToken = TokenM();
    _allTokenList = [];
    // convert from ffiModel to uniform format
    ethTokens.forEach((element) {
      newToken = TokenM()
        ..fullName = element.eeeChainTokenShared.tokenShared.name ?? ""
        ..shortName = element.eeeChainTokenShared.tokenShared.symbol ?? ""
        ..urlImg = element.eeeChainTokenShared.tokenShared.logoUrl ?? ""
        // ..contractAddress = element.contractAddress ?? ""
        ..isVisible = element.show.isTrue()
        // ..tokenId = element.ethChainTokenShared.tokenShared.id
        ..decimal = element.eeeChainTokenShared.decimal ?? 0;

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


}