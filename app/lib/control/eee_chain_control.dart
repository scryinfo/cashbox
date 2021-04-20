import 'package:app/model/token.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:logger/logger.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
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

  List<TokenM> getTokenListWithBalance(List<TokenM> tokenList) {
    tokenList.forEach((element) {
      // todo getTokenBalance(tokenName)
      // element.balance = BalanceControl.getInstance().getBalanceByTokenId(); // todo lack element.ethChainTokenShared.tokenShared
    });
    return tokenList;
  }

  List<TokenM> getTokenListWithMoney(List<TokenM> tokenList) {
    tokenList.forEach((element) {
      // todo getTokenRate()
      element.money = TokenRate.instance.getPrice(element).toStringAsFixed(6);
    });
    return tokenList;
  }

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
        ..isVisible = element.show_1.isTrue()
        ..address = nowWallet.eeeChain.chainShared.walletAddress.address
        ..tokenId = element.chainTokenSharedId
        ..decimal = element.eeeChainTokenShared.decimal ?? 0;

      _allTokenList.add(newToken);
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

  AccountInfo decodeAdditionData(DecodeAccountInfoParameters decodeAccountInfoParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.decodeAccountInfo(decodeAccountInfoParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String txSign(RawTxParam rawTx) {
    var dataObj = Wallets.mainIsolate().chainEee.txSign(rawTx);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String eeeTransfer(EeeTransferPayload txPayload) {
    var dataObj = Wallets.mainIsolate().chainEee.eeeTransfer(txPayload);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String tokenXTransfer(EeeTransferPayload txPayload) {
    var dataObj = Wallets.mainIsolate().chainEee.tokenXTransfer(txPayload);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  AccountInfo decodeAccountInfo(DecodeAccountInfoParameters decodeAccountInfoParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.decodeAccountInfo(decodeAccountInfoParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  SubChainBasicInfo getDefaultBasicInfo() {
    var dataObj = Wallets.mainIsolate().chainEee.getDefaultBasicInfo();
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  ChainVersion getChainVersion() {
    SubChainBasicInfo subChainBasicInfo = getDefaultBasicInfo();
    if (subChainBasicInfo == null) {
      return null;
    }
    ChainVersion chainVersion = ChainVersion();
    chainVersion
      ..txVersion = subChainBasicInfo.txVersion
      ..runtimeVersion = subChainBasicInfo.runtimeVersion
      ..genesisHash = subChainBasicInfo.genesisHash;
    return chainVersion;
  }

  SubChainBasicInfo getBasicInfo(ChainVersion chainVersion) {
    var dataObj = Wallets.mainIsolate().chainEee.getBasicInfo(chainVersion);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String getStorageKey(StorageKeyParameters storageKeyParameters) {
    var dataObj = Wallets.mainIsolate().chainEee.getStorageKey(storageKeyParameters);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  List<EeeChainTx> getTxRecord(String account, int startItem, int pageSize) {
    var dataObj = Wallets.mainIsolate().chainEee.getTxRecord(account, startItem, pageSize);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  AccountInfoSyncProg getSyncRecord(String account) {
    var dataObj = Wallets.mainIsolate().chainEee.getSyncRecord(account);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool saveExtrinsicDetail(ExtrinsicContext extrinsicContext) {
    var dataObj = Wallets.mainIsolate().chainEee.saveExtrinsicDetail(extrinsicContext);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  String txSubmittableSign(RawTxParam rawTxParam) {
    var dataObj = Wallets.mainIsolate().chainEee.txSubmittableSign(rawTxParam);
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

  bool updateDefaultTokenList(ArrayCEeeChainTokenDefault arrayCEeeChainTokenDefault) {
    var dataObj = Wallets.mainIsolate().chainEee.updateDefaultTokenList(arrayCEeeChainTokenDefault);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateSyncRecord(AccountInfoSyncProg accountInfoSyncProg) {
    var dataObj = Wallets.mainIsolate().chainEee.updateSyncRecord(accountInfoSyncProg);

    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  Future<String> loadEeeStorageKey(String module, String storageItem, String accountStr, {bool isEeeChain = true}) async {
    if (storageItem == null) {
      Logger.getInstance().e("loadEeeStorageKey", "storageItem is null");
      return null;
    }
    StorageKeyParameters storageKeyParameters = StorageKeyParameters();
    ChainVersion chainVersion = ChainVersion();
    SubChainBasicInfo defaultBasicInfo;
    if (isEeeChain) {
      defaultBasicInfo = EeeChainControl.getInstance().getDefaultBasicInfo();
      chainVersion
        ..genesisHash = defaultBasicInfo.genesisHash
        ..txVersion = defaultBasicInfo.txVersion
        ..runtimeVersion = defaultBasicInfo.runtimeVersion;
    } else {
      // todo
      defaultBasicInfo = EeeChainControl.getInstance().getBasicInfo(chainVersion);
    }
    storageKeyParameters
      ..module = module
      ..storageItem = storageItem
      ..account = accountStr
      ..chainVersion = chainVersion;

    String storageKey = EeeChainControl.getInstance().getStorageKey(storageKeyParameters);
    return storageKey;
  }

  Future<String> loadEeeBalance(String module, String storageItem, String pubKey) async {
    AccountInfo eeeResultMap = await loadEeeStorageMap(module, storageItem, pubKey);
    if (eeeResultMap != null) {
      return eeeResultMap.freeBalance;
    }
    return "0";
  }

  Future<Map> loadTokenXbalance(String tokenx, String balances, String accountStr) async {
    String eeeStorageKey = await loadEeeStorageKey(tokenx, balances, accountStr);
    if (eeeStorageKey == null || eeeStorageKey.trim() == "") {
      return null;
    }
    Map netFormatMap = await ScryXNetUtil().loadScryXStorage(eeeStorageKey);
    if (netFormatMap == null || !netFormatMap.containsKey("result") || netFormatMap["result"] == null) {
      return null;
    }
    return netFormatMap;
  }

  Future<AccountInfo> loadEeeStorageMap(String module, String storageItem, String accountStr) async {
    String storageKey = await loadEeeStorageKey(module, storageItem, accountStr);
    if (storageKey == null || storageKey.trim() == "") {
      return null;
    }

    Map netFormatMap = await ScryXNetUtil().loadScryXStorage(storageKey);
    if (netFormatMap == null || !netFormatMap.containsKey("result") || netFormatMap["result"] == null) {
      return null;
    }
    DecodeAccountInfoParameters decodeAccountInfoParameters = DecodeAccountInfoParameters();
    decodeAccountInfoParameters
      ..encodeData = netFormatMap["result"]
      ..chainVersion = EeeChainControl.getInstance().getChainVersion();
    return EeeChainControl.getInstance().decodeAccountInfo(decodeAccountInfoParameters);
  }

  Future<int> loadEeeChainNonce(String module, String storageItem, String pubKey) async {
    AccountInfo eeeResultMap = await loadEeeStorageMap(module, storageItem, pubKey);
    if (eeeResultMap != null) {
      return eeeResultMap.nonce;
    }
    return 0;
  }

  bool updateBasicInfo(SubChainBasicInfo subChainBasicInfo) {
    var dataObj = Wallets.mainIsolate().chainEee.updateBasicInfo(subChainBasicInfo);
    if (!dataObj.isSuccess()) {
      Logger.getInstance().e("updateBasicInfo", dataObj.err.message.toString());
      return false;
    }
    return dataObj.data1;
  }

  Future<bool> updateSubChainBasicInfo(String infoId) async {
    Map runtimeMap = await ScryXNetUtil().loadScryXRuntimeVersion();
    if (runtimeMap == null || !runtimeMap.containsKey("result")) {
      return false;
    }
    var runtimeResultMap = runtimeMap["result"];
    if (runtimeResultMap == null || !runtimeResultMap.containsKey("specVersion") || !runtimeResultMap.containsKey("transactionVersion")) {
      return false;
    }
    int runtimeVersion = runtimeResultMap["specVersion"];
    int txVersion = runtimeResultMap["transactionVersion"];

    Map blockHashMap = await ScryXNetUtil().loadScryXBlockHash();
    if (blockHashMap == null || !blockHashMap.containsKey("result")) {
      return false;
    }
    String genesisHash = blockHashMap["result"];

    Map metaDataMap = await ScryXNetUtil().loadMetadata();
    if (metaDataMap == null || !metaDataMap.containsKey("result")) {
      return false;
    }
    String metadata = metaDataMap["result"];

    Map systemPropertiesMap = await ScryXNetUtil().loadSystemProperties();
    if (systemPropertiesMap == null || !systemPropertiesMap.containsKey("result")) {
      return false;
    }
    Map propertiesResultMap = systemPropertiesMap["result"];
    int ss58Format = propertiesResultMap["ss58Format"];
    int tokenDecimals = propertiesResultMap["tokenDecimals"];
    String tokenSymbol = propertiesResultMap["tokenSymbol"];
    if (runtimeVersion != null &&
        txVersion != null &&
        genesisHash != null &&
        metadata != null &&
        ss58Format != null &&
        tokenDecimals != null &&
        tokenSymbol != null) {
      SubChainBasicInfo subChainBasicInfo = SubChainBasicInfo();
      subChainBasicInfo
        ..runtimeVersion = runtimeVersion
        ..isDefault = CTrue.toInt()
        ..txVersion = txVersion
        ..genesisHash = genesisHash
        ..metadata = metadata
        ..ss58FormatPrefix = ss58Format
        ..tokenDecimals = tokenDecimals
        ..tokenSymbol = tokenSymbol;
      bool isUpdateOk = EeeChainControl.getInstance().updateBasicInfo(subChainBasicInfo);
      if (!isUpdateOk) {
        Logger().e("updateSubChainBasicInfo isUpdateOk is ---> ", isUpdateOk.toString());
      }
      return isUpdateOk;
    }
    return false;
  }
}
