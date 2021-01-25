
import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainEth {

  DlResult1<String> decodeAdditionData(String encodeData){
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
      var cerr = clib.ChainEth_txSign(_ptrContext, ptrNetType,ptrTxPayload,ptrPwd, ptrSignResult);
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

  Wallets _wallets;
  ChainEth(this._wallets);
  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;

}