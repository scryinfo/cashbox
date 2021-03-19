// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DCGenerator
// **************************************************************************

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;
import 'kits.dart';

class AccountInfo extends DC<clib.CAccountInfo> {
  int nonce;
  int refCount;
  String freeBalance;
  String reserved;
  String miscFrozen;
  String feeFrozen;

  static freeInstance(clib.CAccountInfo instance) {
    if (instance == null) {
      return;
    }
    if (instance.freeBalance != null && instance.freeBalance != nullptr) {
      ffi.calloc.free(instance.freeBalance);
    }
    instance.freeBalance = nullptr;
    if (instance.reserved != null && instance.reserved != nullptr) {
      ffi.calloc.free(instance.reserved);
    }
    instance.reserved = nullptr;
    if (instance.miscFrozen != null && instance.miscFrozen != nullptr) {
      ffi.calloc.free(instance.miscFrozen);
    }
    instance.miscFrozen = nullptr;
    if (instance.feeFrozen != null && instance.feeFrozen != nullptr) {
      ffi.calloc.free(instance.feeFrozen);
    }
    instance.feeFrozen = nullptr;
  }

  static free(Pointer<clib.CAccountInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static AccountInfo fromC(Pointer<clib.CAccountInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new AccountInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfo> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfo>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CAccountInfo c) {
    if (c == null) {
      return;
    }
    c.nonce = nonce;
    c.refCount = refCount;
    if (c.freeBalance != null && c.freeBalance != nullptr) {
      ffi.calloc.free(c.freeBalance);
    }
    c.freeBalance = toUtf8Null(freeBalance);
    if (c.reserved != null && c.reserved != nullptr) {
      ffi.calloc.free(c.reserved);
    }
    c.reserved = toUtf8Null(reserved);
    if (c.miscFrozen != null && c.miscFrozen != nullptr) {
      ffi.calloc.free(c.miscFrozen);
    }
    c.miscFrozen = toUtf8Null(miscFrozen);
    if (c.feeFrozen != null && c.feeFrozen != nullptr) {
      ffi.calloc.free(c.feeFrozen);
    }
    c.feeFrozen = toUtf8Null(feeFrozen);
  }

  @override
  toDart(Pointer<clib.CAccountInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAccountInfo c) {
    if (c == null) {
      return;
    }
    nonce = c.nonce;
    refCount = c.refCount;
    freeBalance = fromUtf8Null(c.freeBalance);
    reserved = fromUtf8Null(c.reserved);
    miscFrozen = fromUtf8Null(c.miscFrozen);
    feeFrozen = fromUtf8Null(c.feeFrozen);
  }
}

class AccountInfoSyncProg extends DC<clib.CAccountInfoSyncProg> {
  String account;
  String blockNo;
  String blockHash;

  static freeInstance(clib.CAccountInfoSyncProg instance) {
    if (instance == null) {
      return;
    }
    if (instance.account != null && instance.account != nullptr) {
      ffi.calloc.free(instance.account);
    }
    instance.account = nullptr;
    if (instance.blockNo != null && instance.blockNo != nullptr) {
      ffi.calloc.free(instance.blockNo);
    }
    instance.blockNo = nullptr;
    if (instance.blockHash != null && instance.blockHash != nullptr) {
      ffi.calloc.free(instance.blockHash);
    }
    instance.blockHash = nullptr;
  }

  static free(Pointer<clib.CAccountInfoSyncProg> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static AccountInfoSyncProg fromC(Pointer<clib.CAccountInfoSyncProg> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new AccountInfoSyncProg();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfoSyncProg> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfoSyncProg>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CAccountInfoSyncProg c) {
    if (c == null) {
      return;
    }
    if (c.account != null && c.account != nullptr) {
      ffi.calloc.free(c.account);
    }
    c.account = toUtf8Null(account);
    if (c.blockNo != null && c.blockNo != nullptr) {
      ffi.calloc.free(c.blockNo);
    }
    c.blockNo = toUtf8Null(blockNo);
    if (c.blockHash != null && c.blockHash != nullptr) {
      ffi.calloc.free(c.blockHash);
    }
    c.blockHash = toUtf8Null(blockHash);
  }

  @override
  toDart(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAccountInfoSyncProg c) {
    if (c == null) {
      return;
    }
    account = fromUtf8Null(c.account);
    blockNo = fromUtf8Null(c.blockNo);
    blockHash = fromUtf8Null(c.blockHash);
  }
}

class Address extends DC<clib.CAddress> {
  String id;
  String walletId;
  String chainType;
  String address;
  String publicKey;
  int isWalletAddress;
  int show;

  static freeInstance(clib.CAddress instance) {
    if (instance == null) {
      return;
    }
    if (instance.id != null && instance.id != nullptr) {
      ffi.calloc.free(instance.id);
    }
    instance.id = nullptr;
    if (instance.walletId != null && instance.walletId != nullptr) {
      ffi.calloc.free(instance.walletId);
    }
    instance.walletId = nullptr;
    if (instance.chainType != null && instance.chainType != nullptr) {
      ffi.calloc.free(instance.chainType);
    }
    instance.chainType = nullptr;
    if (instance.address != null && instance.address != nullptr) {
      ffi.calloc.free(instance.address);
    }
    instance.address = nullptr;
    if (instance.publicKey != null && instance.publicKey != nullptr) {
      ffi.calloc.free(instance.publicKey);
    }
    instance.publicKey = nullptr;
  }

