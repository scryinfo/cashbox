library wallets;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:wallets/parameter.dart';

import 'wallets_c.dart' as clib;
import 'error.dart';

const _False = 0;
const _True = 1;
const _dlName = "wallets_cdl";
//todo 多线程，怎么处理实现
class Wallets {

  Pointer<clib.Context> _context;
  Pointer<clib.Context> get context => _context;

  Pointer<Pointer<clib.Context>> _dDontext;

  void _errorFree(Pointer<clib.CError> error){
    clib.CError_free(error);
  }

  bool lockRead() {
    var r = clib.Wallets_lockRead(_context);
    return (r == _True);
  }

  bool unlockRead() {
    var r = clib.Wallets_unlockRead(_context);
    return (r == _True);
  }

  bool lockWrite() {
    var r = clib.Wallets_lockWrite(_context);
    return (r == _True);
  }

  bool unlockWrite() {
    var r = clib.Wallets_unlockWrite(_context);
    return (r == _True);
  }

  bool safeRead(void doRead()) {
    bool r = false;
    try {
      r = lockRead();
      if (r) {
        doRead();
      }
    } finally {
      if (r) {
        unlockRead();
      }
    }
    return r;
  }

  bool safeWrite(void doWrite()) {
    bool r = false;
    try {
      r = lockWrite();
      if (r) {
        doWrite();
      }
    } finally {
      if (r) {
        unlockWrite();
      }
    }
    return r;
  }

  Error init(InitParameters parameters) {

    var ptr = InitParameters.toC(parameters);
    var dp = clib.Context_dAlloc();
    var err = clib.Wallets_init(ptr, dp);
    InitParameters.free(ptr);
    ptr = nullptr;
    //todo error
    _dDontext = dp;
    _context = _dDontext.value;
    return new Error();
  }

  Error uninit() {
    var parameters = clib.UnInitParameters.allocate();
    var err = clib.Wallets_uninit(_context, parameters); //todo error
    free(parameters);
    parameters = nullptr;
    _context = nullptr;
    var temp = _dDontext;
    _dDontext = nullptr;
    clib.Context_dFree(temp);


    return new Error();
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
