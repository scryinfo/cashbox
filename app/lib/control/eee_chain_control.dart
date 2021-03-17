import 'package:app/model/token.dart';
import 'package:app/model/token_rate.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';

class EeeChainControl {
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
    List<EeeChainToken> eeeTokens = nowWallet.eeeChain.tokens.data;
    TokenM newToken = TokenM();
    _allTokenList = [];
    // convert from ffiModel to uniform format
    eeeTokens.forEach((element) {
      newToken = TokenM()
        ..fullName = element.eeeChainTokenShared.tokenShared.name ?? ""
        ..shortName = element.eeeChainTokenShared.tokenShared.symbol ?? ""
        ..urlImg = element.eeeChainTokenShared.tokenShared.logoUrl ?? ""
        // ..contractAddress = element.contractAddress ?? ""
        ..isVisible = element.show.isTrue()
        // ..tokenId = element.ethChainTokenShared.tokenShared.id
        ..decimal = element.eeeChainTokenShared.decimal ?? 0;
      if (element.eeeChainTokenShared.tokenShared.name.toLowerCase() == "eee") {
        newToken.address = nowWallet.eeeChain.chainShared.walletAddress.address;
      }
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

  AccountInfo decodeAdditionData(NetType netType, DecodeAccountInfoParameters decodeAccountInfoParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.decodeAccountInfo(netType, decodeAccountInfoParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String txSign(NetType netType, RawTxParam rawTx) {
    var dataObj = Wallets.mainIsolate().chainEee.txSign(netType, rawTx);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String eeeTransfer(NetType netType, EeeTransferPayload txPayload) {
    var dataObj = Wallets.mainIsolate().chainEee.eeeTransfer(netType, txPayload);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String tokenXTransfer(NetType netType, EeeTransferPayload txPayload) {
    var dataObj = Wallets.mainIsolate().chainEee.tokenXTransfer(netType, txPayload);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  AccountInfo decodeAccountInfo(NetType netType, DecodeAccountInfoParameters decodeAccountInfoParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.decodeAccountInfo(netType, decodeAccountInfoParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  SubChainBasicInfo getBasicInfo(NetType netType, ChainVersion chainVersion) {
    var dataObj = Wallets.mainIsolate().chainEee.getBasicInfo(netType, chainVersion);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String getStorageKey(NetType netType, StorageKeyParameters storageKeyParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.getStorageKey(netType, storageKeyParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  AccountInfoSyncProg getSyncRecord(NetType netType, String account) {
    var dataObj = Wallets.mainIsolate().chainEee.getSyncRecord(netType, account);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool saveExtrinsicDetail(NetType netType, ExtrinsicContext extrinsicContext) {
    var dataObj = Wallets.mainIsolate().chainEee.saveExtrinsicDetail(netType, extrinsicContext);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String txSubmittableSign(NetType netType, RawTxParam rawTxParam) {
    var dataObj = Wallets.mainIsolate().chainEee.txSubmittableSign(netType, rawTxParam);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateAuthDigitList(ArrayCEeeChainTokenAuth arrayCEeeChainTokenAuth) {
    var dataObj = Wallets.mainIsolate().chainEee.updateAuthDigitList(arrayCEeeChainTokenAuth);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateBasicInfo(NetType netType, SubChainBasicInfo subChainBasicInfo) {
    var dataObj = Wallets.mainIsolate().chainEee.updateBasicInfo(netType, subChainBasicInfo);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateDefaultTokenList(ArrayCEeeChainTokenDefault arrayCEeeChainTokenDefault) {
    var dataObj = Wallets.mainIsolate().chainEee.updateDefaultTokenList(arrayCEeeChainTokenDefault);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateSyncRecord(NetType netType, AccountInfoSyncProg accountInfoSyncProg) {
    var dataObj = Wallets.mainIsolate().chainEee.updateSyncRecord(netType, accountInfoSyncProg);

    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }
}
