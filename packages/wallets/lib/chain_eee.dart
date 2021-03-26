import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'dart:ffi';

import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEee {
  DlResult1<String> txSign(NetType netType, RawTxParam rawTx) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrRawTx = rawTx.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_txSign(
          _ptrContext, ptrNetType, ptrRawTx, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      RawTxParam.free(ptrRawTx);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> eeeTransfer(NetType netType, EeeTransferPayload txPayload) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_eeeTransfer(
          _ptrContext, ptrNetType, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  DlResult1<String> tokenXTransfer(
      NetType netType, EeeTransferPayload txPayload) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_tokenXTransfer(
          _ptrContext, ptrNetType, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  DlResult1<AccountInfo> decodeAccountInfo(NetType netType,
      DecodeAccountInfoParameters decodeAccountInfoParameters) {
    Error err;
    AccountInfo accountInfo;
    {
      var ptrAccountInfo = Wallets.cWallets.CAccountInfo_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrDecodeAccountInfoParameter = decodeAccountInfoParameters.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_decodeAccountInfo(_ptrContext, ptrNetType,
          ptrDecodeAccountInfoParameter, ptrAccountInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      DecodeAccountInfoParameters.free(ptrDecodeAccountInfoParameter);

      if (err.isSuccess()) {
        accountInfo = AccountInfo.fromC(ptrAccountInfo.value);
      } else {
        accountInfo = new AccountInfo();
      }
      Wallets.cWallets.CAccountInfo_dFree(ptrAccountInfo);
    }
    return DlResult1(accountInfo, err);
  }

  DlResult1<SubChainBasicInfo> getBasicInfo(
      NetType netType, ChainVersion chainVersion) {
    Error err;
    SubChainBasicInfo subChainBasicInfo;
    {
      var ptrSubChainBasicInfo = Wallets.cWallets.CSubChainBasicInfo_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrChainVersion = chainVersion.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_getBasicInfo(
          _ptrContext, ptrNetType, ptrChainVersion, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      ChainVersion.free(ptrChainVersion);

      if (err.isSuccess()) {
        subChainBasicInfo = SubChainBasicInfo.fromC(ptrSubChainBasicInfo.value);
      } else {
        subChainBasicInfo = new SubChainBasicInfo();
      }
      Wallets.cWallets.CSubChainBasicInfo_dFree(ptrSubChainBasicInfo);
    }
    return DlResult1(subChainBasicInfo, err);
  }

  DlResult1<String> getStorageKey(
      NetType netType, StorageKeyParameters storageKeyParameters) {
    Error err;
    String storageKeyResult = "";
    {
      var ptrStorageKey = Wallets.cWallets.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrStorageKeyParameter = storageKeyParameters.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_getStorageKey(
          _ptrContext, ptrNetType, ptrStorageKeyParameter, ptrStorageKey);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      StorageKeyParameters.free(ptrStorageKeyParameter);

      if (err.isSuccess()) {
        storageKeyResult = ptrStorageKey.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrStorageKey);
    }
    return DlResult1(storageKeyResult, err);
  }

  DlResult1<AccountInfoSyncProg> getSyncRecord(
      NetType netType, String account) {
    Error err;
    AccountInfoSyncProg accountInfoSyncProg;
    {
      var ptrAccountInfoSyncProg = Wallets.cWallets.CAccountInfoSyncProg_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrAccount = account.toCPtrInt8();
      var cerr = Wallets.cWallets.ChainEee_getSyncRecord(
          _ptrContext, ptrNetType, ptrAccount, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      ptrAccount.free();

      if (err.isSuccess()) {
        accountInfoSyncProg =
            AccountInfoSyncProg.fromC(ptrAccountInfoSyncProg.value);
      } else {
        accountInfoSyncProg = new AccountInfoSyncProg();
      }
      Wallets.cWallets.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(accountInfoSyncProg, err);
  }

  DlResult1<List<EeeChainTx>> getTxRecord(
      NetType netType, String account, int startItem, int pageSize) {
    Error err;
    List<EeeChainTx> ect = [];
    {
      var ptrAccountInfoSyncProg = Wallets.cWallets.CAccountInfoSyncProg_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrAccount = account.toCPtrInt8();
      var ptrCArrayCEeeChainTx = Wallets.cWallets.CArrayCEeeChainTx_dAlloc();
      var cerr = Wallets.cWallets.ChainEee_queryChainTxRecord(_ptrContext, ptrNetType,
          ptrAccount, startItem, pageSize, ptrCArrayCEeeChainTx);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEeeChainTx.fromC(ptrCArrayCEeeChainTx.value).data;
      }
      ptrNetType.free();
      ptrAccount.free();
      Wallets.cWallets.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(ect, err);
  }

  DlResult1<bool> saveExtrinsicDetail(
      NetType netType, ExtrinsicContext extrinsicContext) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrExtrinsicContext = extrinsicContext.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_saveExtrinsicDetail(
          _ptrContext, ptrNetType, ptrExtrinsicContext);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      ExtrinsicContext.free(ptrExtrinsicContext);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<String> txSubmittableSign(NetType netType, RawTxParam rawTxParam) {
    Error err;
    String signedResult = "";
    {
      var ptrSignedResult = Wallets.cWallets.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrRawTxParam = rawTxParam.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_txSubmittableSign(
          _ptrContext, ptrNetType, ptrRawTxParam, ptrSignedResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      RawTxParam.free(ptrRawTxParam);

      if (err.isSuccess()) {
        signedResult = ptrSignedResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignedResult);
    }
    return DlResult1(signedResult, err);
  }

  DlResult1<bool> updateAuthDigitList(
      ArrayCEeeChainTokenAuth arrayCEeeChainTokenAuth) {
    Error err;
    {
      var ptrArrayCEeeChainTokenAuth = arrayCEeeChainTokenAuth.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateAuthDigitList(
          _ptrContext, ptrArrayCEeeChainTokenAuth);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEeeChainTokenAuth.free(ptrArrayCEeeChainTokenAuth);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateBasicInfo(
      NetType netType, SubChainBasicInfo subChainBasicInfo) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrSubChainBasicInfo = subChainBasicInfo.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateBasicInfo(
          _ptrContext, ptrNetType, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      SubChainBasicInfo.free(ptrSubChainBasicInfo);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateDefaultTokenList(
      ArrayCEeeChainTokenDefault arrayCEeeChainTokenDefault) {
    Error err;
    {
      var ptrArrayCEeeChainTokenDefault = arrayCEeeChainTokenDefault.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateDefaultTokenList(
          _ptrContext, ptrArrayCEeeChainTokenDefault);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEeeChainTokenDefault.free(ptrArrayCEeeChainTokenDefault);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateSyncRecord(
      NetType netType, AccountInfoSyncProg accountInfoSyncProg) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var ptrAccountInfoSyncProg = accountInfoSyncProg.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateSyncRecord(
          _ptrContext, ptrNetType, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrNetType.free();
      AccountInfoSyncProg.free(ptrAccountInfoSyncProg);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  Wallets _wallets;

  ChainEee(this._wallets);

  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;
}
