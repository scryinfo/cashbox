import 'dart:ffi';

import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class ChainBtc {
  DlResult1<bool> updateAuthDigitList(
      NetType netType, ArrayCBtcChainTokenAuth arrayCBtcChainTokenAuth) {
    Error err;
    {
      var ptrArrayCBtcChainTokenAuth = arrayCBtcChainTokenAuth.toCPtr();
      var cerr = Wallets.cWallets.ChainBtc_updateAuthDigitList(
          _ptrContext, ptrArrayCBtcChainTokenAuth);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCBtcChainTokenAuth.free(ptrArrayCBtcChainTokenAuth);

      if (err.isSuccess()) {
        return DlResult1(true, err);
      }
    }
    return DlResult1(false, err);
  }

  DlResult1<bool> updateDefaultTokenList(
      NetType netType, ArrayCBtcChainTokenDefault arrayCBtcChainTokenDefault) {
    Error err;
    {
      var ptrArrayCBtcChainTokenDefault = arrayCBtcChainTokenDefault.toCPtr();
      var cerr = Wallets.cWallets.ChainBtc_updateDefaultTokenList(
          _ptrContext, ptrArrayCBtcChainTokenDefault);
      err = Error.fromC(cerr);
      Wallets.cWallets.CError_free(cerr);
      ArrayCBtcChainTokenDefault.free(ptrArrayCBtcChainTokenDefault);

      if (err.isSuccess()) {
        return DlResult1(true, err);
      }
    }
    return DlResult1(false, err);
  }

  Wallets _wallets;

  ChainBtc(this._wallets);

  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;
}
