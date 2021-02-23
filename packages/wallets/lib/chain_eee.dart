import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEee {
  DlResult1<String> txSign(NetType netType, RawTxParam rawTx) {
    Error err;
    String signResult;
    {
      var ptrSignResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrRawTx = rawTx.toCPtr();
      var cerr = clib.ChainEee_txSign(_ptrContext, ptrNetType, ptrRawTx, ptrSignResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      RawTxParam.free(ptrRawTx);

      if (err.isSuccess()) {
        signResult = fromUtf8Null(ptrSignResult.value);
      }
      clib.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> eeeTransfer(NetType netType, EeeTransferPayload txPayload) {
    Error err;
    String signResult;
    {
      var ptrSignResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = clib.ChainEee_eeeTransfer(_ptrContext, ptrNetType, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = fromUtf8Null(ptrSignResult.value);
      }
      clib.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  DlResult1<String> tokenXTransfer(NetType netType, EeeTransferPayload txPayload) {
    Error err;
    String signResult;
    {
      var ptrSignResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = clib.ChainEee_tokenXTransfer(_ptrContext, ptrNetType, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = fromUtf8Null(ptrSignResult.value);
      }
      clib.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  DlResult1<AccountInfo> decodeAccountInfo(NetType netType, DecodeAccountInfoParameters decodeAccountInfoParameters) {
    Error err;
    AccountInfo accountInfo;
    {
      var ptrAccountInfo = clib.CAccountInfo_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrDecodeAccountInfoParameter = decodeAccountInfoParameters.toCPtr();
      var cerr = clib.ChainEee_decodeAccountInfo(_ptrContext, ptrNetType, ptrDecodeAccountInfoParameter, ptrAccountInfo);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      DecodeAccountInfoParameters.free(ptrDecodeAccountInfoParameter);

      if (err.isSuccess()) {
        accountInfo = AccountInfo.fromC(ptrAccountInfo.value);
      }
      clib.CAccountInfo_dFree(ptrAccountInfo);
    }
    return DlResult1(accountInfo, err);
  }

  DlResult1<SubChainBasicInfo> getBasicInfo(NetType netType, ChainVersion chainVersion) {
    Error err;
    SubChainBasicInfo subChainBasicInfo;
    {
      var ptrSubChainBasicInfo = clib.CSubChainBasicInfo_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrChainVersion = chainVersion.toCPtr();
      var cerr = clib.ChainEee_getBasicInfo(_ptrContext, ptrNetType, ptrChainVersion, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      ChainVersion.free(ptrChainVersion);

      if (err.isSuccess()) {
        subChainBasicInfo = SubChainBasicInfo.fromC(ptrSubChainBasicInfo.value);
      }
      clib.CSubChainBasicInfo_dFree(ptrSubChainBasicInfo);
    }
    return DlResult1(subChainBasicInfo, err);
  }

  DlResult1<String> getStorageKey(NetType netType, StorageKeyParameters storageKeyParameters) {
    Error err;
    String storageKeyResult;
    {
      var ptrStorageKey = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrStorageKeyParameter = storageKeyParameters.toCPtr();
      var cerr = clib.ChainEee_getStorageKey(_ptrContext, ptrNetType, ptrStorageKeyParameter, ptrStorageKey);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      StorageKeyParameters.free(ptrStorageKeyParameter);

      if (err.isSuccess()) {
        storageKeyResult = fromUtf8Null(ptrStorageKey.value);
      }
      clib.CStr_dFree(ptrStorageKey);
    }
    return DlResult1(storageKeyResult, err);
  }

  DlResult1<AccountInfoSyncProg> getSyncRecord(NetType netType, String account) {
    Error err;
    AccountInfoSyncProg accountInfoSyncProg;
    {
      var ptrAccountInfoSyncProg = clib.CAccountInfoSyncProg_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrAccount = account.toCPtr();
      var cerr = clib.ChainEee_getSyncRecord(_ptrContext, ptrNetType, ptrAccount, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      ptrAccount.free();

      if (err.isSuccess()) {
        accountInfoSyncProg = AccountInfoSyncProg.fromC(ptrAccountInfoSyncProg.value);
      }
      clib.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(accountInfoSyncProg, err);
  }

  DlResult1<bool> saveExtrinsicDetail(NetType netType, ExtrinsicContext extrinsicContext) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrExtrinsicContext = extrinsicContext.toCPtr();
      var cerr = clib.ChainEee_saveExtrinsicDetail(_ptrContext, ptrNetType, ptrExtrinsicContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
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
    String signedResult;
    {
      var ptrSignedResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrRawTxParam = rawTxParam.toCPtr();
      var cerr = clib.ChainEee_txSubmittableSign(_ptrContext, ptrNetType, ptrRawTxParam, ptrSignedResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      RawTxParam.free(ptrRawTxParam);

      if (err.isSuccess()) {
        signedResult = fromUtf8Null(ptrSignedResult.value);
      }
      clib.CStr_dFree(ptrSignedResult);
    }
    return DlResult1(signedResult, err);
  }

  DlResult1<bool> updateAuthDigitList(ArrayCEeeChainTokenAuth arrayCEeeChainTokenAuth) {
    Error err;
    {
      var ptrArrayCEeeChainTokenAuth = arrayCEeeChainTokenAuth.toCPtr();
      var cerr = clib.ChainEee_updateAuthDigitList(_ptrContext, ptrArrayCEeeChainTokenAuth);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ArrayCEeeChainTokenAuth.free(ptrArrayCEeeChainTokenAuth);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateBasicInfo(NetType netType, SubChainBasicInfo subChainBasicInfo) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrSubChainBasicInfo = subChainBasicInfo.toCPtr();
      var cerr = clib.ChainEee_updateBasicInfo(_ptrContext, ptrNetType, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      SubChainBasicInfo.free(ptrSubChainBasicInfo);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateDefaultTokenList(ArrayCEeeChainTokenDefault arrayCEeeChainTokenDefault) {
    Error err;
    {
      var ptrArrayCEeeChainTokenDefault = arrayCEeeChainTokenDefault.toCPtr();
      var cerr = clib.ChainEee_updateDefaultTokenList(_ptrContext, ptrArrayCEeeChainTokenDefault);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ArrayCEeeChainTokenDefault.free(ptrArrayCEeeChainTokenDefault);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateSyncRecord(NetType netType, AccountInfoSyncProg accountInfoSyncProg) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrAccountInfoSyncProg = accountInfoSyncProg.toCPtr();
      var cerr = clib.ChainEee_updateSyncRecord(_ptrContext, ptrNetType, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
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
