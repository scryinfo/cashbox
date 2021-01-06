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
    _ptrContext = ctx.toC();
  }

  Error lockRead() {
    var cerr = clib.Wallets_lockRead(_ptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error unlockRead() {
    var cerr = clib.Wallets_unlockRead(_ptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error lockWrite() {
    var cerr = clib.Wallets_lockWrite(_ptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error unlockWrite() {
    var cerr = clib.Wallets_unlockWrite(_ptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error safeRead(void doRead()) {
    Error err;
    try {
      err = lockRead();
      if (isSuccess(err)) {
        doRead();
      }
    } finally {
      if (isSuccess(err)) {
        unlockRead();
      }
    }
    return err;
  }

  Error safeWrite(void doWrite()) {
    Error err;
    try {
      err = lockWrite();
      if (isSuccess(err)) {
        doWrite();
      }
    } finally {
      if (isSuccess(err)) {
        unlockWrite();
      }
    }
    return err;
  }

  Error init(InitParameters parameters) {
    var ptrParameters = parameters.toC();
    var dptrContext = clib.CContext_dAlloc();
    var cerr = clib.Wallets_init(ptrParameters, dptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    InitParameters.free(ptrParameters);
    ptrParameters = nullptr;
    var ctx = Context.fromC(dptrContext.value);
    clib.CContext_dFree(dptrContext);
    context = ctx;
    return err;
  }

  Error uninit() {
    var cerr = clib.Wallets_uninit(_ptrContext);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    cerr = nullptr;

    Context.free(_ptrContext);
    _ptrContext = nullptr;
    return err;
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
