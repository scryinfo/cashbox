import 'dart:ffi';

import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEth {
  DlResult1<String> decodeAdditionData(String encodeData) {
    Error err;
    String additionData = "";
    {
      var ptrAdditionData = Wallets.cWallets.CStr_dAlloc();
      var ptrEncodeData = encodeData.toCPtrInt8();
      var cerr = Wallets.cWallets.ChainEth_decodeAdditionData(_ptrContext, ptrEncodeData, ptrAdditionData);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ptrEncodeData.free();
      if (err.isSuccess()) {
        additionData = ptrAdditionData.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrAdditionData);
    }

    return DlResult1(additionData, err);
  }

  DlResult1<String> txSign(EthTransferPayload txPayload, NoCacheString password) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrTxPayload = txPayload.toCPtr();
      var ptrPwd = password.toCPtrInt8();
      var cerr = Wallets.cWallets.ChainEth_txSign(_ptrContext, ptrTxPayload, ptrPwd, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);

      EthTransferPayload.free(ptrTxPayload);
      NoCacheString.freeInt8(ptrPwd);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> wcTxSign(EthWalletConnectTx wcTxPayload, NoCacheString password) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrTxPayload = wcTxPayload.toCPtr();
      var ptrPwd = password.toCPtrInt8();
      var cerr = Wallets.cWallets.ChainEth_walletConnectTxSign(_ptrContext, ptrTxPayload, ptrPwd, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);

      EthWalletConnectTx.free(ptrTxPayload);
      NoCacheString.freeInt8(ptrPwd);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> rawTxSign(EthRawTxPayload rawTxPayload, NoCacheString password) {
    Error err;
    String signResult = "";
    {
      var ptrSignResult = Wallets.cWallets.CStr_dAlloc();
      var ptrRawTxPayload = rawTxPayload.toCPtr();
      var ptrPwd = password.toCPtrInt8();
      var cerr = Wallets.cWallets.ChainEth_rawTxSign(_ptrContext, ptrRawTxPayload, ptrPwd, ptrSignResult);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      EthRawTxPayload.free(ptrRawTxPayload);
      NoCacheString.freeInt8(ptrPwd);

      if (err.isSuccess()) {
        signResult = ptrSignResult.value.toDartString();
      }
      Wallets.cWallets.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  Error updateAuthTokenList(ArrayCEthChainTokenAuth authTokens) {
    Error err;
    {
      var ptrAuthTokens = authTokens.toCPtr();
      var cerr = Wallets.cWallets.ChainEth_updateAuthTokenList(_ptrContext, ptrAuthTokens);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEthChainTokenAuth.free(ptrAuthTokens);
    }

    return err;
  }

  DlResult1<List<EthChainTokenAuth>> getChainEthAuthTokenList(int startItem, int pageSize) {
    Error err;
    List<EthChainTokenAuth> ect = [];
    {
      var arrayToken = Wallets.cWallets.CArrayCEthChainTokenAuth_dAlloc();
      var cerr = Wallets.cWallets.ChainEth_getAuthTokenList(_ptrContext, startItem, pageSize, arrayToken);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEthChainTokenAuth.fromC(arrayToken.value).data;
      }
      Wallets.cWallets.CArrayCEthChainTokenAuth_dFree(arrayToken);
    }

    return DlResult1(ect, err);
  }

  Error updateDefaultTokenList(ArrayCEthChainTokenDefault defaultTokens) {
    Error err;
    {
      var ptrDefaultTokens = defaultTokens.toCPtr();
      var cerr = Wallets.cWallets.ChainEth_updateDefaultTokenList(_ptrContext, ptrDefaultTokens);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCEthChainTokenDefault.free(ptrDefaultTokens);
    }

    return err;
  }

  Error queryAuthTokenList(ArrayCEthChainTokenDefault defaultTokens) {
    Error err;
    // {
    //   var ptrDefaultTokens = defaultTokens.toCPtr();
    //   var cerr = Wallets.cWallets.ChainEth_queryAuthTokenList(_ptrContext, ptrDefaultTokens);
    //   err = Error.fromC(cerr);
    //   Wallets.cWallets.CError_free(cerr);
    //   ArrayCEthChainTokenDefault.free(ptrDefaultTokens);
    // }
    // return err;
    return Error();
  }

  //
  // Error addNonAuthDigit(ArrayCEthChainTokenAuth tokens) {
  //   Error err;
  //   {
  //     var ptrTokens = tokens.toCPtr();
  //     var cerr = Wallets.cWallets.ChainEth_addNonAuthDigit(_ptrContext, ptrTokens);
  //     err = Error.fromC(cerr);
  //     Wallets.cWallets.CError_free(cerr);
  //     ArrayCEthChainTokenAuth.free(ptrTokens);
  //   }
  //
  //   return err;
  // }

  Wallets _wallets;

  ChainEth(this._wallets);

  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;
}
