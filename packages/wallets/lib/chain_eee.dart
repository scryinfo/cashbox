
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


  Wallets _wallets;
  ChainEee(this._wallets);
  Pointer<clib.CContext> get _ptrContext => _wallets.ptrContext;
}