library wallets;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:wallets/wallets_c.dart';
import 'package:wallets/wallets_c.dc.dart';

import 'kits.dart';
import 'wallets_c.dart' as clib;

const _False = 0;
const _True = 1;
const _dlName = "wallets_cdl";

//todo 多线程，怎么处理实现
class Wallets {
  Pointer<clib.CContext> _ptrContext;
  Context _context;

  Pointer<clib.CContext> get ptrContext => _ptrContext;

  Context get context => _context;

  set context(Context ctx) {
    _context = ctx;
    _ptrContext = ctx.toCPtr();
  }

  Error lockRead() {
    Error err;
    {
      var cerr = clib.Wallets_lockRead(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error unlockRead() {
    Error err;
    {
      var cerr = clib.Wallets_unlockRead(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error lockWrite() {
    Error err;
    {
      var cerr = clib.Wallets_lockWrite(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error unlockWrite() {
    Error err;
    {
      var cerr = clib.Wallets_unlockWrite(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error safeRead(void doRead()) {
    Error err;
    try {
      err = lockRead();
      if (err.isSuccess()) {
        doRead();
      }
    } finally {
      if (err.isSuccess()) {
        unlockRead();
      }
    }
    return err;
  }

  Error safeWrite(void doWrite()) {
    Error err;
    try {
      err = lockWrite();
      if (err.isSuccess()) {
        doWrite();
      }
    } finally {
      if (err.isSuccess()) {
        unlockWrite();
      }
    }
    return err;
  }

  ///如果失败返回 null，失败的可能性非常小
  static DbName dbName(DbName name) {
    var ptrOutName = clib.CDbName_dAlloc();
    Error err;
    {
      var ptrName = name.toCPtr();
      var cerr = clib.Wallets_dbName(ptrName, ptrOutName);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      DbName.free(ptrName);
    }
    DbName outName;
    if (err.isSuccess()) {
      outName = DbName.fromC(ptrOutName.value);
    }
    clib.CDbName_dFree(ptrOutName);
    return outName;
  }

  Error init(InitParameters parameters) {
    var ptrContext = clib.CContext_dAlloc();
    Error err;
    {
      var ptrParameters = parameters.toCPtr();
      var cerr = clib.Wallets_init(ptrParameters, ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      InitParameters.free(ptrParameters);
    }
    if (err.isSuccess()) {
      var ctx = Context.fromC(ptrContext.value);
      context = ctx;
    }
    clib.CContext_dFree(ptrContext);
    return err;
  }

  Error uninit() {
    Error err;
    {
      var cerr = clib.Wallets_uninit(ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }

    Context.free(ptrContext);
    _ptrContext = nullptr;
    return err;
  }

  DlResult1<List<Wallet>> all() {
    Error err;
    List<Wallet> ws = [];
    {
      var arrayWallet = clib.CArrayCWallet_dAlloc();
      var cerr = clib.Wallets_all(ptrContext, arrayWallet);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        var ws = ArrayCWallet.fromC(arrayWallet.value);
      }
      clib.CArrayCWallet_dFree(arrayWallet);
    }

    return DlResult1(ws, err);
  }

  static Wallets _instance;

  Wallets._internal();

  ///此方法只能在主线程中调用
  factory Wallets.mainIsolate() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    return _instance;
  }

  ///在子线程中调用时，需要上下文参数
  factory Wallets.subIsolate(Context ctx) {
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    _instance.context = ctx;
    return _instance;
  }
}
