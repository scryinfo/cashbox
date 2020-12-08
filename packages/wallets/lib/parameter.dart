import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/kits.dart';

import 'wallets_c.dart' as clib;

class InitParameters extends DC{
  DbName dbName;

  Pointer<clib.CInitParameters> toC() {
    var p = clib.CInitParameters.allocate();
    p.ref.dbName = dbName.toC();
    return p;
  }

  static free(Pointer<clib.CInitParameters> ptr) {
    DbName.free(ptr.ref.dbName);
    ptr.ref.dbName = nullptr;
    ffi.free(ptr);
  }
  InitParameters(){
    dbName = new DbName();
  }
}

class DbName extends DC{
  String cashboxWallets;
  String cashboxMnemonic;
  String walletMainnet;
  String walletPrivate;
  String walletTestnet;
  String walletTestnetPrivate;

  @override
  Pointer<clib.CDbName> toC() {
    var p = clib.CDbName.allocate();
    p.ref.cashboxWallets = ffi.Utf8.toUtf8(cashboxWallets);
    p.ref.cashboxMnemonic = ffi.Utf8.toUtf8(cashboxMnemonic);
    p.ref.walletMainnet = ffi.Utf8.toUtf8(walletMainnet);
    p.ref.walletPrivate = ffi.Utf8.toUtf8(walletPrivate);
    p.ref.walletTestnet = ffi.Utf8.toUtf8(walletTestnet);
    p.ref.walletTestnetPrivate = ffi.Utf8.toUtf8(walletTestnetPrivate);
    return p;
  }

  static free(Pointer<clib.CDbName> ptr) {
    ffi.free(ptr.ref.cashboxWallets);
    ptr.ref.cashboxWallets = nullptr;
    ffi.free(ptr.ref.cashboxMnemonic);
    ptr.ref.cashboxMnemonic = nullptr;
    ffi.free(ptr.ref.walletMainnet);
    ptr.ref.walletMainnet = nullptr;
    ffi.free(ptr.ref.walletPrivate);
    ptr.ref.walletPrivate = nullptr;
    ffi.free(ptr.ref.walletTestnet);
    ptr.ref.walletTestnet = nullptr;
    ffi.free(ptr.ref.walletTestnetPrivate);
    ptr.ref.walletTestnetPrivate = nullptr;

    ffi.free(ptr);
  }
}

class UnInitParameters extends DC{

  static free(Pointer<clib.CUnInitParameters> ptr) {
    ffi.free(ptr);
  }

  @override
  Pointer<clib.CUnInitParameters> toC() {
      var p = clib.CUnInitParameters.allocate();
      return p;
  }

}