import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'dart:ffi';

import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEee {
  DlResult1<String> txSign(RawTxParam rawTx) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrRawTx = rawTx.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_txSign(_ptrContext, ptrRawTx, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      RawTxParam.free(ptrRawTx);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> eeeTransfer(EeeTransferPayload txPayload) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_eeeTransfer(_ptrContext, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  DlResult1<String> tokenXTransfer(EeeTransferPayload txPayload) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrTxPayload = txPayload.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_tokenXTransfer(_ptrContext, ptrTxPayload, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      EeeTransferPayload.free(ptrTxPayload);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }
    return DlResult1(signResult, err);
  }

  Error updateAuthTokenList(ArrayCEeeChainTokenAuth authTokens) {
    Error err;
    {
      var ptrAuthTokens = authTokens.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateAuthDigitList(_ptrContext, ptrAuthTokens);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEeeChainTokenAuth.free(ptrAuthTokens);
    }

    return err;
  }

  DlResult1<List<EeeChainTokenAuth>> getChainEeeAuthTokenList(int startItem, int pageSize) {
    Error err;
    List<EeeChainTokenAuth> ect = [];
    {
      var arrayToken = Wallets.cWallets.CArrayCEeeChainTokenAuth_dAlloc();
      var cerr = Wallets.cWallets.ChainEee_getAuthTokenList(_ptrContext, startItem, pageSize, arrayToken);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEeeChainTokenAuth.fromC(arrayToken.value).data;
      }
      Wallets.cWallets.CArrayCEeeChainTokenAuth_dFree(arrayToken);
    }

    return DlResult1(ect, err);
  }

  DlResult1<AccountInfo> decodeAccountInfo(DecodeAccountInfoParameters decodeAccountInfoParameters) {
    Error err;
    AccountInfo accountInfo;
    {
      var ptrAccountInfo = Wallets.cWallets.CAccountInfo_dAlloc();
      var ptrDecodeAccountInfoParameter = decodeAccountInfoParameters.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_decodeAccountInfo(_ptrContext, ptrDecodeAccountInfoParameter, ptrAccountInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
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

  DlResult1<SubChainBasicInfo> getBasicInfo(ChainVersion chainVersion) {
    Error err;
    SubChainBasicInfo subChainBasicInfo;
    {
      var ptrSubChainBasicInfo = Wallets.cWallets.CSubChainBasicInfo_dAlloc();
      var ptrChainVersion = chainVersion.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_getBasicInfo(_ptrContext, ptrChainVersion, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
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

  DlResult1<SubChainBasicInfo> getDefaultBasicInfo() {
    Error err;
    SubChainBasicInfo subChainBasicInfo;
    {
      var ptrSubChainBasicInfo = Wallets.cWallets.CSubChainBasicInfo_dAlloc();
      var cerr = Wallets.cWallets.ChainEee_getDefaultBasicInfo(_ptrContext, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);

      if (err.isSuccess()) {
        subChainBasicInfo = SubChainBasicInfo.fromC(ptrSubChainBasicInfo.value);
      } else {
        subChainBasicInfo = new SubChainBasicInfo();
      }
      Wallets.cWallets.CSubChainBasicInfo_dFree(ptrSubChainBasicInfo);
    }
    return DlResult1(subChainBasicInfo, err);
  }

  DlResult1<String> getStorageKey(StorageKeyParameters storageKeyParameters) {
    Error err;
    String storageKeyResult = "";
    {
      var ptrStorageKey = Wallets.cWallets.CStr_dAlloc();
      var ptrStorageKeyParameter = storageKeyParameters.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_getStorageKey(_ptrContext, ptrStorageKeyParameter, ptrStorageKey);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      StorageKeyParameters.free(ptrStorageKeyParameter);

      if (err.isSuccess()) {
        storageKeyResult = ptrStorageKey.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrStorageKey);
    }
    return DlResult1(storageKeyResult, err);
  }

  DlResult1<AccountInfoSyncProg> getSyncRecord(String account) {
    Error err;
    AccountInfoSyncProg accountInfoSyncProg;
    {
      var ptrAccountInfoSyncProg = Wallets.cWallets.CAccountInfoSyncProg_dAlloc();
      var ptrAccount = account.toCPtrChar();
      var cerr = Wallets.cWallets.ChainEee_getSyncRecord(_ptrContext, ptrAccount, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrAccount.free();

      if (err.isSuccess()) {
        accountInfoSyncProg = AccountInfoSyncProg.fromC(ptrAccountInfoSyncProg.value);
      } else {
        accountInfoSyncProg = new AccountInfoSyncProg();
      }
      Wallets.cWallets.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(accountInfoSyncProg, err);
  }

  DlResult1<List<EeeChainTx>> getEeeTxRecord(String account, int startItem, int pageSize) {
    Error err;
    List<EeeChainTx> ect = [];
    {
      var ptrAccountInfoSyncProg = Wallets.cWallets.CAccountInfoSyncProg_dAlloc();
      var ptrAccount = account.toCPtrChar();
      var ptrCArrayCEeeChainTx = Wallets.cWallets.CArrayCEeeChainTx_dAlloc();
      var cerr =
          Wallets.cWallets.ChainEee_queryChainTxRecord(_ptrContext, ptrAccount, startItem, pageSize, ptrCArrayCEeeChainTx);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEeeChainTx.fromC(ptrCArrayCEeeChainTx.value).data;
      }

      ptrAccount.free();
      Wallets.cWallets.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(ect, err);
  }

  DlResult1<List<EeeChainTx>> getTokenXTxRecord(String account, int startItem, int pageSize) {
    Error err;
    List<EeeChainTx> ect = [];
    {
      var ptrAccountInfoSyncProg = Wallets.cWallets.CAccountInfoSyncProg_dAlloc();
      var ptrAccount = account.toCPtrChar();
      var ptrCArrayCEeeChainTx = Wallets.cWallets.CArrayCEeeChainTx_dAlloc();
      var cerr =
          Wallets.cWallets.ChainEee_queryTokenxTxRecord(_ptrContext, ptrAccount, startItem, pageSize, ptrCArrayCEeeChainTx);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEeeChainTx.fromC(ptrCArrayCEeeChainTx.value).data;
      }

      ptrAccount.free();
      Wallets.cWallets.CAccountInfoSyncProg_dFree(ptrAccountInfoSyncProg);
    }
    return DlResult1(ect, err);
  }

  DlResult1<bool> saveExtrinsicDetail(ExtrinsicContext extrinsicContext) {
    Error err;
    {
      var ptrExtrinsicContext = extrinsicContext.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_saveExtrinsicDetail(_ptrContext, ptrExtrinsicContext);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);

      ExtrinsicContext.free(ptrExtrinsicContext);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<String> txSubmittableSign(RawTxParam rawTxParam) {
    Error err;
    String signedResult = "";
    //{
    //  var ptrSignedResult = Wallets.cWallets.CStr_dAlloc();
    //  var ptrRawTxParam = rawTxParam.toCPtr();
    //  var cerr = Wallets.cWallets.ChainEee_txSubmittableSign(_ptrContext, ptrRawTxParam, ptrSignedResult);
    //  err = Error.fromC(cerr);
    //  Wallets.cWallets.CError_free(cerr);
//
    //  RawTxParam.free(ptrRawTxParam);
//
    //  if (err.isSuccess()) {
    //    signedResult = ptrSignedResult.value.toDartString();
    //  }
    //  Wallets.cWallets.CStr_dFree(ptrSignedResult);
    //}
    err = Error(); // todo compile remove
    return DlResult1(signedResult, err);
  }

  DlResult1<bool> updateAuthDigitList(ArrayCEeeChainTokenAuth arrayCEeeChainTokenAuth) {
    Error err;
    {
      var ptrArrayCEeeChainTokenAuth = arrayCEeeChainTokenAuth.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateAuthDigitList(_ptrContext, ptrArrayCEeeChainTokenAuth);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEeeChainTokenAuth.free(ptrArrayCEeeChainTokenAuth);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateBasicInfo(SubChainBasicInfo subChainBasicInfo) {
    Error err;
    {
      var ptrSubChainBasicInfo = subChainBasicInfo.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateBasicInfo(_ptrContext, ptrSubChainBasicInfo);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);

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
      var cerr = Wallets.cWallets.ChainEee_updateDefaultTokenList(_ptrContext, ptrArrayCEeeChainTokenDefault);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEeeChainTokenDefault.free(ptrArrayCEeeChainTokenDefault);
    }
    if (err.isSuccess()) {
      return DlResult1(true, err);
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateSyncRecord(AccountInfoSyncProg accountInfoSyncProg) {
    Error err;
    {
      var ptrAccountInfoSyncProg = accountInfoSyncProg.toCPtr();
      var cerr = Wallets.cWallets.ChainEee_updateSyncRecord(_ptrContext, ptrAccountInfoSyncProg);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
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
