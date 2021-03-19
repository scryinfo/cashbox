import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'dart:ffi';

import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEth {
  DlResult1<String> decodeAdditionData(String encodeData) {
    Error err;
    String additionData;
    {
      var ptrAdditionData = clib.CStr_dAlloc();
      var ptrEncodeData = encodeData.toCPtr();
      var cerr = clib.ChainEth_decodeAdditionData(_ptrContext, ptrEncodeData, ptrAdditionData);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrEncodeData.free();
      if (err.isSuccess()) {
        additionData = fromUtf8Null(ptrAdditionData.value);
      }
      clib.CStr_dFree(ptrAdditionData);
    }

    return DlResult1(additionData, err);
  }

  DlResult1<String> txSign(NetType netType, EthTransferPayload txPayload, NoCacheString password) {
    Error err;
    String signResult;
    {
      var ptrSignResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrTxPayload = txPayload.toCPtr();
      var ptrPwd = password.toCPtr();
      var cerr = clib.ChainEth_txSign(_ptrContext, ptrNetType, ptrTxPayload, ptrPwd, ptrSignResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      EthTransferPayload.free(ptrTxPayload);
      NoCacheString.free(ptrPwd);

      if (err.isSuccess()) {
        signResult = fromUtf8Null(ptrSignResult.value);
      }
      clib.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  DlResult1<String> rawTxSign(NetType netType, EthRawTxPayload rawTxPayload, NoCacheString password) {
    Error err;
    String signResult;
    {
      var ptrSignResult = clib.CStr_dAlloc();
      var ptrNetType = netType.toEnumString().toCPtr();
      var ptrRawTxPayload = rawTxPayload.toCPtr();
      var ptrPwd = password.toCPtr();
      var cerr = clib.ChainEth_rawTxSign(_ptrContext, ptrNetType, ptrRawTxPayload, ptrPwd, ptrSignResult);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrNetType.free();
      EthRawTxPayload.free(ptrRawTxPayload);
      NoCacheString.free(ptrPwd);

      if (err.isSuccess()) {
        signResult = fromUtf8Null(ptrSignResult.value);
      }
      clib.CStr_dFree(ptrSignResult);
    }

    return DlResult1(signResult, err);
  }

  Error updateAuthTokenList(ArrayCEthChainTokenAuth authTokens) {
    Error err;
    {
      var ptrAuthTokens = authTokens.toCPtr();
      var cerr = clib.ChainEth_updateAuthTokenList(_ptrContext, ptrAuthTokens);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ArrayCEthChainTokenAuth.free(ptrAuthTokens);
    }

    return err;
  }

  DlResult1<List<EthChainTokenAuth>> getChainEthAuthTokenList(NetType netType, int startItem, int pageSize) {
    Error err;
    List<EthChainTokenAuth> ect = [];
    {
      var ptrNetType = netType.toEnumString().toCPtr();
      var arrayToken = clib.CArrayCEthChainTokenAuth_dAlloc();
      var cerr = clib.ChainEth_getAuthTokenList(_ptrContext, ptrNetType, startItem, pageSize, arrayToken);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        ect = ArrayCEthChainTokenAuth.fromC(arrayToken.value).data;
      }
      clib.CArrayCEthChainTokenAuth_dFree(arrayToken);
    }

    return DlResult1(ect, err);
  }

  Error updateDefaultTokenList(ArrayCEthChainTokenDefault defaultTokens) {
    Error err;
    {
      var ptrDefaultTokens = defaultTokens.toCPtr();
      var cerr = clib.ChainEth_updateDefaultTokenList(_ptrContext, ptrDefaultTokens);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ArrayCEthChainTokenDefault.free(ptrDefaultTokens);
    }

    return err;
  }
  //
  // Error addNonAuthDigit(ArrayCEthChainTokenAuth tokens) {
  //   Error err;
  //   {
  //     var ptrTokens = tokens.toCPtr();
  //     var cerr = clib.ChainEth_addNonAuthDigit(_ptrContext, ptrTokens);
  //     err = Error.fromC(cerr);
  //     clib.CError_free(cerr);
  //     ArrayCEthChainTokenAuth.free(ptrTokens);
  //   }
  //
  //   return err;
  // }

  Wallets _wallets;

  ChainEth(this._wallets);

  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;
}
