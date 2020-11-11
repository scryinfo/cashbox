library wallets;

import 'dart:ffi';

import 'wallets_c.dart';
import 'utils/cdl_kits.dart';
import 'error.dart';

const _False = 0;
const _True = 1;
const _dlName = "wallets_cdl";

class Wallets {

  void _errorFree(Pointer<CError> error){
    _c.CError_free(error);
  }

  bool lockRead() {
    var r = _c.Wallets_lockRead();
    return (r == _True);
  }

  bool unlockRead() {
    var r = _c.Wallets_unlockRead();
    return (r == _True);
  }

  bool lockWrite() {
    var r = _c.Wallets_lockWrite();
    return (r == _True);
  }

  bool unlockWrite() {
    var r = _c.Wallets_unlockWrite();
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

  Error init() {
    return new Error();
  }

  static Wallets _instance;

  Wallets._internal();

  factory Wallets.instance() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = new Wallets._internal();
      _instance._init(_dlName);
    }
    return _instance;
  }

  CWallets _c;

  _init(String dlName) {
    var dl = dlOpenPlatform(dlName);
    _c = new CWallets(dl);
  }
}
