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
  Pointer<clib.CContext> _context;

  Pointer<clib.CContext> get context => _context;

  Pointer<Pointer<clib.CContext>> get dContext => _dDontext;

  set dContext(Pointer<Pointer<clib.CContext>> ctx) {
    _dDontext = ctx;
    _context = _dDontext.value;
  }

  Pointer<Pointer<clib.CContext>> _dDontext;

  Error lockRead() {
    var cerr = clib.Wallets_lockRead(_context);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error unlockRead() {
    var cerr = clib.Wallets_unlockRead(_context);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error lockWrite() {
    var cerr = clib.Wallets_lockWrite(_context);
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    return err;
  }

  Error unlockWrite() {
    var cerr = clib.Wallets_unlockWrite(_context);
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
    dContext = dptrContext;
    return err;
  }

  Error uninit() {
    var cerr = clib.Wallets_uninit(_context); //todo error
    var err = Error.fromC(cerr);
    clib.CError_free(cerr);
    cerr = nullptr;

    _context = nullptr;
    var temp = _dDontext;
    _dDontext = nullptr;
    clib.CContext_dFree(temp);
    return err;
  }

  static Wallets _instance;

  Wallets._internal();

  factory Wallets.instance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    return _instance;
  }
}
