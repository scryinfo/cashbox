import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;

class InitParameters{
  DbName dbName;

  static Pointer<clib.InitParameters> toC(InitParameters parameters) {
    var p = clib.InitParameters.allocate();
    p.ref.dbName = clib.DbName.allocate();
    return p;
  }

  static free(Pointer<clib.InitParameters> ptr) {
    DbName.free(ptr.ref.dbName);
    ptr.ref.dbName = nullptr;
    ffi.free(ptr);
  }
}

class DbName {
  String cashboxWallets;
  String cashboxMnemonic;
  String walletMainnet;
  String walletPrivate;
  String walletTestnet;
  String walletTestnetPrivate;

  static Pointer<clib.DbName> toC(DbName dbName) {
    var p = clib.DbName.allocate();
    p.ref.cashboxWallets = ffi.Utf8.toUtf8(dbName.cashboxWallets);
    p.ref.cashboxMnemonic = ffi.Utf8.toUtf8(dbName.cashboxMnemonic);
    p.ref.walletMainnet = ffi.Utf8.toUtf8(dbName.walletMainnet);
    p.ref.walletPrivate = ffi.Utf8.toUtf8(dbName.walletPrivate);
    p.ref.walletTestnet = ffi.Utf8.toUtf8(dbName.walletTestnet);
    p.ref.walletTestnetPrivate = ffi.Utf8.toUtf8(dbName.walletTestnetPrivate);
    return p;
  }

  static free(Pointer<clib.DbName> ptr) {
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

class UnInitParameters{
  static Pointer<clib.UnInitParameters> toC(UnInitParameters parameters) {
    var p = clib.UnInitParameters.allocate();
    return p;
  }

  static free(Pointer<clib.UnInitParameters> ptr) {
    ffi.free(ptr);
  }
}