  static free(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Address fromC(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Address();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toCPtr() {
    var ptr = allocateZero<clib.CAddress>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CAddress c) {
    if (c == null) {
      return;
    }
    if (c.id != null && c.id != nullptr) {
      ffi.calloc.free(c.id);
    }
    c.id = toUtf8Null(id);
    if (c.walletId != null && c.walletId != nullptr) {
      ffi.calloc.free(c.walletId);
    }
    c.walletId = toUtf8Null(walletId);
    if (c.chainType != null && c.chainType != nullptr) {
      ffi.calloc.free(c.chainType);
    }
    c.chainType = toUtf8Null(chainType);
    if (c.address != null && c.address != nullptr) {
      ffi.calloc.free(c.address);
    }
    c.address = toUtf8Null(address);
    if (c.publicKey != null && c.publicKey != nullptr) {
      ffi.calloc.free(c.publicKey);
    }
    c.publicKey = toUtf8Null(publicKey);
    c.isWalletAddress = isWalletAddress;
    c.show = show;
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAddress c) {
    if (c == null) {
      return;
    }
    id = fromUtf8Null(c.id);
    walletId = fromUtf8Null(c.walletId);
    chainType = fromUtf8Null(c.chainType);
    address = fromUtf8Null(c.address);
    publicKey = fromUtf8Null(c.publicKey);
    isWalletAddress = c.isWalletAddress;
    show = c.show;
  }
}

class ArrayCBtcChainToken extends DC<clib.CArrayCBtcChainToken> {
  List<BtcChainToken> data;

  ArrayCBtcChainToken() {
    data = <BtcChainToken>[];
  }

  static free(Pointer<clib.CArrayCBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCBtcChainToken instance) {
    if (instance == null) {
      return;
    }
    BtcChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCBtcChainToken fromC(Pointer<clib.CArrayCBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCBtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCBtcChainToken c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      BtcChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainToken>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCBtcChainToken c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new BtcChainToken();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCBtcChainTokenAuth extends DC<clib.CArrayCBtcChainTokenAuth> {
  List<BtcChainTokenAuth> data;

  ArrayCBtcChainTokenAuth() {
    data = <BtcChainTokenAuth>[];
  }

  static free(Pointer<clib.CArrayCBtcChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCBtcChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    BtcChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCBtcChainTokenAuth fromC(
      Pointer<clib.CArrayCBtcChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCBtcChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainTokenAuth>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCBtcChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCBtcChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      BtcChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainTokenAuth>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCBtcChainTokenAuth c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new BtcChainTokenAuth();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCBtcChainTokenDefault extends DC<clib.CArrayCBtcChainTokenDefault> {
  List<BtcChainTokenDefault> data;

  ArrayCBtcChainTokenDefault() {
    data = <BtcChainTokenDefault>[];
  }

  static free(Pointer<clib.CArrayCBtcChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCBtcChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    BtcChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCBtcChainTokenDefault fromC(
      Pointer<clib.CArrayCBtcChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCBtcChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainTokenDefault>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCBtcChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCBtcChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      BtcChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainTokenDefault>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCBtcChainTokenDefault c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new BtcChainTokenDefault();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCChar extends DC<clib.CArrayCChar> {
  List<String> data;

  ArrayCChar() {
    data = <String>[];
  }

  static free(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCChar instance) {
    if (instance == null) {
      return;
    }
    instance.ptr.free(instance.len);
    instance.ptr = nullptr;
  }

  static ArrayCChar fromC(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCChar();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCChar> toCPtr() {
    var c = allocateZero<clib.CArrayCChar>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCChar c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      c.ptr.free(c.len);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Pointer<ffi.Utf8>>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ptr.elementAt(i).value = data[i].toCPtr();
    }
  }

  @override
  toDart(Pointer<clib.CArrayCChar> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCChar c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = fromUtf8Null(c.ptr.elementAt(i).value);
    }
  }
}

class ArrayCContext extends DC<clib.CArrayCContext> {
  List<Context> data;

  ArrayCContext() {
    data = <Context>[];
  }

  static free(Pointer<clib.CArrayCContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCContext instance) {
    if (instance == null) {
      return;
    }
    Context.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCContext fromC(Pointer<clib.CArrayCContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCContext();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCContext> toCPtr() {
    var c = allocateZero<clib.CArrayCContext>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCContext c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      Context.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CContext>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCContext c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new Context();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEeeChainToken extends DC<clib.CArrayCEeeChainToken> {
  List<EeeChainToken> data;

  ArrayCEeeChainToken() {
    data = <EeeChainToken>[];
  }

  static free(Pointer<clib.CArrayCEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEeeChainToken instance) {
    if (instance == null) {
      return;
    }
    EeeChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEeeChainToken fromC(Pointer<clib.CArrayCEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEeeChainToken c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EeeChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainToken>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEeeChainToken c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EeeChainToken();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEeeChainTokenAuth extends DC<clib.CArrayCEeeChainTokenAuth> {
  List<EeeChainTokenAuth> data;

  ArrayCEeeChainTokenAuth() {
    data = <EeeChainTokenAuth>[];
  }

  static free(Pointer<clib.CArrayCEeeChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEeeChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    EeeChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEeeChainTokenAuth fromC(
      Pointer<clib.CArrayCEeeChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEeeChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTokenAuth>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEeeChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEeeChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EeeChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTokenAuth>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEeeChainTokenAuth c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EeeChainTokenAuth();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEeeChainTokenDefault extends DC<clib.CArrayCEeeChainTokenDefault> {
  List<EeeChainTokenDefault> data;

  ArrayCEeeChainTokenDefault() {
    data = <EeeChainTokenDefault>[];
  }

  static free(Pointer<clib.CArrayCEeeChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEeeChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    EeeChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEeeChainTokenDefault fromC(
      Pointer<clib.CArrayCEeeChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEeeChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTokenDefault>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEeeChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEeeChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EeeChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTokenDefault>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEeeChainTokenDefault c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EeeChainTokenDefault();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEeeChainTx extends DC<clib.CArrayCEeeChainTx> {
  List<EeeChainTx> data;

  ArrayCEeeChainTx() {
    data = <EeeChainTx>[];
  }

  static free(Pointer<clib.CArrayCEeeChainTx> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEeeChainTx instance) {
    if (instance == null) {
      return;
    }
    EeeChainTx.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEeeChainTx fromC(Pointer<clib.CArrayCEeeChainTx> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEeeChainTx();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTx> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTx>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEeeChainTx> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEeeChainTx c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EeeChainTx.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTx>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTx> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEeeChainTx c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EeeChainTx();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEthChainToken extends DC<clib.CArrayCEthChainToken> {
  List<EthChainToken> data;

  ArrayCEthChainToken() {
    data = <EthChainToken>[];
  }

  static free(Pointer<clib.CArrayCEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEthChainToken instance) {
    if (instance == null) {
      return;
    }
    EthChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEthChainToken fromC(Pointer<clib.CArrayCEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEthChainToken c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EthChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainToken>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEthChainToken c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EthChainToken();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEthChainTokenAuth extends DC<clib.CArrayCEthChainTokenAuth> {
  List<EthChainTokenAuth> data;

  ArrayCEthChainTokenAuth() {
    data = <EthChainTokenAuth>[];
  }

  static free(Pointer<clib.CArrayCEthChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEthChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    EthChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEthChainTokenAuth fromC(
      Pointer<clib.CArrayCEthChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEthChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenAuth>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEthChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEthChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EthChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenAuth>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEthChainTokenAuth c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EthChainTokenAuth();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEthChainTokenDefault extends DC<clib.CArrayCEthChainTokenDefault> {
  List<EthChainTokenDefault> data;

  ArrayCEthChainTokenDefault() {
    data = <EthChainTokenDefault>[];
  }

  static free(Pointer<clib.CArrayCEthChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEthChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    EthChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEthChainTokenDefault fromC(
      Pointer<clib.CArrayCEthChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEthChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenDefault>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEthChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEthChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EthChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenDefault>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEthChainTokenDefault c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EthChainTokenDefault();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCEthChainTokenNonAuth extends DC<clib.CArrayCEthChainTokenNonAuth> {
  List<EthChainTokenNonAuth> data;

  ArrayCEthChainTokenNonAuth() {
    data = <EthChainTokenNonAuth>[];
  }

  static free(Pointer<clib.CArrayCEthChainTokenNonAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCEthChainTokenNonAuth instance) {
    if (instance == null) {
      return;
    }
    EthChainTokenNonAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCEthChainTokenNonAuth fromC(
      Pointer<clib.CArrayCEthChainTokenNonAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEthChainTokenNonAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenNonAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenNonAuth>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEthChainTokenNonAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCEthChainTokenNonAuth c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      EthChainTokenNonAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenNonAuth>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenNonAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCEthChainTokenNonAuth c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new EthChainTokenNonAuth();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCExtrinsicContext extends DC<clib.CArrayCExtrinsicContext> {
  List<ExtrinsicContext> data;

  ArrayCExtrinsicContext() {
    data = <ExtrinsicContext>[];
  }

  static free(Pointer<clib.CArrayCExtrinsicContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCExtrinsicContext instance) {
    if (instance == null) {
      return;
    }
    ExtrinsicContext.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCExtrinsicContext fromC(
      Pointer<clib.CArrayCExtrinsicContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCExtrinsicContext();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCExtrinsicContext> toCPtr() {
    var c = allocateZero<clib.CArrayCExtrinsicContext>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCExtrinsicContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCExtrinsicContext c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      ExtrinsicContext.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CExtrinsicContext>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCExtrinsicContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCExtrinsicContext c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new ExtrinsicContext();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCTokenAddress extends DC<clib.CArrayCTokenAddress> {
  List<TokenAddress> data;

  ArrayCTokenAddress() {
    data = <TokenAddress>[];
  }

  static free(Pointer<clib.CArrayCTokenAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCTokenAddress instance) {
    if (instance == null) {
      return;
    }
    TokenAddress.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCTokenAddress fromC(Pointer<clib.CArrayCTokenAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCTokenAddress();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCTokenAddress> toCPtr() {
    var c = allocateZero<clib.CArrayCTokenAddress>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCTokenAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCTokenAddress c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      TokenAddress.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CTokenAddress>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCTokenAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCTokenAddress c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new TokenAddress();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCWallet extends DC<clib.CArrayCWallet> {
  List<Wallet> data;

  ArrayCWallet() {
    data = <Wallet>[];
  }

  static free(Pointer<clib.CArrayCWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCWallet instance) {
    if (instance == null) {
      return;
    }
    Wallet.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCWallet fromC(Pointer<clib.CArrayCWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCWallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCWallet> toCPtr() {
    var c = allocateZero<clib.CArrayCWallet>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCWallet c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      Wallet.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CWallet>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCWallet c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new Wallet();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayCWalletTokenStatus extends DC<clib.CArrayCWalletTokenStatus> {
  List<WalletTokenStatus> data;

  ArrayCWalletTokenStatus() {
    data = <WalletTokenStatus>[];
  }

  static free(Pointer<clib.CArrayCWalletTokenStatus> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayCWalletTokenStatus instance) {
    if (instance == null) {
      return;
    }
    WalletTokenStatus.free(instance.ptr);
    instance.ptr = nullptr;
  }

  static ArrayCWalletTokenStatus fromC(
      Pointer<clib.CArrayCWalletTokenStatus> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCWalletTokenStatus();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCWalletTokenStatus> toCPtr() {
    var c = allocateZero<clib.CArrayCWalletTokenStatus>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCWalletTokenStatus> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayCWalletTokenStatus c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      WalletTokenStatus.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CWalletTokenStatus>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCWalletTokenStatus> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayCWalletTokenStatus c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = new WalletTokenStatus();
      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}

class ArrayI64 extends DC<clib.CArrayI64> {
  List<int> data;

  ArrayI64() {
    data = <int>[];
  }

  static free(Pointer<clib.CArrayI64> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static freeInstance(clib.CArrayI64 instance) {
    if (instance == null) {
      return;
    }
    instance.ptr.free();
    instance.ptr = nullptr;
  }

  static ArrayI64 fromC(Pointer<clib.CArrayI64> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayI64();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayI64> toCPtr() {
    var c = allocateZero<clib.CArrayI64>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayI64> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CArrayI64 c) {
    if (c == null) {
      return;
    }
    if (c.ptr != nullptr && c.ptr != null) {
      c.ptr.free();
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Int64>(count: data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayI64> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CArrayI64 c) {
    if (c == null) {
      return;
    }
    data = List.filled(c.len, null);
    for (var i = 0; i < data.length; i++) {
      data[i] = c.ptr.elementAt(i).value;
    }
  }
}

class BtcChain extends DC<clib.CBtcChain> {
  ChainShared chainShared;
  ArrayCBtcChainToken tokens;

  BtcChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCBtcChainToken();
  }

  static freeInstance(clib.CBtcChain instance) {
    if (instance == null) {
      return;
    }
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCBtcChainToken.free(instance.tokens);
    instance.tokens = nullptr;
  }

  static free(Pointer<clib.CBtcChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static BtcChain fromC(Pointer<clib.CBtcChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChain> toCPtr() {
    var ptr = allocateZero<clib.CBtcChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CBtcChain c) {
    if (c == null) {
      return;
    }
    if (c.chainShared == null || c.chainShared == nullptr) {
      c.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.chainShared);
    if (c.tokens == null || c.tokens == nullptr) {
      c.tokens = allocateZero<clib.CArrayCBtcChainToken>();
    }
    tokens.toC(c.tokens);
  }

  @override
  toDart(Pointer<clib.CBtcChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChain c) {
    if (c == null) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCBtcChainToken();
    tokens.toDart(c.tokens);
  }
}

class BtcChainToken extends DC<clib.CBtcChainToken> {
  int show;
  String chainTokenSharedId;
  BtcChainTokenShared btcChainTokenShared;

  BtcChainToken() {
    btcChainTokenShared = new BtcChainTokenShared();
  }

  static freeInstance(clib.CBtcChainToken instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static BtcChainToken fromC(Pointer<clib.CBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainToken> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CBtcChainToken c) {
    if (c == null) {
      return;
    }
    c.show = show;
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.btcChainTokenShared == null || c.btcChainTokenShared == nullptr) {
      c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>();
    }
    btcChainTokenShared.toC(c.btcChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainToken c) {
    if (c == null) {
      return;
    }
    show = c.show;
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class BtcChainTokenAuth extends DC<clib.CBtcChainTokenAuth> {
  String chainTokenSharedId;
  String netType;
  int position;
  BtcChainTokenShared btcChainTokenShared;

  BtcChainTokenAuth() {
    btcChainTokenShared = new BtcChainTokenShared();
  }

  static freeInstance(clib.CBtcChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CBtcChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static BtcChainTokenAuth fromC(Pointer<clib.CBtcChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenAuth>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CBtcChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.btcChainTokenShared == null || c.btcChainTokenShared == nullptr) {
      c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>();
    }
    btcChainTokenShared.toC(c.btcChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CBtcChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenAuth c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class BtcChainTokenDefault extends DC<clib.CBtcChainTokenDefault> {
  String chainTokenSharedId;
  String netType;
  int position;
  BtcChainTokenShared btcChainTokenShared;

  BtcChainTokenDefault() {
    btcChainTokenShared = new BtcChainTokenShared();
  }

  static freeInstance(clib.CBtcChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CBtcChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static BtcChainTokenDefault fromC(Pointer<clib.CBtcChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenDefault>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CBtcChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.btcChainTokenShared == null || c.btcChainTokenShared == nullptr) {
      c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>();
    }
    btcChainTokenShared.toC(c.btcChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CBtcChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenDefault c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class BtcChainTokenShared extends DC<clib.CBtcChainTokenShared> {
  TokenShared tokenShared;
  String tokenType;
  int gas;
  int decimal;

  BtcChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static freeInstance(clib.CBtcChainTokenShared instance) {
    if (instance == null) {
      return;
    }
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != null && instance.tokenType != nullptr) {
      ffi.calloc.free(instance.tokenType);
    }
    instance.tokenType = nullptr;
  }

  static free(Pointer<clib.CBtcChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static BtcChainTokenShared fromC(Pointer<clib.CBtcChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CBtcChainTokenShared c) {
    if (c == null) {
      return;
    }
    if (c.tokenShared == null || c.tokenShared == nullptr) {
      c.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.tokenShared);
    if (c.tokenType != null && c.tokenType != nullptr) {
      ffi.calloc.free(c.tokenType);
    }
    c.tokenType = toUtf8Null(tokenType);
    c.gas = gas;
    c.decimal = decimal;
  }

  @override
  toDart(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenShared c) {
    if (c == null) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = fromUtf8Null(c.tokenType);
    gas = c.gas;
    decimal = c.decimal;
  }
}

class ChainShared extends DC<clib.CChainShared> {
  String walletId;
  String chainType;
  Address walletAddress;

  ChainShared() {
    walletAddress = new Address();
  }

  static freeInstance(clib.CChainShared instance) {
    if (instance == null) {
      return;
    }
    if (instance.walletId != null && instance.walletId != nullptr) {
      ffi.calloc.free(instance.walletId);
    }
    instance.walletId = nullptr;
    if (instance.chainType != null && instance.chainType != nullptr) {
      ffi.calloc.free(instance.chainType);
    }
    instance.chainType = nullptr;
    Address.free(instance.walletAddress);
    instance.walletAddress = nullptr;
  }

  static free(Pointer<clib.CChainShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static ChainShared fromC(Pointer<clib.CChainShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ChainShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainShared> toCPtr() {
    var ptr = allocateZero<clib.CChainShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CChainShared c) {
    if (c == null) {
      return;
    }
    if (c.walletId != null && c.walletId != nullptr) {
      ffi.calloc.free(c.walletId);
    }
    c.walletId = toUtf8Null(walletId);
    if (c.chainType != null && c.chainType != nullptr) {
      ffi.calloc.free(c.chainType);
    }
    c.chainType = toUtf8Null(chainType);
    if (c.walletAddress == null || c.walletAddress == nullptr) {
      c.walletAddress = allocateZero<clib.CAddress>();
    }
    walletAddress.toC(c.walletAddress);
  }

  @override
  toDart(Pointer<clib.CChainShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CChainShared c) {
    if (c == null) {
      return;
    }
    walletId = fromUtf8Null(c.walletId);
    chainType = fromUtf8Null(c.chainType);
    walletAddress = new Address();
    walletAddress.toDart(c.walletAddress);
  }
}

class ChainVersion extends DC<clib.CChainVersion> {
  String genesisHash;
  int runtimeVersion;
  int txVersion;

  static freeInstance(clib.CChainVersion instance) {
    if (instance == null) {
      return;
    }
    if (instance.genesisHash != null && instance.genesisHash != nullptr) {
      ffi.calloc.free(instance.genesisHash);
    }
    instance.genesisHash = nullptr;
  }

  static free(Pointer<clib.CChainVersion> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static ChainVersion fromC(Pointer<clib.CChainVersion> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ChainVersion();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainVersion> toCPtr() {
    var ptr = allocateZero<clib.CChainVersion>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainVersion> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CChainVersion c) {
    if (c == null) {
      return;
    }
    if (c.genesisHash != null && c.genesisHash != nullptr) {
      ffi.calloc.free(c.genesisHash);
    }
    c.genesisHash = toUtf8Null(genesisHash);
    c.runtimeVersion = runtimeVersion;
    c.txVersion = txVersion;
  }

  @override
  toDart(Pointer<clib.CChainVersion> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CChainVersion c) {
    if (c == null) {
      return;
    }
    genesisHash = fromUtf8Null(c.genesisHash);
    runtimeVersion = c.runtimeVersion;
    txVersion = c.txVersion;
  }
}

class Context extends DC<clib.CContext> {
  String id;
  String contextNote;

  static freeInstance(clib.CContext instance) {
    if (instance == null) {
      return;
    }
    if (instance.id != null && instance.id != nullptr) {
      ffi.calloc.free(instance.id);
    }
    instance.id = nullptr;
    if (instance.contextNote != null && instance.contextNote != nullptr) {
      ffi.calloc.free(instance.contextNote);
    }
    instance.contextNote = nullptr;
  }

  static free(Pointer<clib.CContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Context fromC(Pointer<clib.CContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Context();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CContext> toCPtr() {
    var ptr = allocateZero<clib.CContext>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CContext c) {
    if (c == null) {
      return;
    }
    if (c.id != null && c.id != nullptr) {
      ffi.calloc.free(c.id);
    }
    c.id = toUtf8Null(id);
    if (c.contextNote != null && c.contextNote != nullptr) {
      ffi.calloc.free(c.contextNote);
    }
    c.contextNote = toUtf8Null(contextNote);
  }

  @override
  toDart(Pointer<clib.CContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CContext c) {
    if (c == null) {
      return;
    }
    id = fromUtf8Null(c.id);
    contextNote = fromUtf8Null(c.contextNote);
  }
}

class CreateWalletParameters extends DC<clib.CCreateWalletParameters> {
  String name;
  String password;
  String mnemonic;
  String walletType;

  static freeInstance(clib.CCreateWalletParameters instance) {
    if (instance == null) {
      return;
    }
    if (instance.name != null && instance.name != nullptr) {
      ffi.calloc.free(instance.name);
    }
    instance.name = nullptr;
    if (instance.password != null && instance.password != nullptr) {
      ffi.calloc.free(instance.password);
    }
    instance.password = nullptr;
    if (instance.mnemonic != null && instance.mnemonic != nullptr) {
      ffi.calloc.free(instance.mnemonic);
    }
    instance.mnemonic = nullptr;
    if (instance.walletType != null && instance.walletType != nullptr) {
      ffi.calloc.free(instance.walletType);
    }
    instance.walletType = nullptr;
  }

  static free(Pointer<clib.CCreateWalletParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static CreateWalletParameters fromC(
      Pointer<clib.CCreateWalletParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new CreateWalletParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CCreateWalletParameters> toCPtr() {
    var ptr = allocateZero<clib.CCreateWalletParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CCreateWalletParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CCreateWalletParameters c) {
    if (c == null) {
      return;
    }
    if (c.name != null && c.name != nullptr) {
      ffi.calloc.free(c.name);
    }
    c.name = toUtf8Null(name);
    if (c.password != null && c.password != nullptr) {
      ffi.calloc.free(c.password);
    }
    c.password = toUtf8Null(password);
    if (c.mnemonic != null && c.mnemonic != nullptr) {
      ffi.calloc.free(c.mnemonic);
    }
    c.mnemonic = toUtf8Null(mnemonic);
    if (c.walletType != null && c.walletType != nullptr) {
      ffi.calloc.free(c.walletType);
    }
    c.walletType = toUtf8Null(walletType);
  }

  @override
  toDart(Pointer<clib.CCreateWalletParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CCreateWalletParameters c) {
    if (c == null) {
      return;
    }
    name = fromUtf8Null(c.name);
    password = fromUtf8Null(c.password);
    mnemonic = fromUtf8Null(c.mnemonic);
    walletType = fromUtf8Null(c.walletType);
  }
}

class DbName extends DC<clib.CDbName> {
  String path;
  String prefix;
  String cashboxWallets;
  String cashboxMnemonic;
  String walletMainnet;
  String walletPrivate;
  String walletTestnet;
  String walletTestnetPrivate;

  static freeInstance(clib.CDbName instance) {
    if (instance == null) {
      return;
    }
    if (instance.path != null && instance.path != nullptr) {
      ffi.calloc.free(instance.path);
    }
    instance.path = nullptr;
    if (instance.prefix != null && instance.prefix != nullptr) {
      ffi.calloc.free(instance.prefix);
    }
    instance.prefix = nullptr;
    if (instance.cashboxWallets != null && instance.cashboxWallets != nullptr) {
      ffi.calloc.free(instance.cashboxWallets);
    }
    instance.cashboxWallets = nullptr;
    if (instance.cashboxMnemonic != null &&
        instance.cashboxMnemonic != nullptr) {
      ffi.calloc.free(instance.cashboxMnemonic);
    }
    instance.cashboxMnemonic = nullptr;
    if (instance.walletMainnet != null && instance.walletMainnet != nullptr) {
      ffi.calloc.free(instance.walletMainnet);
    }
    instance.walletMainnet = nullptr;
    if (instance.walletPrivate != null && instance.walletPrivate != nullptr) {
      ffi.calloc.free(instance.walletPrivate);
    }
    instance.walletPrivate = nullptr;
    if (instance.walletTestnet != null && instance.walletTestnet != nullptr) {
      ffi.calloc.free(instance.walletTestnet);
    }
    instance.walletTestnet = nullptr;
    if (instance.walletTestnetPrivate != null &&
        instance.walletTestnetPrivate != nullptr) {
      ffi.calloc.free(instance.walletTestnetPrivate);
    }
    instance.walletTestnetPrivate = nullptr;
  }

  static free(Pointer<clib.CDbName> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static DbName fromC(Pointer<clib.CDbName> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new DbName();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDbName> toCPtr() {
    var ptr = allocateZero<clib.CDbName>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDbName> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CDbName c) {
    if (c == null) {
      return;
    }
    if (c.path != null && c.path != nullptr) {
      ffi.calloc.free(c.path);
    }
    c.path = toUtf8Null(path);
    if (c.prefix != null && c.prefix != nullptr) {
      ffi.calloc.free(c.prefix);
    }
    c.prefix = toUtf8Null(prefix);
    if (c.cashboxWallets != null && c.cashboxWallets != nullptr) {
      ffi.calloc.free(c.cashboxWallets);
    }
    c.cashboxWallets = toUtf8Null(cashboxWallets);
    if (c.cashboxMnemonic != null && c.cashboxMnemonic != nullptr) {
      ffi.calloc.free(c.cashboxMnemonic);
    }
    c.cashboxMnemonic = toUtf8Null(cashboxMnemonic);
    if (c.walletMainnet != null && c.walletMainnet != nullptr) {
      ffi.calloc.free(c.walletMainnet);
    }
    c.walletMainnet = toUtf8Null(walletMainnet);
    if (c.walletPrivate != null && c.walletPrivate != nullptr) {
      ffi.calloc.free(c.walletPrivate);
    }
    c.walletPrivate = toUtf8Null(walletPrivate);
    if (c.walletTestnet != null && c.walletTestnet != nullptr) {
      ffi.calloc.free(c.walletTestnet);
    }
    c.walletTestnet = toUtf8Null(walletTestnet);
    if (c.walletTestnetPrivate != null && c.walletTestnetPrivate != nullptr) {
      ffi.calloc.free(c.walletTestnetPrivate);
    }
    c.walletTestnetPrivate = toUtf8Null(walletTestnetPrivate);
  }

  @override
  toDart(Pointer<clib.CDbName> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CDbName c) {
    if (c == null) {
      return;
    }
    path = fromUtf8Null(c.path);
    prefix = fromUtf8Null(c.prefix);
    cashboxWallets = fromUtf8Null(c.cashboxWallets);
    cashboxMnemonic = fromUtf8Null(c.cashboxMnemonic);
    walletMainnet = fromUtf8Null(c.walletMainnet);
    walletPrivate = fromUtf8Null(c.walletPrivate);
    walletTestnet = fromUtf8Null(c.walletTestnet);
    walletTestnetPrivate = fromUtf8Null(c.walletTestnetPrivate);
  }
}

class DecodeAccountInfoParameters
    extends DC<clib.CDecodeAccountInfoParameters> {
  String encodeData;
  ChainVersion chainVersion;

  DecodeAccountInfoParameters() {
    chainVersion = new ChainVersion();
  }

  static freeInstance(clib.CDecodeAccountInfoParameters instance) {
    if (instance == null) {
      return;
    }
    if (instance.encodeData != null && instance.encodeData != nullptr) {
      ffi.calloc.free(instance.encodeData);
    }
    instance.encodeData = nullptr;
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
  }

  static free(Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static DecodeAccountInfoParameters fromC(
      Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new DecodeAccountInfoParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDecodeAccountInfoParameters> toCPtr() {
    var ptr = allocateZero<clib.CDecodeAccountInfoParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CDecodeAccountInfoParameters c) {
    if (c == null) {
      return;
    }
    if (c.encodeData != null && c.encodeData != nullptr) {
      ffi.calloc.free(c.encodeData);
    }
    c.encodeData = toUtf8Null(encodeData);
    if (c.chainVersion == null || c.chainVersion == nullptr) {
      c.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.chainVersion);
  }

  @override
  toDart(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CDecodeAccountInfoParameters c) {
    if (c == null) {
      return;
    }
    encodeData = fromUtf8Null(c.encodeData);
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
  }
}

class EeeChain extends DC<clib.CEeeChain> {
  ChainShared chainShared;
  ArrayCEeeChainToken tokens;

  EeeChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCEeeChainToken();
  }

  static freeInstance(clib.CEeeChain instance) {
    if (instance == null) {
      return;
    }
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCEeeChainToken.free(instance.tokens);
    instance.tokens = nullptr;
  }

  static free(Pointer<clib.CEeeChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChain fromC(Pointer<clib.CEeeChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChain> toCPtr() {
    var ptr = allocateZero<clib.CEeeChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChain c) {
    if (c == null) {
      return;
    }
    if (c.chainShared == null || c.chainShared == nullptr) {
      c.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.chainShared);
    if (c.tokens == null || c.tokens == nullptr) {
      c.tokens = allocateZero<clib.CArrayCEeeChainToken>();
    }
    tokens.toC(c.tokens);
  }

  @override
  toDart(Pointer<clib.CEeeChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChain c) {
    if (c == null) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCEeeChainToken();
    tokens.toDart(c.tokens);
  }
}

class EeeChainToken extends DC<clib.CEeeChainToken> {
  int show;
  String chainTokenSharedId;
  EeeChainTokenShared eeeChainTokenShared;

  EeeChainToken() {
    eeeChainTokenShared = new EeeChainTokenShared();
  }

  static freeInstance(clib.CEeeChainToken instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChainToken fromC(Pointer<clib.CEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChainToken c) {
    if (c == null) {
      return;
    }
    c.show = show;
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.eeeChainTokenShared == null || c.eeeChainTokenShared == nullptr) {
      c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>();
    }
    eeeChainTokenShared.toC(c.eeeChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainToken c) {
    if (c == null) {
      return;
    }
    show = c.show;
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class EeeChainTokenAuth extends DC<clib.CEeeChainTokenAuth> {
  String chainTokenSharedId;
  String netType;
  int position;
  EeeChainTokenShared eeeChainTokenShared;

  EeeChainTokenAuth() {
    eeeChainTokenShared = new EeeChainTokenShared();
  }

  static freeInstance(clib.CEeeChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEeeChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChainTokenAuth fromC(Pointer<clib.CEeeChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenAuth>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.eeeChainTokenShared == null || c.eeeChainTokenShared == nullptr) {
      c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>();
    }
    eeeChainTokenShared.toC(c.eeeChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEeeChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenAuth c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class EeeChainTokenDefault extends DC<clib.CEeeChainTokenDefault> {
  String chainTokenSharedId;
  String netType;
  int position;
  EeeChainTokenShared eeeChainTokenShared;

  EeeChainTokenDefault() {
    eeeChainTokenShared = new EeeChainTokenShared();
  }

  static freeInstance(clib.CEeeChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEeeChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChainTokenDefault fromC(Pointer<clib.CEeeChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenDefault>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.eeeChainTokenShared == null || c.eeeChainTokenShared == nullptr) {
      c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>();
    }
    eeeChainTokenShared.toC(c.eeeChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEeeChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenDefault c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class EeeChainTokenShared extends DC<clib.CEeeChainTokenShared> {
  TokenShared tokenShared;
  String tokenType;
  int gasLimit;
  String gasPrice;
  int decimal;

  EeeChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static freeInstance(clib.CEeeChainTokenShared instance) {
    if (instance == null) {
      return;
    }
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != null && instance.tokenType != nullptr) {
      ffi.calloc.free(instance.tokenType);
    }
    instance.tokenType = nullptr;
    if (instance.gasPrice != null && instance.gasPrice != nullptr) {
      ffi.calloc.free(instance.gasPrice);
    }
    instance.gasPrice = nullptr;
  }

  static free(Pointer<clib.CEeeChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChainTokenShared fromC(Pointer<clib.CEeeChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChainTokenShared c) {
    if (c == null) {
      return;
    }
    if (c.tokenShared == null || c.tokenShared == nullptr) {
      c.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.tokenShared);
    if (c.tokenType != null && c.tokenType != nullptr) {
      ffi.calloc.free(c.tokenType);
    }
    c.tokenType = toUtf8Null(tokenType);
    c.gasLimit = gasLimit;
    if (c.gasPrice != null && c.gasPrice != nullptr) {
      ffi.calloc.free(c.gasPrice);
    }
    c.gasPrice = toUtf8Null(gasPrice);
    c.decimal = decimal;
  }

  @override
  toDart(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenShared c) {
    if (c == null) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = fromUtf8Null(c.tokenType);
    gasLimit = c.gasLimit;
    gasPrice = fromUtf8Null(c.gasPrice);
    decimal = c.decimal;
  }
}

class EeeChainTx extends DC<clib.CEeeChainTx> {
  String txHash;
  String blockHash;
  String blockNumber;
  String signer;
  String walletAccount;
  String fromAddress;
  String toAddress;
  String value;
  String extension;
  int status;
  int txTimestamp;
  String txBytes;

  static freeInstance(clib.CEeeChainTx instance) {
    if (instance == null) {
      return;
    }
    if (instance.txHash != null && instance.txHash != nullptr) {
      ffi.calloc.free(instance.txHash);
    }
    instance.txHash = nullptr;
    if (instance.blockHash != null && instance.blockHash != nullptr) {
      ffi.calloc.free(instance.blockHash);
    }
    instance.blockHash = nullptr;
    if (instance.blockNumber != null && instance.blockNumber != nullptr) {
      ffi.calloc.free(instance.blockNumber);
    }
    instance.blockNumber = nullptr;
    if (instance.signer != null && instance.signer != nullptr) {
      ffi.calloc.free(instance.signer);
    }
    instance.signer = nullptr;
    if (instance.walletAccount != null && instance.walletAccount != nullptr) {
      ffi.calloc.free(instance.walletAccount);
    }
    instance.walletAccount = nullptr;
    if (instance.fromAddress != null && instance.fromAddress != nullptr) {
      ffi.calloc.free(instance.fromAddress);
    }
    instance.fromAddress = nullptr;
    if (instance.toAddress != null && instance.toAddress != nullptr) {
      ffi.calloc.free(instance.toAddress);
    }
    instance.toAddress = nullptr;
    if (instance.value != null && instance.value != nullptr) {
      ffi.calloc.free(instance.value);
    }
    instance.value = nullptr;
    if (instance.extension != null && instance.extension != nullptr) {
      ffi.calloc.free(instance.extension);
    }
    instance.extension = nullptr;
    if (instance.txBytes != null && instance.txBytes != nullptr) {
      ffi.calloc.free(instance.txBytes);
    }
    instance.txBytes = nullptr;
  }

  static free(Pointer<clib.CEeeChainTx> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeChainTx fromC(Pointer<clib.CEeeChainTx> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainTx();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTx> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTx>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTx> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeChainTx c) {
    if (c == null) {
      return;
    }
    if (c.txHash != null && c.txHash != nullptr) {
      ffi.calloc.free(c.txHash);
    }
    c.txHash = toUtf8Null(txHash);
    if (c.blockHash != null && c.blockHash != nullptr) {
      ffi.calloc.free(c.blockHash);
    }
    c.blockHash = toUtf8Null(blockHash);
    if (c.blockNumber != null && c.blockNumber != nullptr) {
      ffi.calloc.free(c.blockNumber);
    }
    c.blockNumber = toUtf8Null(blockNumber);
    if (c.signer != null && c.signer != nullptr) {
      ffi.calloc.free(c.signer);
    }
    c.signer = toUtf8Null(signer);
    if (c.walletAccount != null && c.walletAccount != nullptr) {
      ffi.calloc.free(c.walletAccount);
    }
    c.walletAccount = toUtf8Null(walletAccount);
    if (c.fromAddress != null && c.fromAddress != nullptr) {
      ffi.calloc.free(c.fromAddress);
    }
    c.fromAddress = toUtf8Null(fromAddress);
    if (c.toAddress != null && c.toAddress != nullptr) {
      ffi.calloc.free(c.toAddress);
    }
    c.toAddress = toUtf8Null(toAddress);
    if (c.value != null && c.value != nullptr) {
      ffi.calloc.free(c.value);
    }
    c.value = toUtf8Null(value);
    if (c.extension != null && c.extension != nullptr) {
      ffi.calloc.free(c.extension);
    }
    c.extension = toUtf8Null(extension);
    c.status = status;
    c.txTimestamp = txTimestamp;
    if (c.txBytes != null && c.txBytes != nullptr) {
      ffi.calloc.free(c.txBytes);
    }
    c.txBytes = toUtf8Null(txBytes);
  }

  @override
  toDart(Pointer<clib.CEeeChainTx> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTx c) {
    if (c == null) {
      return;
    }
    txHash = fromUtf8Null(c.txHash);
    blockHash = fromUtf8Null(c.blockHash);
    blockNumber = fromUtf8Null(c.blockNumber);
    signer = fromUtf8Null(c.signer);
    walletAccount = fromUtf8Null(c.walletAccount);
    fromAddress = fromUtf8Null(c.fromAddress);
    toAddress = fromUtf8Null(c.toAddress);
    value = fromUtf8Null(c.value);
    extension = fromUtf8Null(c.extension);
    status = c.status;
    txTimestamp = c.txTimestamp;
    txBytes = fromUtf8Null(c.txBytes);
  }
}

class EeeTransferPayload extends DC<clib.CEeeTransferPayload> {
  String fromAccount;
  String toAccount;
  String value;
  int index;
  ChainVersion chainVersion;
  String extData;
  String password;

  EeeTransferPayload() {
    chainVersion = new ChainVersion();
  }

  static freeInstance(clib.CEeeTransferPayload instance) {
    if (instance == null) {
      return;
    }
    if (instance.fromAccount != null && instance.fromAccount != nullptr) {
      ffi.calloc.free(instance.fromAccount);
    }
    instance.fromAccount = nullptr;
    if (instance.toAccount != null && instance.toAccount != nullptr) {
      ffi.calloc.free(instance.toAccount);
    }
    instance.toAccount = nullptr;
    if (instance.value != null && instance.value != nullptr) {
      ffi.calloc.free(instance.value);
    }
    instance.value = nullptr;
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.extData != null && instance.extData != nullptr) {
      ffi.calloc.free(instance.extData);
    }
    instance.extData = nullptr;
    if (instance.password != null && instance.password != nullptr) {
      ffi.calloc.free(instance.password);
    }
    instance.password = nullptr;
  }

  static free(Pointer<clib.CEeeTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EeeTransferPayload fromC(Pointer<clib.CEeeTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeTransferPayload();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeTransferPayload> toCPtr() {
    var ptr = allocateZero<clib.CEeeTransferPayload>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEeeTransferPayload c) {
    if (c == null) {
      return;
    }
    if (c.fromAccount != null && c.fromAccount != nullptr) {
      ffi.calloc.free(c.fromAccount);
    }
    c.fromAccount = toUtf8Null(fromAccount);
    if (c.toAccount != null && c.toAccount != nullptr) {
      ffi.calloc.free(c.toAccount);
    }
    c.toAccount = toUtf8Null(toAccount);
    if (c.value != null && c.value != nullptr) {
      ffi.calloc.free(c.value);
    }
    c.value = toUtf8Null(value);
    c.index = index;
    if (c.chainVersion == null || c.chainVersion == nullptr) {
      c.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.chainVersion);
    if (c.extData != null && c.extData != nullptr) {
      ffi.calloc.free(c.extData);
    }
    c.extData = toUtf8Null(extData);
    if (c.password != null && c.password != nullptr) {
      ffi.calloc.free(c.password);
    }
    c.password = toUtf8Null(password);
  }

  @override
  toDart(Pointer<clib.CEeeTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeTransferPayload c) {
    if (c == null) {
      return;
    }
    fromAccount = fromUtf8Null(c.fromAccount);
    toAccount = fromUtf8Null(c.toAccount);
    value = fromUtf8Null(c.value);
    index = c.index;
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    extData = fromUtf8Null(c.extData);
    password = fromUtf8Null(c.password);
  }
}

class Error extends DC<clib.CError> {
  int code;
  String message;

  static freeInstance(clib.CError instance) {
    if (instance == null) {
      return;
    }
    if (instance.message != null && instance.message != nullptr) {
      ffi.calloc.free(instance.message);
    }
    instance.message = nullptr;
  }

  static free(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Error fromC(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Error();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toCPtr() {
    var ptr = allocateZero<clib.CError>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CError c) {
    if (c == null) {
      return;
    }
    c.code = code;
    if (c.message != null && c.message != nullptr) {
      ffi.calloc.free(c.message);
    }
    c.message = toUtf8Null(message);
  }

  @override
  toDart(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CError c) {
    if (c == null) {
      return;
    }
    code = c.code;
    message = fromUtf8Null(c.message);
  }
}

class EthChain extends DC<clib.CEthChain> {
  ChainShared chainShared;
  ArrayCEthChainToken tokens;

  EthChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCEthChainToken();
  }

  static freeInstance(clib.CEthChain instance) {
    if (instance == null) {
      return;
    }
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCEthChainToken.free(instance.tokens);
    instance.tokens = nullptr;
  }

  static free(Pointer<clib.CEthChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChain fromC(Pointer<clib.CEthChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChain> toCPtr() {
    var ptr = allocateZero<clib.CEthChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChain c) {
    if (c == null) {
      return;
    }
    if (c.chainShared == null || c.chainShared == nullptr) {
      c.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.chainShared);
    if (c.tokens == null || c.tokens == nullptr) {
      c.tokens = allocateZero<clib.CArrayCEthChainToken>();
    }
    tokens.toC(c.tokens);
  }

  @override
  toDart(Pointer<clib.CEthChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChain c) {
    if (c == null) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCEthChainToken();
    tokens.toDart(c.tokens);
  }
}

class EthChainToken extends DC<clib.CEthChainToken> {
  String chainTokenSharedId;
  int show;
  String contractAddress;
  EthChainTokenShared ethChainTokenShared;

  EthChainToken() {
    ethChainTokenShared = new EthChainTokenShared();
  }

  static freeInstance(clib.CEthChainToken instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.contractAddress != null &&
        instance.contractAddress != nullptr) {
      ffi.calloc.free(instance.contractAddress);
    }
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChainToken fromC(Pointer<clib.CEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEthChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChainToken c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    c.show = show;
    if (c.contractAddress != null && c.contractAddress != nullptr) {
      ffi.calloc.free(c.contractAddress);
    }
    c.contractAddress = toUtf8Null(contractAddress);
    if (c.ethChainTokenShared == null || c.ethChainTokenShared == nullptr) {
      c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>();
    }
    ethChainTokenShared.toC(c.ethChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainToken c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    show = c.show;
    contractAddress = fromUtf8Null(c.contractAddress);
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class EthChainTokenAuth extends DC<clib.CEthChainTokenAuth> {
  String chainTokenSharedId;
  String netType;
  int position;
  String contractAddress;
  EthChainTokenShared ethChainTokenShared;

  EthChainTokenAuth() {
    ethChainTokenShared = new EthChainTokenShared();
  }

  static freeInstance(clib.CEthChainTokenAuth instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    if (instance.contractAddress != null &&
        instance.contractAddress != nullptr) {
      ffi.calloc.free(instance.contractAddress);
    }
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEthChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChainTokenAuth fromC(Pointer<clib.CEthChainTokenAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainTokenAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenAuth>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChainTokenAuth c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.contractAddress != null && c.contractAddress != nullptr) {
      ffi.calloc.free(c.contractAddress);
    }
    c.contractAddress = toUtf8Null(contractAddress);
    if (c.ethChainTokenShared == null || c.ethChainTokenShared == nullptr) {
      c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>();
    }
    ethChainTokenShared.toC(c.ethChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainTokenAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenAuth c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    contractAddress = fromUtf8Null(c.contractAddress);
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class EthChainTokenDefault extends DC<clib.CEthChainTokenDefault> {
  String chainTokenSharedId;
  String netType;
  int position;
  String contractAddress;
  EthChainTokenShared ethChainTokenShared;

  EthChainTokenDefault() {
    ethChainTokenShared = new EthChainTokenShared();
  }

  static freeInstance(clib.CEthChainTokenDefault instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    if (instance.contractAddress != null &&
        instance.contractAddress != nullptr) {
      ffi.calloc.free(instance.contractAddress);
    }
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEthChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChainTokenDefault fromC(Pointer<clib.CEthChainTokenDefault> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainTokenDefault();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenDefault>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChainTokenDefault c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.contractAddress != null && c.contractAddress != nullptr) {
      ffi.calloc.free(c.contractAddress);
    }
    c.contractAddress = toUtf8Null(contractAddress);
    if (c.ethChainTokenShared == null || c.ethChainTokenShared == nullptr) {
      c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>();
    }
    ethChainTokenShared.toC(c.ethChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainTokenDefault> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenDefault c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    contractAddress = fromUtf8Null(c.contractAddress);
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class EthChainTokenNonAuth extends DC<clib.CEthChainTokenNonAuth> {
  String chainTokenSharedId;
  String netType;
  int position;
  String contractAddress;
  EthChainTokenShared ethChainTokenShared;

  EthChainTokenNonAuth() {
    ethChainTokenShared = new EthChainTokenShared();
  }

  static freeInstance(clib.CEthChainTokenNonAuth instance) {
    if (instance == null) {
      return;
    }
    if (instance.chainTokenSharedId != null &&
        instance.chainTokenSharedId != nullptr) {
      ffi.calloc.free(instance.chainTokenSharedId);
    }
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != null && instance.netType != nullptr) {
      ffi.calloc.free(instance.netType);
    }
    instance.netType = nullptr;
    if (instance.contractAddress != null &&
        instance.contractAddress != nullptr) {
      ffi.calloc.free(instance.contractAddress);
    }
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;
  }

  static free(Pointer<clib.CEthChainTokenNonAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChainTokenNonAuth fromC(Pointer<clib.CEthChainTokenNonAuth> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainTokenNonAuth();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenNonAuth> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenNonAuth>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenNonAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChainTokenNonAuth c) {
    if (c == null) {
      return;
    }
    if (c.chainTokenSharedId != null && c.chainTokenSharedId != nullptr) {
      ffi.calloc.free(c.chainTokenSharedId);
    }
    c.chainTokenSharedId = toUtf8Null(chainTokenSharedId);
    if (c.netType != null && c.netType != nullptr) {
      ffi.calloc.free(c.netType);
    }
    c.netType = toUtf8Null(netType);
    c.position = position;
    if (c.contractAddress != null && c.contractAddress != nullptr) {
      ffi.calloc.free(c.contractAddress);
    }
    c.contractAddress = toUtf8Null(contractAddress);
    if (c.ethChainTokenShared == null || c.ethChainTokenShared == nullptr) {
      c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>();
    }
    ethChainTokenShared.toC(c.ethChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainTokenNonAuth> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenNonAuth c) {
    if (c == null) {
      return;
    }
    chainTokenSharedId = fromUtf8Null(c.chainTokenSharedId);
    netType = fromUtf8Null(c.netType);
    position = c.position;
    contractAddress = fromUtf8Null(c.contractAddress);
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class EthChainTokenShared extends DC<clib.CEthChainTokenShared> {
  TokenShared tokenShared;
  String tokenType;
  int gasLimit;
  String gasPrice;
  int decimal;

  EthChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static freeInstance(clib.CEthChainTokenShared instance) {
    if (instance == null) {
      return;
    }
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != null && instance.tokenType != nullptr) {
      ffi.calloc.free(instance.tokenType);
    }
    instance.tokenType = nullptr;
    if (instance.gasPrice != null && instance.gasPrice != nullptr) {
      ffi.calloc.free(instance.gasPrice);
    }
    instance.gasPrice = nullptr;
  }

  static free(Pointer<clib.CEthChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthChainTokenShared fromC(Pointer<clib.CEthChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthChainTokenShared c) {
    if (c == null) {
      return;
    }
    if (c.tokenShared == null || c.tokenShared == nullptr) {
      c.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.tokenShared);
    if (c.tokenType != null && c.tokenType != nullptr) {
      ffi.calloc.free(c.tokenType);
    }
    c.tokenType = toUtf8Null(tokenType);
    c.gasLimit = gasLimit;
    if (c.gasPrice != null && c.gasPrice != nullptr) {
      ffi.calloc.free(c.gasPrice);
    }
    c.gasPrice = toUtf8Null(gasPrice);
    c.decimal = decimal;
  }

  @override
  toDart(Pointer<clib.CEthChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenShared c) {
    if (c == null) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = fromUtf8Null(c.tokenType);
    gasLimit = c.gasLimit;
    gasPrice = fromUtf8Null(c.gasPrice);
    decimal = c.decimal;
  }
}

class EthRawTxPayload extends DC<clib.CEthRawTxPayload> {
  String fromAddress;
  String rawTx;

  static freeInstance(clib.CEthRawTxPayload instance) {
    if (instance == null) {
      return;
    }
    if (instance.fromAddress != null && instance.fromAddress != nullptr) {
      ffi.calloc.free(instance.fromAddress);
    }
    instance.fromAddress = nullptr;
    if (instance.rawTx != null && instance.rawTx != nullptr) {
      ffi.calloc.free(instance.rawTx);
    }
    instance.rawTx = nullptr;
  }

  static free(Pointer<clib.CEthRawTxPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthRawTxPayload fromC(Pointer<clib.CEthRawTxPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthRawTxPayload();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthRawTxPayload> toCPtr() {
    var ptr = allocateZero<clib.CEthRawTxPayload>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthRawTxPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthRawTxPayload c) {
    if (c == null) {
      return;
    }
    if (c.fromAddress != null && c.fromAddress != nullptr) {
      ffi.calloc.free(c.fromAddress);
    }
    c.fromAddress = toUtf8Null(fromAddress);
    if (c.rawTx != null && c.rawTx != nullptr) {
      ffi.calloc.free(c.rawTx);
    }
    c.rawTx = toUtf8Null(rawTx);
  }

  @override
  toDart(Pointer<clib.CEthRawTxPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthRawTxPayload c) {
    if (c == null) {
      return;
    }
    fromAddress = fromUtf8Null(c.fromAddress);
    rawTx = fromUtf8Null(c.rawTx);
  }
}

class EthTransferPayload extends DC<clib.CEthTransferPayload> {
  String fromAddress;
  String toAddress;
  String contractAddress;
  String value;
  String nonce;
  String gasPrice;
  String gasLimit;
  int decimal;
  String extData;

  static freeInstance(clib.CEthTransferPayload instance) {
    if (instance == null) {
      return;
    }
    if (instance.fromAddress != null && instance.fromAddress != nullptr) {
      ffi.calloc.free(instance.fromAddress);
    }
    instance.fromAddress = nullptr;
    if (instance.toAddress != null && instance.toAddress != nullptr) {
      ffi.calloc.free(instance.toAddress);
    }
    instance.toAddress = nullptr;
    if (instance.contractAddress != null &&
        instance.contractAddress != nullptr) {
      ffi.calloc.free(instance.contractAddress);
    }
    instance.contractAddress = nullptr;
    if (instance.value != null && instance.value != nullptr) {
      ffi.calloc.free(instance.value);
    }
    instance.value = nullptr;
    if (instance.nonce != null && instance.nonce != nullptr) {
      ffi.calloc.free(instance.nonce);
    }
    instance.nonce = nullptr;
    if (instance.gasPrice != null && instance.gasPrice != nullptr) {
      ffi.calloc.free(instance.gasPrice);
    }
    instance.gasPrice = nullptr;
    if (instance.gasLimit != null && instance.gasLimit != nullptr) {
      ffi.calloc.free(instance.gasLimit);
    }
    instance.gasLimit = nullptr;
    if (instance.extData != null && instance.extData != nullptr) {
      ffi.calloc.free(instance.extData);
    }
    instance.extData = nullptr;
  }

  static free(Pointer<clib.CEthTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static EthTransferPayload fromC(Pointer<clib.CEthTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthTransferPayload();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthTransferPayload> toCPtr() {
    var ptr = allocateZero<clib.CEthTransferPayload>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CEthTransferPayload c) {
    if (c == null) {
      return;
    }
    if (c.fromAddress != null && c.fromAddress != nullptr) {
      ffi.calloc.free(c.fromAddress);
    }
    c.fromAddress = toUtf8Null(fromAddress);
    if (c.toAddress != null && c.toAddress != nullptr) {
      ffi.calloc.free(c.toAddress);
    }
    c.toAddress = toUtf8Null(toAddress);
    if (c.contractAddress != null && c.contractAddress != nullptr) {
      ffi.calloc.free(c.contractAddress);
    }
    c.contractAddress = toUtf8Null(contractAddress);
    if (c.value != null && c.value != nullptr) {
      ffi.calloc.free(c.value);
    }
    c.value = toUtf8Null(value);
    if (c.nonce != null && c.nonce != nullptr) {
      ffi.calloc.free(c.nonce);
    }
    c.nonce = toUtf8Null(nonce);
    if (c.gasPrice != null && c.gasPrice != nullptr) {
      ffi.calloc.free(c.gasPrice);
    }
    c.gasPrice = toUtf8Null(gasPrice);
    if (c.gasLimit != null && c.gasLimit != nullptr) {
      ffi.calloc.free(c.gasLimit);
    }
    c.gasLimit = toUtf8Null(gasLimit);
    c.decimal = decimal;
    if (c.extData != null && c.extData != nullptr) {
      ffi.calloc.free(c.extData);
    }
    c.extData = toUtf8Null(extData);
  }

  @override
  toDart(Pointer<clib.CEthTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthTransferPayload c) {
    if (c == null) {
      return;
    }
    fromAddress = fromUtf8Null(c.fromAddress);
    toAddress = fromUtf8Null(c.toAddress);
    contractAddress = fromUtf8Null(c.contractAddress);
    value = fromUtf8Null(c.value);
    nonce = fromUtf8Null(c.nonce);
    gasPrice = fromUtf8Null(c.gasPrice);
    gasLimit = fromUtf8Null(c.gasLimit);
    decimal = c.decimal;
    extData = fromUtf8Null(c.extData);
  }
}

class ExtrinsicContext extends DC<clib.CExtrinsicContext> {
  ChainVersion chainVersion;
  String account;
  String blockHash;
  String blockNumber;
  String event;
  ArrayCChar extrinsics;

  ExtrinsicContext() {
    chainVersion = new ChainVersion();
    extrinsics = new ArrayCChar();
  }

  static freeInstance(clib.CExtrinsicContext instance) {
    if (instance == null) {
      return;
    }
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.account != null && instance.account != nullptr) {
      ffi.calloc.free(instance.account);
    }
    instance.account = nullptr;
    if (instance.blockHash != null && instance.blockHash != nullptr) {
      ffi.calloc.free(instance.blockHash);
    }
    instance.blockHash = nullptr;
    if (instance.blockNumber != null && instance.blockNumber != nullptr) {
      ffi.calloc.free(instance.blockNumber);
    }
    instance.blockNumber = nullptr;
    if (instance.event != null && instance.event != nullptr) {
      ffi.calloc.free(instance.event);
    }
    instance.event = nullptr;
    ArrayCChar.free(instance.extrinsics);
    instance.extrinsics = nullptr;
  }

  static free(Pointer<clib.CExtrinsicContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static ExtrinsicContext fromC(Pointer<clib.CExtrinsicContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ExtrinsicContext();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CExtrinsicContext> toCPtr() {
    var ptr = allocateZero<clib.CExtrinsicContext>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CExtrinsicContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CExtrinsicContext c) {
    if (c == null) {
      return;
    }
    if (c.chainVersion == null || c.chainVersion == nullptr) {
      c.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.chainVersion);
    if (c.account != null && c.account != nullptr) {
      ffi.calloc.free(c.account);
    }
    c.account = toUtf8Null(account);
    if (c.blockHash != null && c.blockHash != nullptr) {
      ffi.calloc.free(c.blockHash);
    }
    c.blockHash = toUtf8Null(blockHash);
    if (c.blockNumber != null && c.blockNumber != nullptr) {
      ffi.calloc.free(c.blockNumber);
    }
    c.blockNumber = toUtf8Null(blockNumber);
    if (c.event != null && c.event != nullptr) {
      ffi.calloc.free(c.event);
    }
    c.event = toUtf8Null(event);
    if (c.extrinsics == null || c.extrinsics == nullptr) {
      c.extrinsics = allocateZero<clib.CArrayCChar>();
    }
    extrinsics.toC(c.extrinsics);
  }

  @override
  toDart(Pointer<clib.CExtrinsicContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CExtrinsicContext c) {
    if (c == null) {
      return;
    }
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    account = fromUtf8Null(c.account);
    blockHash = fromUtf8Null(c.blockHash);
    blockNumber = fromUtf8Null(c.blockNumber);
    event = fromUtf8Null(c.event);
    extrinsics = new ArrayCChar();
    extrinsics.toDart(c.extrinsics);
  }
}

class InitParameters extends DC<clib.CInitParameters> {
  DbName dbName;
  String contextNote;

  InitParameters() {
    dbName = new DbName();
  }

  static freeInstance(clib.CInitParameters instance) {
    if (instance == null) {
      return;
    }
    DbName.free(instance.dbName);
    instance.dbName = nullptr;
    if (instance.contextNote != null && instance.contextNote != nullptr) {
      ffi.calloc.free(instance.contextNote);
    }
    instance.contextNote = nullptr;
  }

  static free(Pointer<clib.CInitParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static InitParameters fromC(Pointer<clib.CInitParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new InitParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CInitParameters> toCPtr() {
    var ptr = allocateZero<clib.CInitParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CInitParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CInitParameters c) {
    if (c == null) {
      return;
    }
    if (c.dbName == null || c.dbName == nullptr) {
      c.dbName = allocateZero<clib.CDbName>();
    }
    dbName.toC(c.dbName);
    if (c.contextNote != null && c.contextNote != nullptr) {
      ffi.calloc.free(c.contextNote);
    }
    c.contextNote = toUtf8Null(contextNote);
  }

  @override
  toDart(Pointer<clib.CInitParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CInitParameters c) {
    if (c == null) {
      return;
    }
    dbName = new DbName();
    dbName.toDart(c.dbName);
    contextNote = fromUtf8Null(c.contextNote);
  }
}

class RawTxParam extends DC<clib.CRawTxParam> {
  String rawTx;
  String walletId;
  String password;

  static freeInstance(clib.CRawTxParam instance) {
    if (instance == null) {
      return;
    }
    if (instance.rawTx != null && instance.rawTx != nullptr) {
      ffi.calloc.free(instance.rawTx);
    }
    instance.rawTx = nullptr;
    if (instance.walletId != null && instance.walletId != nullptr) {
      ffi.calloc.free(instance.walletId);
    }
    instance.walletId = nullptr;
    if (instance.password != null && instance.password != nullptr) {
      ffi.calloc.free(instance.password);
    }
    instance.password = nullptr;
  }

  static free(Pointer<clib.CRawTxParam> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static RawTxParam fromC(Pointer<clib.CRawTxParam> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new RawTxParam();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CRawTxParam> toCPtr() {
    var ptr = allocateZero<clib.CRawTxParam>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CRawTxParam> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CRawTxParam c) {
    if (c == null) {
      return;
    }
    if (c.rawTx != null && c.rawTx != nullptr) {
      ffi.calloc.free(c.rawTx);
    }
    c.rawTx = toUtf8Null(rawTx);
    if (c.walletId != null && c.walletId != nullptr) {
      ffi.calloc.free(c.walletId);
    }
    c.walletId = toUtf8Null(walletId);
    if (c.password != null && c.password != nullptr) {
      ffi.calloc.free(c.password);
    }
    c.password = toUtf8Null(password);
  }

  @override
  toDart(Pointer<clib.CRawTxParam> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CRawTxParam c) {
    if (c == null) {
      return;
    }
    rawTx = fromUtf8Null(c.rawTx);
    walletId = fromUtf8Null(c.walletId);
    password = fromUtf8Null(c.password);
  }
}

class StorageKeyParameters extends DC<clib.CStorageKeyParameters> {
  ChainVersion chainVersion;
  String module;
  String storageItem;
  String account;

  StorageKeyParameters() {
    chainVersion = new ChainVersion();
  }

  static freeInstance(clib.CStorageKeyParameters instance) {
    if (instance == null) {
      return;
    }
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.module != null && instance.module != nullptr) {
      ffi.calloc.free(instance.module);
    }
    instance.module = nullptr;
    if (instance.storageItem != null && instance.storageItem != nullptr) {
      ffi.calloc.free(instance.storageItem);
    }
    instance.storageItem = nullptr;
    if (instance.account != null && instance.account != nullptr) {
      ffi.calloc.free(instance.account);
    }
    instance.account = nullptr;
  }

  static free(Pointer<clib.CStorageKeyParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static StorageKeyParameters fromC(Pointer<clib.CStorageKeyParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new StorageKeyParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CStorageKeyParameters> toCPtr() {
    var ptr = allocateZero<clib.CStorageKeyParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CStorageKeyParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CStorageKeyParameters c) {
    if (c == null) {
      return;
    }
    if (c.chainVersion == null || c.chainVersion == nullptr) {
      c.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.chainVersion);
    if (c.module != null && c.module != nullptr) {
      ffi.calloc.free(c.module);
    }
    c.module = toUtf8Null(module);
    if (c.storageItem != null && c.storageItem != nullptr) {
      ffi.calloc.free(c.storageItem);
    }
    c.storageItem = toUtf8Null(storageItem);
    if (c.account != null && c.account != nullptr) {
      ffi.calloc.free(c.account);
    }
    c.account = toUtf8Null(account);
  }

  @override
  toDart(Pointer<clib.CStorageKeyParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CStorageKeyParameters c) {
    if (c == null) {
      return;
    }
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    module = fromUtf8Null(c.module);
    storageItem = fromUtf8Null(c.storageItem);
    account = fromUtf8Null(c.account);
  }
}

class SubChainBasicInfo extends DC<clib.CSubChainBasicInfo> {
  String genesisHash;
  String metadata;
  int runtimeVersion;
  int txVersion;
  int ss58FormatPrefix;
  int tokenDecimals;
  String tokenSymbol;
  int isDefault;

  static freeInstance(clib.CSubChainBasicInfo instance) {
    if (instance == null) {
      return;
    }
    if (instance.genesisHash != null && instance.genesisHash != nullptr) {
      ffi.calloc.free(instance.genesisHash);
    }
    instance.genesisHash = nullptr;
    if (instance.metadata != null && instance.metadata != nullptr) {
      ffi.calloc.free(instance.metadata);
    }
    instance.metadata = nullptr;
    if (instance.tokenSymbol != null && instance.tokenSymbol != nullptr) {
      ffi.calloc.free(instance.tokenSymbol);
    }
    instance.tokenSymbol = nullptr;
  }

  static free(Pointer<clib.CSubChainBasicInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static SubChainBasicInfo fromC(Pointer<clib.CSubChainBasicInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new SubChainBasicInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CSubChainBasicInfo> toCPtr() {
    var ptr = allocateZero<clib.CSubChainBasicInfo>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CSubChainBasicInfo c) {
    if (c == null) {
      return;
    }
    if (c.genesisHash != null && c.genesisHash != nullptr) {
      ffi.calloc.free(c.genesisHash);
    }
    c.genesisHash = toUtf8Null(genesisHash);
    if (c.metadata != null && c.metadata != nullptr) {
      ffi.calloc.free(c.metadata);
    }
    c.metadata = toUtf8Null(metadata);
    c.runtimeVersion = runtimeVersion;
    c.txVersion = txVersion;
    c.ss58FormatPrefix = ss58FormatPrefix;
    c.tokenDecimals = tokenDecimals;
    if (c.tokenSymbol != null && c.tokenSymbol != nullptr) {
      ffi.calloc.free(c.tokenSymbol);
    }
    c.tokenSymbol = toUtf8Null(tokenSymbol);
    c.isDefault = isDefault;
  }

  @override
  toDart(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CSubChainBasicInfo c) {
    if (c == null) {
      return;
    }
    genesisHash = fromUtf8Null(c.genesisHash);
    metadata = fromUtf8Null(c.metadata);
    runtimeVersion = c.runtimeVersion;
    txVersion = c.txVersion;
    ss58FormatPrefix = c.ss58FormatPrefix;
    tokenDecimals = c.tokenDecimals;
    tokenSymbol = fromUtf8Null(c.tokenSymbol);
    isDefault = c.isDefault;
  }
}

class TokenAddress extends DC<clib.CTokenAddress> {
  String walletId;
  String chainType;
  String tokenId;
  String addressId;
  String balance;

  static freeInstance(clib.CTokenAddress instance) {
    if (instance == null) {
      return;
    }
    if (instance.walletId != null && instance.walletId != nullptr) {
      ffi.calloc.free(instance.walletId);
    }
    instance.walletId = nullptr;
    if (instance.chainType != null && instance.chainType != nullptr) {
      ffi.calloc.free(instance.chainType);
    }
    instance.chainType = nullptr;
    if (instance.tokenId != null && instance.tokenId != nullptr) {
      ffi.calloc.free(instance.tokenId);
    }
    instance.tokenId = nullptr;
    if (instance.addressId != null && instance.addressId != nullptr) {
      ffi.calloc.free(instance.addressId);
    }
    instance.addressId = nullptr;
    if (instance.balance != null && instance.balance != nullptr) {
      ffi.calloc.free(instance.balance);
    }
    instance.balance = nullptr;
  }

  static free(Pointer<clib.CTokenAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static TokenAddress fromC(Pointer<clib.CTokenAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new TokenAddress();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenAddress> toCPtr() {
    var ptr = allocateZero<clib.CTokenAddress>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTokenAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CTokenAddress c) {
    if (c == null) {
      return;
    }
    if (c.walletId != null && c.walletId != nullptr) {
      ffi.calloc.free(c.walletId);
    }
    c.walletId = toUtf8Null(walletId);
    if (c.chainType != null && c.chainType != nullptr) {
      ffi.calloc.free(c.chainType);
    }
    c.chainType = toUtf8Null(chainType);
    if (c.tokenId != null && c.tokenId != nullptr) {
      ffi.calloc.free(c.tokenId);
    }
    c.tokenId = toUtf8Null(tokenId);
    if (c.addressId != null && c.addressId != nullptr) {
      ffi.calloc.free(c.addressId);
    }
    c.addressId = toUtf8Null(addressId);
    if (c.balance != null && c.balance != nullptr) {
      ffi.calloc.free(c.balance);
    }
    c.balance = toUtf8Null(balance);
  }

  @override
  toDart(Pointer<clib.CTokenAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CTokenAddress c) {
    if (c == null) {
      return;
    }
    walletId = fromUtf8Null(c.walletId);
    chainType = fromUtf8Null(c.chainType);
    tokenId = fromUtf8Null(c.tokenId);
    addressId = fromUtf8Null(c.addressId);
    balance = fromUtf8Null(c.balance);
  }
}

class TokenShared extends DC<clib.CTokenShared> {
  String name;
  String symbol;
  String logoUrl;
  String logoBytes;
  String projectName;
  String projectHome;
  String projectNote;

  static freeInstance(clib.CTokenShared instance) {
    if (instance == null) {
      return;
    }
    if (instance.name != null && instance.name != nullptr) {
      ffi.calloc.free(instance.name);
    }
    instance.name = nullptr;
    if (instance.symbol != null && instance.symbol != nullptr) {
      ffi.calloc.free(instance.symbol);
    }
    instance.symbol = nullptr;
    if (instance.logoUrl != null && instance.logoUrl != nullptr) {
      ffi.calloc.free(instance.logoUrl);
    }
    instance.logoUrl = nullptr;
    if (instance.logoBytes != null && instance.logoBytes != nullptr) {
      ffi.calloc.free(instance.logoBytes);
    }
    instance.logoBytes = nullptr;
    if (instance.projectName != null && instance.projectName != nullptr) {
      ffi.calloc.free(instance.projectName);
    }
    instance.projectName = nullptr;
    if (instance.projectHome != null && instance.projectHome != nullptr) {
      ffi.calloc.free(instance.projectHome);
    }
    instance.projectHome = nullptr;
    if (instance.projectNote != null && instance.projectNote != nullptr) {
      ffi.calloc.free(instance.projectNote);
    }
    instance.projectNote = nullptr;
  }

  static free(Pointer<clib.CTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static TokenShared fromC(Pointer<clib.CTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new TokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CTokenShared c) {
    if (c == null) {
      return;
    }
    if (c.name != null && c.name != nullptr) {
      ffi.calloc.free(c.name);
    }
    c.name = toUtf8Null(name);
    if (c.symbol != null && c.symbol != nullptr) {
      ffi.calloc.free(c.symbol);
    }
    c.symbol = toUtf8Null(symbol);
    if (c.logoUrl != null && c.logoUrl != nullptr) {
      ffi.calloc.free(c.logoUrl);
    }
    c.logoUrl = toUtf8Null(logoUrl);
    if (c.logoBytes != null && c.logoBytes != nullptr) {
      ffi.calloc.free(c.logoBytes);
    }
    c.logoBytes = toUtf8Null(logoBytes);
    if (c.projectName != null && c.projectName != nullptr) {
      ffi.calloc.free(c.projectName);
    }
    c.projectName = toUtf8Null(projectName);
    if (c.projectHome != null && c.projectHome != nullptr) {
      ffi.calloc.free(c.projectHome);
    }
    c.projectHome = toUtf8Null(projectHome);
    if (c.projectNote != null && c.projectNote != nullptr) {
      ffi.calloc.free(c.projectNote);
    }
    c.projectNote = toUtf8Null(projectNote);
  }

  @override
  toDart(Pointer<clib.CTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CTokenShared c) {
    if (c == null) {
      return;
    }
    name = fromUtf8Null(c.name);
    symbol = fromUtf8Null(c.symbol);
    logoUrl = fromUtf8Null(c.logoUrl);
    logoBytes = fromUtf8Null(c.logoBytes);
    projectName = fromUtf8Null(c.projectName);
    projectHome = fromUtf8Null(c.projectHome);
    projectNote = fromUtf8Null(c.projectNote);
  }
}

class Wallet extends DC<clib.CWallet> {
  String id;
  String nextId;
  String name;
  String walletType;
  EthChain ethChain;
  EeeChain eeeChain;
  BtcChain btcChain;

  Wallet() {
    ethChain = new EthChain();
    eeeChain = new EeeChain();
    btcChain = new BtcChain();
  }

  static freeInstance(clib.CWallet instance) {
    if (instance == null) {
      return;
    }
    if (instance.id != null && instance.id != nullptr) {
      ffi.calloc.free(instance.id);
    }
    instance.id = nullptr;
    if (instance.nextId != null && instance.nextId != nullptr) {
      ffi.calloc.free(instance.nextId);
    }
    instance.nextId = nullptr;
    if (instance.name != null && instance.name != nullptr) {
      ffi.calloc.free(instance.name);
    }
    instance.name = nullptr;
    if (instance.walletType != null && instance.walletType != nullptr) {
      ffi.calloc.free(instance.walletType);
    }
    instance.walletType = nullptr;
    EthChain.free(instance.ethChain);
    instance.ethChain = nullptr;
    EeeChain.free(instance.eeeChain);
    instance.eeeChain = nullptr;
    BtcChain.free(instance.btcChain);
    instance.btcChain = nullptr;
  }

  static free(Pointer<clib.CWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static Wallet fromC(Pointer<clib.CWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Wallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWallet> toCPtr() {
    var ptr = allocateZero<clib.CWallet>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CWallet c) {
    if (c == null) {
      return;
    }
    if (c.id != null && c.id != nullptr) {
      ffi.calloc.free(c.id);
    }
    c.id = toUtf8Null(id);
    if (c.nextId != null && c.nextId != nullptr) {
      ffi.calloc.free(c.nextId);
    }
    c.nextId = toUtf8Null(nextId);
    if (c.name != null && c.name != nullptr) {
      ffi.calloc.free(c.name);
    }
    c.name = toUtf8Null(name);
    if (c.walletType != null && c.walletType != nullptr) {
      ffi.calloc.free(c.walletType);
    }
    c.walletType = toUtf8Null(walletType);
    if (c.ethChain == null || c.ethChain == nullptr) {
      c.ethChain = allocateZero<clib.CEthChain>();
    }
    ethChain.toC(c.ethChain);
    if (c.eeeChain == null || c.eeeChain == nullptr) {
      c.eeeChain = allocateZero<clib.CEeeChain>();
    }
    eeeChain.toC(c.eeeChain);
    if (c.btcChain == null || c.btcChain == nullptr) {
      c.btcChain = allocateZero<clib.CBtcChain>();
    }
    btcChain.toC(c.btcChain);
  }

  @override
  toDart(Pointer<clib.CWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CWallet c) {
    if (c == null) {
      return;
    }
    id = fromUtf8Null(c.id);
    nextId = fromUtf8Null(c.nextId);
    name = fromUtf8Null(c.name);
    walletType = fromUtf8Null(c.walletType);
    ethChain = new EthChain();
    ethChain.toDart(c.ethChain);
    eeeChain = new EeeChain();
    eeeChain.toDart(c.eeeChain);
    btcChain = new BtcChain();
    btcChain.toDart(c.btcChain);
  }
}

class WalletTokenStatus extends DC<clib.CWalletTokenStatus> {
  String walletId;
  String chainType;
  String tokenId;
  int isShow;

  static freeInstance(clib.CWalletTokenStatus instance) {
    if (instance == null) {
      return;
    }
    if (instance.walletId != null && instance.walletId != nullptr) {
      ffi.calloc.free(instance.walletId);
    }
    instance.walletId = nullptr;
    if (instance.chainType != null && instance.chainType != nullptr) {
      ffi.calloc.free(instance.chainType);
    }
    instance.chainType = nullptr;
    if (instance.tokenId != null && instance.tokenId != nullptr) {
      ffi.calloc.free(instance.tokenId);
    }
    instance.tokenId = nullptr;
  }

  static free(Pointer<clib.CWalletTokenStatus> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }

  static WalletTokenStatus fromC(Pointer<clib.CWalletTokenStatus> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new WalletTokenStatus();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWalletTokenStatus> toCPtr() {
    var ptr = allocateZero<clib.CWalletTokenStatus>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CWalletTokenStatus> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }

  @override
  toCInstance(clib.CWalletTokenStatus c) {
    if (c == null) {
      return;
    }
    if (c.walletId != null && c.walletId != nullptr) {
      ffi.calloc.free(c.walletId);
    }
    c.walletId = toUtf8Null(walletId);
    if (c.chainType != null && c.chainType != nullptr) {
      ffi.calloc.free(c.chainType);
    }
    c.chainType = toUtf8Null(chainType);
    if (c.tokenId != null && c.tokenId != nullptr) {
      ffi.calloc.free(c.tokenId);
    }
    c.tokenId = toUtf8Null(tokenId);
    c.isShow = isShow;
  }

  @override
  toDart(Pointer<clib.CWalletTokenStatus> c) {
    if (c == null || c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CWalletTokenStatus c) {
    if (c == null) {
      return;
    }
    walletId = fromUtf8Null(c.walletId);
    chainType = fromUtf8Null(c.chainType);
    tokenId = fromUtf8Null(c.tokenId);
    isShow = c.isShow;
  }
}
