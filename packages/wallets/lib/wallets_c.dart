/// bindings for `wallets_cdl`
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;
// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
/// Reference to the Dynamic Library, it should be only used for low-level access
final DynamicLibrary dl = _dl;
DynamicLibrary _open() {
  if (Platform.isWindows) return DynamicLibrary.open('wallets_cdl.dll');
  if (Platform.isLinux) return DynamicLibrary.open('libwallets_cdl.so');
  if (Platform.isAndroid) return DynamicLibrary.open('libwallets_cdl.so');
  throw UnsupportedError('This platform is not supported.');
}
/// C struct `CAccountInfo`.
class CAccountInfo extends Struct {
  @Uint32()
  int nonce;
  @Uint32()
  int refCount;
  Pointer<ffi.Utf8> freeBalance;
  Pointer<ffi.Utf8> reserved;
  Pointer<ffi.Utf8> miscFrozen;
  Pointer<ffi.Utf8> feeFrozen;
  static Pointer<CAccountInfo> allocate() {
    return ffi.calloc<CAccountInfo>();
  }
  static CAccountInfo from(int ptr) {
    return Pointer<CAccountInfo>.fromAddress(ptr).ref;
  }
}
/// C struct `CAccountInfoSyncProg`.
class CAccountInfoSyncProg extends Struct {
  Pointer<ffi.Utf8> account;
  Pointer<ffi.Utf8> blockNo;
  Pointer<ffi.Utf8> blockHash;
  static Pointer<CAccountInfoSyncProg> allocate() {
    return ffi.calloc<CAccountInfoSyncProg>();
  }
  static CAccountInfoSyncProg from(int ptr) {
    return Pointer<CAccountInfoSyncProg>.fromAddress(ptr).ref;
  }
}
/// C function `CAccountInfoSyncProg_dAlloc`.
Pointer<Pointer<CAccountInfoSyncProg>> CAccountInfoSyncProg_dAlloc() {
  return _CAccountInfoSyncProg_dAlloc();
}
final _CAccountInfoSyncProg_dAlloc_Dart _CAccountInfoSyncProg_dAlloc = _dl.lookupFunction<_CAccountInfoSyncProg_dAlloc_C, _CAccountInfoSyncProg_dAlloc_Dart>('CAccountInfoSyncProg_dAlloc');
typedef _CAccountInfoSyncProg_dAlloc_C = Pointer<Pointer<CAccountInfoSyncProg>> Function();
typedef _CAccountInfoSyncProg_dAlloc_Dart = Pointer<Pointer<CAccountInfoSyncProg>> Function();
/// C function `CAccountInfoSyncProg_dFree`.
void CAccountInfoSyncProg_dFree(
  Pointer<Pointer<CAccountInfoSyncProg>> dPtr,
) {
  _CAccountInfoSyncProg_dFree(dPtr);
}
final _CAccountInfoSyncProg_dFree_Dart _CAccountInfoSyncProg_dFree = _dl.lookupFunction<_CAccountInfoSyncProg_dFree_C, _CAccountInfoSyncProg_dFree_Dart>('CAccountInfoSyncProg_dFree');
typedef _CAccountInfoSyncProg_dFree_C = Void Function(
  Pointer<Pointer<CAccountInfoSyncProg>> dPtr,
);
typedef _CAccountInfoSyncProg_dFree_Dart = void Function(
  Pointer<Pointer<CAccountInfoSyncProg>> dPtr,
);
/// C function `CAccountInfo_dAlloc`.
Pointer<Pointer<CAccountInfo>> CAccountInfo_dAlloc() {
  return _CAccountInfo_dAlloc();
}
final _CAccountInfo_dAlloc_Dart _CAccountInfo_dAlloc = _dl.lookupFunction<_CAccountInfo_dAlloc_C, _CAccountInfo_dAlloc_Dart>('CAccountInfo_dAlloc');
typedef _CAccountInfo_dAlloc_C = Pointer<Pointer<CAccountInfo>> Function();
typedef _CAccountInfo_dAlloc_Dart = Pointer<Pointer<CAccountInfo>> Function();
/// C function `CAccountInfo_dFree`.
void CAccountInfo_dFree(
  Pointer<Pointer<CAccountInfo>> dPtr,
) {
  _CAccountInfo_dFree(dPtr);
}
final _CAccountInfo_dFree_Dart _CAccountInfo_dFree = _dl.lookupFunction<_CAccountInfo_dFree_C, _CAccountInfo_dFree_Dart>('CAccountInfo_dFree');
typedef _CAccountInfo_dFree_C = Void Function(
  Pointer<Pointer<CAccountInfo>> dPtr,
);
typedef _CAccountInfo_dFree_Dart = void Function(
  Pointer<Pointer<CAccountInfo>> dPtr,
);
/// C struct `CAddress`.
class CAddress extends Struct {
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<ffi.Utf8> address;
  Pointer<ffi.Utf8> publicKey;
  static Pointer<CAddress> allocate() {
    return ffi.calloc<CAddress>();
  }
  static CAddress from(int ptr) {
    return Pointer<CAddress>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCBtcChainToken extends Struct {
  Pointer<CBtcChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCBtcChainToken> allocate() {
    return ffi.calloc<CArrayCBtcChainToken>();
  }
  static CArrayCBtcChainToken from(int ptr) {
    return Pointer<CArrayCBtcChainToken>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCBtcChainTokenAuth extends Struct {
  Pointer<CBtcChainTokenAuth> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCBtcChainTokenAuth> allocate() {
    return ffi.calloc<CArrayCBtcChainTokenAuth>();
  }
  static CArrayCBtcChainTokenAuth from(int ptr) {
    return Pointer<CArrayCBtcChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCBtcChainTokenAuth_dAlloc`.
Pointer<Pointer<CArrayCBtcChainTokenAuth>> CArrayCBtcChainTokenAuth_dAlloc() {
  return _CArrayCBtcChainTokenAuth_dAlloc();
}
final _CArrayCBtcChainTokenAuth_dAlloc_Dart _CArrayCBtcChainTokenAuth_dAlloc = _dl.lookupFunction<_CArrayCBtcChainTokenAuth_dAlloc_C, _CArrayCBtcChainTokenAuth_dAlloc_Dart>('CArrayCBtcChainTokenAuth_dAlloc');
typedef _CArrayCBtcChainTokenAuth_dAlloc_C = Pointer<Pointer<CArrayCBtcChainTokenAuth>> Function();
typedef _CArrayCBtcChainTokenAuth_dAlloc_Dart = Pointer<Pointer<CArrayCBtcChainTokenAuth>> Function();
/// C function `CArrayCBtcChainTokenAuth_dFree`.
void CArrayCBtcChainTokenAuth_dFree(
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> dPtr,
) {
  _CArrayCBtcChainTokenAuth_dFree(dPtr);
}
final _CArrayCBtcChainTokenAuth_dFree_Dart _CArrayCBtcChainTokenAuth_dFree = _dl.lookupFunction<_CArrayCBtcChainTokenAuth_dFree_C, _CArrayCBtcChainTokenAuth_dFree_Dart>('CArrayCBtcChainTokenAuth_dFree');
typedef _CArrayCBtcChainTokenAuth_dFree_C = Void Function(
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> dPtr,
);
typedef _CArrayCBtcChainTokenAuth_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCBtcChainTokenDefault extends Struct {
  Pointer<CBtcChainTokenDefault> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCBtcChainTokenDefault> allocate() {
    return ffi.calloc<CArrayCBtcChainTokenDefault>();
  }
  static CArrayCBtcChainTokenDefault from(int ptr) {
    return Pointer<CArrayCBtcChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCBtcChainTokenDefault_dAlloc`.
Pointer<Pointer<CArrayCBtcChainTokenDefault>> CArrayCBtcChainTokenDefault_dAlloc() {
  return _CArrayCBtcChainTokenDefault_dAlloc();
}
final _CArrayCBtcChainTokenDefault_dAlloc_Dart _CArrayCBtcChainTokenDefault_dAlloc = _dl.lookupFunction<_CArrayCBtcChainTokenDefault_dAlloc_C, _CArrayCBtcChainTokenDefault_dAlloc_Dart>('CArrayCBtcChainTokenDefault_dAlloc');
typedef _CArrayCBtcChainTokenDefault_dAlloc_C = Pointer<Pointer<CArrayCBtcChainTokenDefault>> Function();
typedef _CArrayCBtcChainTokenDefault_dAlloc_Dart = Pointer<Pointer<CArrayCBtcChainTokenDefault>> Function();
/// C function `CArrayCBtcChainTokenDefault_dFree`.
void CArrayCBtcChainTokenDefault_dFree(
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> dPtr,
) {
  _CArrayCBtcChainTokenDefault_dFree(dPtr);
}
final _CArrayCBtcChainTokenDefault_dFree_Dart _CArrayCBtcChainTokenDefault_dFree = _dl.lookupFunction<_CArrayCBtcChainTokenDefault_dFree_C, _CArrayCBtcChainTokenDefault_dFree_Dart>('CArrayCBtcChainTokenDefault_dFree');
typedef _CArrayCBtcChainTokenDefault_dFree_C = Void Function(
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> dPtr,
);
typedef _CArrayCBtcChainTokenDefault_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCChar extends Struct {
  Pointer<Pointer<ffi.Utf8>> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCChar> allocate() {
    return ffi.calloc<CArrayCChar>();
  }
  static CArrayCChar from(int ptr) {
    return Pointer<CArrayCChar>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCChar_dAlloc`.
Pointer<Pointer<CArrayCChar>> CArrayCChar_dAlloc() {
  return _CArrayCChar_dAlloc();
}
final _CArrayCChar_dAlloc_Dart _CArrayCChar_dAlloc = _dl.lookupFunction<_CArrayCChar_dAlloc_C, _CArrayCChar_dAlloc_Dart>('CArrayCChar_dAlloc');
typedef _CArrayCChar_dAlloc_C = Pointer<Pointer<CArrayCChar>> Function();
typedef _CArrayCChar_dAlloc_Dart = Pointer<Pointer<CArrayCChar>> Function();
/// C function `CArrayCChar_dFree`.
void CArrayCChar_dFree(
  Pointer<Pointer<CArrayCChar>> dPtr,
) {
  _CArrayCChar_dFree(dPtr);
}
final _CArrayCChar_dFree_Dart _CArrayCChar_dFree = _dl.lookupFunction<_CArrayCChar_dFree_C, _CArrayCChar_dFree_Dart>('CArrayCChar_dFree');
typedef _CArrayCChar_dFree_C = Void Function(
  Pointer<Pointer<CArrayCChar>> dPtr,
);
typedef _CArrayCChar_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCChar>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCContext extends Struct {
  Pointer<CContext> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCContext> allocate() {
    return ffi.calloc<CArrayCContext>();
  }
  static CArrayCContext from(int ptr) {
    return Pointer<CArrayCContext>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> alloc ** [CArray]</p>
Pointer<Pointer<CArrayCContext>> CArrayCContext_dAlloc() {
  return _CArrayCContext_dAlloc();
}
final _CArrayCContext_dAlloc_Dart _CArrayCContext_dAlloc = _dl.lookupFunction<_CArrayCContext_dAlloc_C, _CArrayCContext_dAlloc_Dart>('CArrayCContext_dAlloc');
typedef _CArrayCContext_dAlloc_C = Pointer<Pointer<CArrayCContext>> Function();
typedef _CArrayCContext_dAlloc_Dart = Pointer<Pointer<CArrayCContext>> Function();
/// C function `CArrayCContext_dFree`.
void CArrayCContext_dFree(
  Pointer<Pointer<CArrayCContext>> dPtr,
) {
  _CArrayCContext_dFree(dPtr);
}
final _CArrayCContext_dFree_Dart _CArrayCContext_dFree = _dl.lookupFunction<_CArrayCContext_dFree_C, _CArrayCContext_dFree_Dart>('CArrayCContext_dFree');
typedef _CArrayCContext_dFree_C = Void Function(
  Pointer<Pointer<CArrayCContext>> dPtr,
);
typedef _CArrayCContext_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCContext>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEeeChainToken extends Struct {
  Pointer<CEeeChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEeeChainToken> allocate() {
    return ffi.calloc<CArrayCEeeChainToken>();
  }
  static CArrayCEeeChainToken from(int ptr) {
    return Pointer<CArrayCEeeChainToken>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEeeChainTokenAuth extends Struct {
  Pointer<CEeeChainTokenAuth> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEeeChainTokenAuth> allocate() {
    return ffi.calloc<CArrayCEeeChainTokenAuth>();
  }
  static CArrayCEeeChainTokenAuth from(int ptr) {
    return Pointer<CArrayCEeeChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCEeeChainTokenAuth_dAlloc`.
Pointer<Pointer<CArrayCEeeChainTokenAuth>> CArrayCEeeChainTokenAuth_dAlloc() {
  return _CArrayCEeeChainTokenAuth_dAlloc();
}
final _CArrayCEeeChainTokenAuth_dAlloc_Dart _CArrayCEeeChainTokenAuth_dAlloc = _dl.lookupFunction<_CArrayCEeeChainTokenAuth_dAlloc_C, _CArrayCEeeChainTokenAuth_dAlloc_Dart>('CArrayCEeeChainTokenAuth_dAlloc');
typedef _CArrayCEeeChainTokenAuth_dAlloc_C = Pointer<Pointer<CArrayCEeeChainTokenAuth>> Function();
typedef _CArrayCEeeChainTokenAuth_dAlloc_Dart = Pointer<Pointer<CArrayCEeeChainTokenAuth>> Function();
/// C function `CArrayCEeeChainTokenAuth_dFree`.
void CArrayCEeeChainTokenAuth_dFree(
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> dPtr,
) {
  _CArrayCEeeChainTokenAuth_dFree(dPtr);
}
final _CArrayCEeeChainTokenAuth_dFree_Dart _CArrayCEeeChainTokenAuth_dFree = _dl.lookupFunction<_CArrayCEeeChainTokenAuth_dFree_C, _CArrayCEeeChainTokenAuth_dFree_Dart>('CArrayCEeeChainTokenAuth_dFree');
typedef _CArrayCEeeChainTokenAuth_dFree_C = Void Function(
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> dPtr,
);
typedef _CArrayCEeeChainTokenAuth_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEeeChainTokenDefault extends Struct {
  Pointer<CEeeChainTokenDefault> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEeeChainTokenDefault> allocate() {
    return ffi.calloc<CArrayCEeeChainTokenDefault>();
  }
  static CArrayCEeeChainTokenDefault from(int ptr) {
    return Pointer<CArrayCEeeChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCEeeChainTokenDefault_dAlloc`.
Pointer<Pointer<CArrayCEeeChainTokenDefault>> CArrayCEeeChainTokenDefault_dAlloc() {
  return _CArrayCEeeChainTokenDefault_dAlloc();
}
final _CArrayCEeeChainTokenDefault_dAlloc_Dart _CArrayCEeeChainTokenDefault_dAlloc = _dl.lookupFunction<_CArrayCEeeChainTokenDefault_dAlloc_C, _CArrayCEeeChainTokenDefault_dAlloc_Dart>('CArrayCEeeChainTokenDefault_dAlloc');
typedef _CArrayCEeeChainTokenDefault_dAlloc_C = Pointer<Pointer<CArrayCEeeChainTokenDefault>> Function();
typedef _CArrayCEeeChainTokenDefault_dAlloc_Dart = Pointer<Pointer<CArrayCEeeChainTokenDefault>> Function();
/// C function `CArrayCEeeChainTokenDefault_dFree`.
void CArrayCEeeChainTokenDefault_dFree(
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> dPtr,
) {
  _CArrayCEeeChainTokenDefault_dFree(dPtr);
}
final _CArrayCEeeChainTokenDefault_dFree_Dart _CArrayCEeeChainTokenDefault_dFree = _dl.lookupFunction<_CArrayCEeeChainTokenDefault_dFree_C, _CArrayCEeeChainTokenDefault_dFree_Dart>('CArrayCEeeChainTokenDefault_dFree');
typedef _CArrayCEeeChainTokenDefault_dFree_C = Void Function(
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> dPtr,
);
typedef _CArrayCEeeChainTokenDefault_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEeeChainTx extends Struct {
  Pointer<CEeeChainTx> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEeeChainTx> allocate() {
    return ffi.calloc<CArrayCEeeChainTx>();
  }
  static CArrayCEeeChainTx from(int ptr) {
    return Pointer<CArrayCEeeChainTx>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCEeeChainTx_dAlloc`.
Pointer<Pointer<CArrayCEeeChainTx>> CArrayCEeeChainTx_dAlloc() {
  return _CArrayCEeeChainTx_dAlloc();
}
final _CArrayCEeeChainTx_dAlloc_Dart _CArrayCEeeChainTx_dAlloc = _dl.lookupFunction<_CArrayCEeeChainTx_dAlloc_C, _CArrayCEeeChainTx_dAlloc_Dart>('CArrayCEeeChainTx_dAlloc');
typedef _CArrayCEeeChainTx_dAlloc_C = Pointer<Pointer<CArrayCEeeChainTx>> Function();
typedef _CArrayCEeeChainTx_dAlloc_Dart = Pointer<Pointer<CArrayCEeeChainTx>> Function();
/// C function `CArrayCEeeChainTx_dFree`.
void CArrayCEeeChainTx_dFree(
  Pointer<Pointer<CArrayCEeeChainTx>> dPtr,
) {
  _CArrayCEeeChainTx_dFree(dPtr);
}
final _CArrayCEeeChainTx_dFree_Dart _CArrayCEeeChainTx_dFree = _dl.lookupFunction<_CArrayCEeeChainTx_dFree_C, _CArrayCEeeChainTx_dFree_Dart>('CArrayCEeeChainTx_dFree');
typedef _CArrayCEeeChainTx_dFree_C = Void Function(
  Pointer<Pointer<CArrayCEeeChainTx>> dPtr,
);
typedef _CArrayCEeeChainTx_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCEeeChainTx>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEthChainToken extends Struct {
  Pointer<CEthChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEthChainToken> allocate() {
    return ffi.calloc<CArrayCEthChainToken>();
  }
  static CArrayCEthChainToken from(int ptr) {
    return Pointer<CArrayCEthChainToken>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEthChainTokenAuth extends Struct {
  Pointer<CEthChainTokenAuth> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEthChainTokenAuth> allocate() {
    return ffi.calloc<CArrayCEthChainTokenAuth>();
  }
  static CArrayCEthChainTokenAuth from(int ptr) {
    return Pointer<CArrayCEthChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCEthChainTokenAuth_dAlloc`.
Pointer<Pointer<CArrayCEthChainTokenAuth>> CArrayCEthChainTokenAuth_dAlloc() {
  return _CArrayCEthChainTokenAuth_dAlloc();
}
final _CArrayCEthChainTokenAuth_dAlloc_Dart _CArrayCEthChainTokenAuth_dAlloc = _dl.lookupFunction<_CArrayCEthChainTokenAuth_dAlloc_C, _CArrayCEthChainTokenAuth_dAlloc_Dart>('CArrayCEthChainTokenAuth_dAlloc');
typedef _CArrayCEthChainTokenAuth_dAlloc_C = Pointer<Pointer<CArrayCEthChainTokenAuth>> Function();
typedef _CArrayCEthChainTokenAuth_dAlloc_Dart = Pointer<Pointer<CArrayCEthChainTokenAuth>> Function();
/// C function `CArrayCEthChainTokenAuth_dFree`.
void CArrayCEthChainTokenAuth_dFree(
  Pointer<Pointer<CArrayCEthChainTokenAuth>> dPtr,
) {
  _CArrayCEthChainTokenAuth_dFree(dPtr);
}
final _CArrayCEthChainTokenAuth_dFree_Dart _CArrayCEthChainTokenAuth_dFree = _dl.lookupFunction<_CArrayCEthChainTokenAuth_dFree_C, _CArrayCEthChainTokenAuth_dFree_Dart>('CArrayCEthChainTokenAuth_dFree');
typedef _CArrayCEthChainTokenAuth_dFree_C = Void Function(
  Pointer<Pointer<CArrayCEthChainTokenAuth>> dPtr,
);
typedef _CArrayCEthChainTokenAuth_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCEthChainTokenAuth>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEthChainTokenDefault extends Struct {
  Pointer<CEthChainTokenDefault> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEthChainTokenDefault> allocate() {
    return ffi.calloc<CArrayCEthChainTokenDefault>();
  }
  static CArrayCEthChainTokenDefault from(int ptr) {
    return Pointer<CArrayCEthChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCEthChainTokenDefault_dAlloc`.
Pointer<Pointer<CArrayCEthChainTokenDefault>> CArrayCEthChainTokenDefault_dAlloc() {
  return _CArrayCEthChainTokenDefault_dAlloc();
}
final _CArrayCEthChainTokenDefault_dAlloc_Dart _CArrayCEthChainTokenDefault_dAlloc = _dl.lookupFunction<_CArrayCEthChainTokenDefault_dAlloc_C, _CArrayCEthChainTokenDefault_dAlloc_Dart>('CArrayCEthChainTokenDefault_dAlloc');
typedef _CArrayCEthChainTokenDefault_dAlloc_C = Pointer<Pointer<CArrayCEthChainTokenDefault>> Function();
typedef _CArrayCEthChainTokenDefault_dAlloc_Dart = Pointer<Pointer<CArrayCEthChainTokenDefault>> Function();
/// C function `CArrayCEthChainTokenDefault_dFree`.
void CArrayCEthChainTokenDefault_dFree(
  Pointer<Pointer<CArrayCEthChainTokenDefault>> dPtr,
) {
  _CArrayCEthChainTokenDefault_dFree(dPtr);
}
final _CArrayCEthChainTokenDefault_dFree_Dart _CArrayCEthChainTokenDefault_dFree = _dl.lookupFunction<_CArrayCEthChainTokenDefault_dFree_C, _CArrayCEthChainTokenDefault_dFree_Dart>('CArrayCEthChainTokenDefault_dFree');
typedef _CArrayCEthChainTokenDefault_dFree_C = Void Function(
  Pointer<Pointer<CArrayCEthChainTokenDefault>> dPtr,
);
typedef _CArrayCEthChainTokenDefault_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCEthChainTokenDefault>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCExtrinsicContext extends Struct {
  Pointer<CExtrinsicContext> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCExtrinsicContext> allocate() {
    return ffi.calloc<CArrayCExtrinsicContext>();
  }
  static CArrayCExtrinsicContext from(int ptr) {
    return Pointer<CArrayCExtrinsicContext>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCTokenAddress extends Struct {
  Pointer<CTokenAddress> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCTokenAddress> allocate() {
    return ffi.calloc<CArrayCTokenAddress>();
  }
  static CArrayCTokenAddress from(int ptr) {
    return Pointer<CArrayCTokenAddress>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCTokenAddress_dAlloc`.
Pointer<Pointer<CArrayCTokenAddress>> CArrayCTokenAddress_dAlloc() {
  return _CArrayCTokenAddress_dAlloc();
}
final _CArrayCTokenAddress_dAlloc_Dart _CArrayCTokenAddress_dAlloc = _dl.lookupFunction<_CArrayCTokenAddress_dAlloc_C, _CArrayCTokenAddress_dAlloc_Dart>('CArrayCTokenAddress_dAlloc');
typedef _CArrayCTokenAddress_dAlloc_C = Pointer<Pointer<CArrayCTokenAddress>> Function();
typedef _CArrayCTokenAddress_dAlloc_Dart = Pointer<Pointer<CArrayCTokenAddress>> Function();
/// C function `CArrayCTokenAddress_dFree`.
void CArrayCTokenAddress_dFree(
  Pointer<Pointer<CArrayCTokenAddress>> dPtr,
) {
  _CArrayCTokenAddress_dFree(dPtr);
}
final _CArrayCTokenAddress_dFree_Dart _CArrayCTokenAddress_dFree = _dl.lookupFunction<_CArrayCTokenAddress_dFree_C, _CArrayCTokenAddress_dFree_Dart>('CArrayCTokenAddress_dFree');
typedef _CArrayCTokenAddress_dFree_C = Void Function(
  Pointer<Pointer<CArrayCTokenAddress>> dPtr,
);
typedef _CArrayCTokenAddress_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCTokenAddress>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCWallet extends Struct {
  Pointer<CWallet> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCWallet> allocate() {
    return ffi.calloc<CArrayCWallet>();
  }
  static CArrayCWallet from(int ptr) {
    return Pointer<CArrayCWallet>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayCWallet_dAlloc`.
Pointer<Pointer<CArrayCWallet>> CArrayCWallet_dAlloc() {
  return _CArrayCWallet_dAlloc();
}
final _CArrayCWallet_dAlloc_Dart _CArrayCWallet_dAlloc = _dl.lookupFunction<_CArrayCWallet_dAlloc_C, _CArrayCWallet_dAlloc_Dart>('CArrayCWallet_dAlloc');
typedef _CArrayCWallet_dAlloc_C = Pointer<Pointer<CArrayCWallet>> Function();
typedef _CArrayCWallet_dAlloc_Dart = Pointer<Pointer<CArrayCWallet>> Function();
/// C function `CArrayCWallet_dFree`.
void CArrayCWallet_dFree(
  Pointer<Pointer<CArrayCWallet>> dPtr,
) {
  _CArrayCWallet_dFree(dPtr);
}
final _CArrayCWallet_dFree_Dart _CArrayCWallet_dFree = _dl.lookupFunction<_CArrayCWallet_dFree_C, _CArrayCWallet_dFree_Dart>('CArrayCWallet_dFree');
typedef _CArrayCWallet_dFree_C = Void Function(
  Pointer<Pointer<CArrayCWallet>> dPtr,
);
typedef _CArrayCWallet_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCWallet>> dPtr,
);
/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayI64 extends Struct {
  Pointer<Int64> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayI64> allocate() {
    return ffi.calloc<CArrayI64>();
  }
  static CArrayI64 from(int ptr) {
    return Pointer<CArrayI64>.fromAddress(ptr).ref;
  }
}
/// C function `CArrayInt64_dAlloc`.
Pointer<Pointer<CArrayI64>> CArrayInt64_dAlloc() {
  return _CArrayInt64_dAlloc();
}
final _CArrayInt64_dAlloc_Dart _CArrayInt64_dAlloc = _dl.lookupFunction<_CArrayInt64_dAlloc_C, _CArrayInt64_dAlloc_Dart>('CArrayInt64_dAlloc');
typedef _CArrayInt64_dAlloc_C = Pointer<Pointer<CArrayI64>> Function();
typedef _CArrayInt64_dAlloc_Dart = Pointer<Pointer<CArrayI64>> Function();
/// C function `CArrayInt64_dFree`.
void CArrayInt64_dFree(
  Pointer<Pointer<CArrayI64>> dPtr,
) {
  _CArrayInt64_dFree(dPtr);
}
final _CArrayInt64_dFree_Dart _CArrayInt64_dFree = _dl.lookupFunction<_CArrayInt64_dFree_C, _CArrayInt64_dFree_Dart>('CArrayInt64_dFree');
typedef _CArrayInt64_dFree_C = Void Function(
  Pointer<Pointer<CArrayI64>> dPtr,
);
typedef _CArrayInt64_dFree_Dart = void Function(
  Pointer<Pointer<CArrayI64>> dPtr,
);
/// C function `CBool_dAlloc`.
Pointer<Pointer<Uint32>> CBool_dAlloc() {
  return _CBool_dAlloc();
}
final _CBool_dAlloc_Dart _CBool_dAlloc = _dl.lookupFunction<_CBool_dAlloc_C, _CBool_dAlloc_Dart>('CBool_dAlloc');
typedef _CBool_dAlloc_C = Pointer<Pointer<Uint32>> Function();
typedef _CBool_dAlloc_Dart = Pointer<Pointer<Uint32>> Function();
/// C function `CBool_dFree`.
void CBool_dFree(
  Pointer<Pointer<Uint32>> dcs,
) {
  _CBool_dFree(dcs);
}
final _CBool_dFree_Dart _CBool_dFree = _dl.lookupFunction<_CBool_dFree_C, _CBool_dFree_Dart>('CBool_dFree');
typedef _CBool_dFree_C = Void Function(
  Pointer<Pointer<Uint32>> dcs,
);
typedef _CBool_dFree_Dart = void Function(
  Pointer<Pointer<Uint32>> dcs,
);
/// C struct `CBtcChain`.
class CBtcChain extends Struct {
  Pointer<CChainShared> chainShared;
  Pointer<CArrayCBtcChainToken> tokens;
  static Pointer<CBtcChain> allocate() {
    return ffi.calloc<CBtcChain>();
  }
  static CBtcChain from(int ptr) {
    return Pointer<CBtcChain>.fromAddress(ptr).ref;
  }
}
/// C struct `CBtcChainToken`.
class CBtcChainToken extends Struct {
  @Int32()
  int show;
  Pointer<CBtcChainTokenShared> btcChainTokenShared;
  static Pointer<CBtcChainToken> allocate() {
    return ffi.calloc<CBtcChainToken>();
  }
  static CBtcChainToken from(int ptr) {
    return Pointer<CBtcChainToken>.fromAddress(ptr).ref;
  }
}
/// C struct `CBtcChainTokenAuth`.
class CBtcChainTokenAuth extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<CBtcChainTokenShared> btcChainTokenShared;
  static Pointer<CBtcChainTokenAuth> allocate() {
    return ffi.calloc<CBtcChainTokenAuth>();
  }
  static CBtcChainTokenAuth from(int ptr) {
    return Pointer<CBtcChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C struct `CBtcChainTokenDefault`.
class CBtcChainTokenDefault extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<CBtcChainTokenShared> btcChainTokenShared;
  static Pointer<CBtcChainTokenDefault> allocate() {
    return ffi.calloc<CBtcChainTokenDefault>();
  }
  static CBtcChainTokenDefault from(int ptr) {
    return Pointer<CBtcChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C struct `CBtcChainTokenShared`.
class CBtcChainTokenShared extends Struct {
  Pointer<CTokenShared> tokenShared;
  Pointer<ffi.Utf8> tokenType;
  @Int64()
  int gas;
  @Int32()
  int decimal;
  static Pointer<CBtcChainTokenShared> allocate() {
    return ffi.calloc<CBtcChainTokenShared>();
  }
  static CBtcChainTokenShared from(int ptr) {
    return Pointer<CBtcChainTokenShared>.fromAddress(ptr).ref;
  }
}
/// C struct `CChainShared`.
class CChainShared extends Struct {
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<CAddress> walletAddress;
  static Pointer<CChainShared> allocate() {
    return ffi.calloc<CChainShared>();
  }
  static CChainShared from(int ptr) {
    return Pointer<CChainShared>.fromAddress(ptr).ref;
  }
}
/// C struct `CChainVersion`.
class CChainVersion extends Struct {
  Pointer<ffi.Utf8> genesisHash;
  @Int32()
  int runtimeVersion;
  @Int32()
  int txVersion;
  static Pointer<CChainVersion> allocate() {
    return ffi.calloc<CChainVersion>();
  }
  static CChainVersion from(int ptr) {
    return Pointer<CChainVersion>.fromAddress(ptr).ref;
  }
}
/// C struct `CContext`.
class CContext extends Struct {
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> contextNote;
  static Pointer<CContext> allocate() {
    return ffi.calloc<CContext>();
  }
  static CContext from(int ptr) {
    return Pointer<CContext>.fromAddress(ptr).ref;
  }
}
/// <p class="para-brief"> alloc ** [parameters::CContext]</p>
Pointer<Pointer<CContext>> CContext_dAlloc() {
  return _CContext_dAlloc();
}
final _CContext_dAlloc_Dart _CContext_dAlloc = _dl.lookupFunction<_CContext_dAlloc_C, _CContext_dAlloc_Dart>('CContext_dAlloc');
typedef _CContext_dAlloc_C = Pointer<Pointer<CContext>> Function();
typedef _CContext_dAlloc_Dart = Pointer<Pointer<CContext>> Function();
/// <p class="para-brief"> free ** [parameters::CContext]</p>
void CContext_dFree(
  Pointer<Pointer<CContext>> dPtr,
) {
  _CContext_dFree(dPtr);
}
final _CContext_dFree_Dart _CContext_dFree = _dl.lookupFunction<_CContext_dFree_C, _CContext_dFree_Dart>('CContext_dFree');
typedef _CContext_dFree_C = Void Function(
  Pointer<Pointer<CContext>> dPtr,
);
typedef _CContext_dFree_Dart = void Function(
  Pointer<Pointer<CContext>> dPtr,
);
/// C struct `CCreateWalletParameters`.
class CCreateWalletParameters extends Struct {
  Pointer<ffi.Utf8> name;
  Pointer<ffi.Utf8> password;
  Pointer<ffi.Utf8> mnemonic;
  Pointer<ffi.Utf8> walletType;
  static Pointer<CCreateWalletParameters> allocate() {
    return ffi.calloc<CCreateWalletParameters>();
  }
  static CCreateWalletParameters from(int ptr) {
    return Pointer<CCreateWalletParameters>.fromAddress(ptr).ref;
  }
}
/// C struct `CDbName`.
class CDbName extends Struct {
  Pointer<ffi.Utf8> path;
  Pointer<ffi.Utf8> prefix;
  Pointer<ffi.Utf8> cashboxWallets;
  Pointer<ffi.Utf8> cashboxMnemonic;
  Pointer<ffi.Utf8> walletMainnet;
  Pointer<ffi.Utf8> walletPrivate;
  Pointer<ffi.Utf8> walletTestnet;
  Pointer<ffi.Utf8> walletTestnetPrivate;
  static Pointer<CDbName> allocate() {
    return ffi.calloc<CDbName>();
  }
  static CDbName from(int ptr) {
    return Pointer<CDbName>.fromAddress(ptr).ref;
  }
}
/// C function `CDbName_dAlloc`.
Pointer<Pointer<CDbName>> CDbName_dAlloc() {
  return _CDbName_dAlloc();
}
final _CDbName_dAlloc_Dart _CDbName_dAlloc = _dl.lookupFunction<_CDbName_dAlloc_C, _CDbName_dAlloc_Dart>('CDbName_dAlloc');
typedef _CDbName_dAlloc_C = Pointer<Pointer<CDbName>> Function();
typedef _CDbName_dAlloc_Dart = Pointer<Pointer<CDbName>> Function();
/// C function `CDbName_dFree`.
void CDbName_dFree(
  Pointer<Pointer<CDbName>> dPtr,
) {
  _CDbName_dFree(dPtr);
}
final _CDbName_dFree_Dart _CDbName_dFree = _dl.lookupFunction<_CDbName_dFree_C, _CDbName_dFree_Dart>('CDbName_dFree');
typedef _CDbName_dFree_C = Void Function(
  Pointer<Pointer<CDbName>> dPtr,
);
typedef _CDbName_dFree_Dart = void Function(
  Pointer<Pointer<CDbName>> dPtr,
);
/// C struct `CDecodeAccountInfoParameters`.
class CDecodeAccountInfoParameters extends Struct {
  Pointer<ffi.Utf8> encodeData;
  Pointer<CChainVersion> chainVersion;
  static Pointer<CDecodeAccountInfoParameters> allocate() {
    return ffi.calloc<CDecodeAccountInfoParameters>();
  }
  static CDecodeAccountInfoParameters from(int ptr) {
    return Pointer<CDecodeAccountInfoParameters>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChain`.
class CEeeChain extends Struct {
  Pointer<CChainShared> chainShared;
  Pointer<CArrayCEeeChainToken> tokens;
  static Pointer<CEeeChain> allocate() {
    return ffi.calloc<CEeeChain>();
  }
  static CEeeChain from(int ptr) {
    return Pointer<CEeeChain>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChainToken`.
class CEeeChainToken extends Struct {
  @Int32()
  int show;
  Pointer<CEeeChainTokenShared> eeeChainTokenShared;
  static Pointer<CEeeChainToken> allocate() {
    return ffi.calloc<CEeeChainToken>();
  }
  static CEeeChainToken from(int ptr) {
    return Pointer<CEeeChainToken>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChainTokenAuth`.
class CEeeChainTokenAuth extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<CEeeChainTokenShared> eeeChainTokenShared;
  static Pointer<CEeeChainTokenAuth> allocate() {
    return ffi.calloc<CEeeChainTokenAuth>();
  }
  static CEeeChainTokenAuth from(int ptr) {
    return Pointer<CEeeChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChainTokenDefault`.
class CEeeChainTokenDefault extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<CEeeChainTokenShared> eeeChainTokenShared;
  static Pointer<CEeeChainTokenDefault> allocate() {
    return ffi.calloc<CEeeChainTokenDefault>();
  }
  static CEeeChainTokenDefault from(int ptr) {
    return Pointer<CEeeChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChainTokenShared`.
class CEeeChainTokenShared extends Struct {
  Pointer<CTokenShared> tokenShared;
  Pointer<ffi.Utf8> tokenType;
  @Int64()
  int gasLimit;
  Pointer<ffi.Utf8> gasPrice;
  @Int32()
  int decimal;
  static Pointer<CEeeChainTokenShared> allocate() {
    return ffi.calloc<CEeeChainTokenShared>();
  }
  static CEeeChainTokenShared from(int ptr) {
    return Pointer<CEeeChainTokenShared>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeChainTx`.
class CEeeChainTx extends Struct {
  Pointer<ffi.Utf8> txHash;
  Pointer<ffi.Utf8> blockHash;
  Pointer<ffi.Utf8> blockNumber;
  Pointer<ffi.Utf8> signer;
  Pointer<ffi.Utf8> walletAccount;
  Pointer<ffi.Utf8> fromAddress;
  Pointer<ffi.Utf8> toAddress;
  Pointer<ffi.Utf8> value;
  Pointer<ffi.Utf8> extension;
  @Int32()
  int status;
  @Int64()
  int txTimestamp;
  Pointer<ffi.Utf8> txBytes;
  static Pointer<CEeeChainTx> allocate() {
    return ffi.calloc<CEeeChainTx>();
  }
  static CEeeChainTx from(int ptr) {
    return Pointer<CEeeChainTx>.fromAddress(ptr).ref;
  }
}
/// C struct `CEeeTransferPayload`.
class CEeeTransferPayload extends Struct {
  Pointer<ffi.Utf8> fromAccount;
  Pointer<ffi.Utf8> toAccount;
  Pointer<ffi.Utf8> value;
  @Uint32()
  int index;
  Pointer<CChainVersion> chainVersion;
  Pointer<ffi.Utf8> extData;
  Pointer<ffi.Utf8> password;
  static Pointer<CEeeTransferPayload> allocate() {
    return ffi.calloc<CEeeTransferPayload>();
  }
  static CEeeTransferPayload from(int ptr) {
    return Pointer<CEeeTransferPayload>.fromAddress(ptr).ref;
  }
}
/// C struct `CError`.
class CError extends Struct {
  @Uint64()
  int code;
  Pointer<ffi.Utf8> message;
  static Pointer<CError> allocate() {
    return ffi.calloc<CError>();
  }
  static CError from(int ptr) {
    return Pointer<CError>.fromAddress(ptr).ref;
  }
}
/// C function `CError_free`.
void CError_free(
  Pointer<CError> error,
) {
  _CError_free(error);
}
final _CError_free_Dart _CError_free = _dl.lookupFunction<_CError_free_C, _CError_free_Dart>('CError_free');
typedef _CError_free_C = Void Function(
  Pointer<CError> error,
);
typedef _CError_free_Dart = void Function(
  Pointer<CError> error,
);
/// C struct `CEthChain`.
class CEthChain extends Struct {
  Pointer<CChainShared> chainShared;
  Pointer<CArrayCEthChainToken> tokens;
  static Pointer<CEthChain> allocate() {
    return ffi.calloc<CEthChain>();
  }
  static CEthChain from(int ptr) {
    return Pointer<CEthChain>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthChainToken`.
class CEthChainToken extends Struct {
  @Int32()
  int show;
  Pointer<CEthChainTokenShared> ethChainTokenShared;
  static Pointer<CEthChainToken> allocate() {
    return ffi.calloc<CEthChainToken>();
  }
  static CEthChainToken from(int ptr) {
    return Pointer<CEthChainToken>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthChainTokenAuth`.
class CEthChainTokenAuth extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<ffi.Utf8> contractAddress;
  Pointer<CEthChainTokenShared> ethChainTokenShared;
  static Pointer<CEthChainTokenAuth> allocate() {
    return ffi.calloc<CEthChainTokenAuth>();
  }
  static CEthChainTokenAuth from(int ptr) {
    return Pointer<CEthChainTokenAuth>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthChainTokenDefault`.
class CEthChainTokenDefault extends Struct {
  Pointer<ffi.Utf8> chainTokenSharedId;
  Pointer<ffi.Utf8> netType;
  @Int64()
  int position;
  Pointer<ffi.Utf8> contractAddress;
  Pointer<CEthChainTokenShared> ethChainTokenShared;
  static Pointer<CEthChainTokenDefault> allocate() {
    return ffi.calloc<CEthChainTokenDefault>();
  }
  static CEthChainTokenDefault from(int ptr) {
    return Pointer<CEthChainTokenDefault>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthChainTokenShared`.
class CEthChainTokenShared extends Struct {
  Pointer<CTokenShared> tokenShared;
  Pointer<ffi.Utf8> tokenType;
  @Int64()
  int gasLimit;
  Pointer<ffi.Utf8> gasPrice;
  @Int32()
  int decimal;
  static Pointer<CEthChainTokenShared> allocate() {
    return ffi.calloc<CEthChainTokenShared>();
  }
  static CEthChainTokenShared from(int ptr) {
    return Pointer<CEthChainTokenShared>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthRawTxPayload`.
class CEthRawTxPayload extends Struct {
  Pointer<ffi.Utf8> fromAddress;
  Pointer<ffi.Utf8> rawTx;
  static Pointer<CEthRawTxPayload> allocate() {
    return ffi.calloc<CEthRawTxPayload>();
  }
  static CEthRawTxPayload from(int ptr) {
    return Pointer<CEthRawTxPayload>.fromAddress(ptr).ref;
  }
}
/// C struct `CEthTransferPayload`.
class CEthTransferPayload extends Struct {
  Pointer<ffi.Utf8> fromAddress;
  Pointer<ffi.Utf8> toAddress;
  Pointer<ffi.Utf8> contractAddress;
  Pointer<ffi.Utf8> value;
  Pointer<ffi.Utf8> nonce;
  Pointer<ffi.Utf8> gasPrice;
  Pointer<ffi.Utf8> gasLimit;
  @Uint32()
  int decimal;
  Pointer<ffi.Utf8> extData;
  static Pointer<CEthTransferPayload> allocate() {
    return ffi.calloc<CEthTransferPayload>();
  }
  static CEthTransferPayload from(int ptr) {
    return Pointer<CEthTransferPayload>.fromAddress(ptr).ref;
  }
}
/// C struct `CExtrinsicContext`.
class CExtrinsicContext extends Struct {
  Pointer<CChainVersion> chainVersion;
  Pointer<ffi.Utf8> account;
  Pointer<ffi.Utf8> blockHash;
  Pointer<ffi.Utf8> blockNumber;
  Pointer<ffi.Utf8> event;
  Pointer<CArrayCChar> extrinsics;
  static Pointer<CExtrinsicContext> allocate() {
    return ffi.calloc<CExtrinsicContext>();
  }
  static CExtrinsicContext from(int ptr) {
    return Pointer<CExtrinsicContext>.fromAddress(ptr).ref;
  }
}
/// C function `CExtrinsicContext_dAlloc`.
Pointer<Pointer<CArrayCExtrinsicContext>> CExtrinsicContext_dAlloc() {
  return _CExtrinsicContext_dAlloc();
}
final _CExtrinsicContext_dAlloc_Dart _CExtrinsicContext_dAlloc = _dl.lookupFunction<_CExtrinsicContext_dAlloc_C, _CExtrinsicContext_dAlloc_Dart>('CExtrinsicContext_dAlloc');
typedef _CExtrinsicContext_dAlloc_C = Pointer<Pointer<CArrayCExtrinsicContext>> Function();
typedef _CExtrinsicContext_dAlloc_Dart = Pointer<Pointer<CArrayCExtrinsicContext>> Function();
/// C function `CExtrinsicContext_dFree`.
void CExtrinsicContext_dFree(
  Pointer<Pointer<CArrayCExtrinsicContext>> dPtr,
) {
  _CExtrinsicContext_dFree(dPtr);
}
final _CExtrinsicContext_dFree_Dart _CExtrinsicContext_dFree = _dl.lookupFunction<_CExtrinsicContext_dFree_C, _CExtrinsicContext_dFree_Dart>('CExtrinsicContext_dFree');
typedef _CExtrinsicContext_dFree_C = Void Function(
  Pointer<Pointer<CArrayCExtrinsicContext>> dPtr,
);
typedef _CExtrinsicContext_dFree_Dart = void Function(
  Pointer<Pointer<CArrayCExtrinsicContext>> dPtr,
);
/// C struct `CInitParameters`.
class CInitParameters extends Struct {
  Pointer<CDbName> dbName;
  Pointer<ffi.Utf8> contextNote;
  static Pointer<CInitParameters> allocate() {
    return ffi.calloc<CInitParameters>();
  }
  static CInitParameters from(int ptr) {
    return Pointer<CInitParameters>.fromAddress(ptr).ref;
  }
}
/// C struct `CRawTxParam`.
class CRawTxParam extends Struct {
  Pointer<ffi.Utf8> rawTx;
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> password;
  static Pointer<CRawTxParam> allocate() {
    return ffi.calloc<CRawTxParam>();
  }
  static CRawTxParam from(int ptr) {
    return Pointer<CRawTxParam>.fromAddress(ptr).ref;
  }
}
/// C struct `CStorageKeyParameters`.
class CStorageKeyParameters extends Struct {
  Pointer<CChainVersion> chainVersion;
  Pointer<ffi.Utf8> module;
  Pointer<ffi.Utf8> storageItem;
  Pointer<ffi.Utf8> account;
  static Pointer<CStorageKeyParameters> allocate() {
    return ffi.calloc<CStorageKeyParameters>();
  }
  static CStorageKeyParameters from(int ptr) {
    return Pointer<CStorageKeyParameters>.fromAddress(ptr).ref;
  }
}
/// C function `CStr_dAlloc`.
Pointer<Pointer<ffi.Utf8>> CStr_dAlloc() {
  return _CStr_dAlloc();
}
final _CStr_dAlloc_Dart _CStr_dAlloc = _dl.lookupFunction<_CStr_dAlloc_C, _CStr_dAlloc_Dart>('CStr_dAlloc');
typedef _CStr_dAlloc_C = Pointer<Pointer<ffi.Utf8>> Function();
typedef _CStr_dAlloc_Dart = Pointer<Pointer<ffi.Utf8>> Function();
/// C function `CStr_dFree`.
void CStr_dFree(
  Pointer<Pointer<ffi.Utf8>> dcs,
) {
  _CStr_dFree(dcs);
}
final _CStr_dFree_Dart _CStr_dFree = _dl.lookupFunction<_CStr_dFree_C, _CStr_dFree_Dart>('CStr_dFree');
typedef _CStr_dFree_C = Void Function(
  Pointer<Pointer<ffi.Utf8>> dcs,
);
typedef _CStr_dFree_Dart = void Function(
  Pointer<Pointer<ffi.Utf8>> dcs,
);
/// C function `CStr_free`.
void CStr_free(
  Pointer<ffi.Utf8> dcs,
) {
  _CStr_free(dcs);
}
final _CStr_free_Dart _CStr_free = _dl.lookupFunction<_CStr_free_C, _CStr_free_Dart>('CStr_free');
typedef _CStr_free_C = Void Function(
  Pointer<ffi.Utf8> dcs,
);
typedef _CStr_free_Dart = void Function(
  Pointer<ffi.Utf8> dcs,
);
/// C struct `CSubChainBasicInfo`.
class CSubChainBasicInfo extends Struct {
  Pointer<ffi.Utf8> genesisHash;
  Pointer<ffi.Utf8> metadata;
  @Int32()
  int runtimeVersion;
  @Int32()
  int txVersion;
  @Int32()
  int ss58FormatPrefix;
  @Int32()
  int tokenDecimals;
  Pointer<ffi.Utf8> tokenSymbol;
  @Uint32()
  int isDefault;
  static Pointer<CSubChainBasicInfo> allocate() {
    return ffi.calloc<CSubChainBasicInfo>();
  }
  static CSubChainBasicInfo from(int ptr) {
    return Pointer<CSubChainBasicInfo>.fromAddress(ptr).ref;
  }
}
/// C function `CSubChainBasicInfo_dAlloc`.
Pointer<Pointer<CSubChainBasicInfo>> CSubChainBasicInfo_dAlloc() {
  return _CSubChainBasicInfo_dAlloc();
}
final _CSubChainBasicInfo_dAlloc_Dart _CSubChainBasicInfo_dAlloc = _dl.lookupFunction<_CSubChainBasicInfo_dAlloc_C, _CSubChainBasicInfo_dAlloc_Dart>('CSubChainBasicInfo_dAlloc');
typedef _CSubChainBasicInfo_dAlloc_C = Pointer<Pointer<CSubChainBasicInfo>> Function();
typedef _CSubChainBasicInfo_dAlloc_Dart = Pointer<Pointer<CSubChainBasicInfo>> Function();
/// C function `CSubChainBasicInfo_dFree`.
void CSubChainBasicInfo_dFree(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
) {
  _CSubChainBasicInfo_dFree(dPtr);
}
final _CSubChainBasicInfo_dFree_Dart _CSubChainBasicInfo_dFree = _dl.lookupFunction<_CSubChainBasicInfo_dFree_C, _CSubChainBasicInfo_dFree_Dart>('CSubChainBasicInfo_dFree');
typedef _CSubChainBasicInfo_dFree_C = Void Function(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
);
typedef _CSubChainBasicInfo_dFree_Dart = void Function(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
);
/// C struct `CTokenAddress`.
class CTokenAddress extends Struct {
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<ffi.Utf8> tokenId;
  Pointer<ffi.Utf8> addressId;
  Pointer<ffi.Utf8> balance;
  static Pointer<CTokenAddress> allocate() {
    return ffi.calloc<CTokenAddress>();
  }
  static CTokenAddress from(int ptr) {
    return Pointer<CTokenAddress>.fromAddress(ptr).ref;
  }
}
/// C struct `CTokenShared`.
class CTokenShared extends Struct {
  Pointer<ffi.Utf8> name;
  Pointer<ffi.Utf8> symbol;
  Pointer<ffi.Utf8> logoUrl;
  Pointer<ffi.Utf8> logoBytes;
  Pointer<ffi.Utf8> projectName;
  Pointer<ffi.Utf8> projectHome;
  Pointer<ffi.Utf8> projectNote;
  static Pointer<CTokenShared> allocate() {
    return ffi.calloc<CTokenShared>();
  }
  static CTokenShared from(int ptr) {
    return Pointer<CTokenShared>.fromAddress(ptr).ref;
  }
}
/// C struct `CWallet`.
class CWallet extends Struct {
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> nextId;
  Pointer<ffi.Utf8> name;
  Pointer<CEthChain> ethChain;
  Pointer<CEeeChain> eeeChain;
  Pointer<CBtcChain> btcChain;
  static Pointer<CWallet> allocate() {
    return ffi.calloc<CWallet>();
  }
  static CWallet from(int ptr) {
    return Pointer<CWallet>.fromAddress(ptr).ref;
  }
}
/// C function `CWallet_dAlloc`.
Pointer<Pointer<CWallet>> CWallet_dAlloc() {
  return _CWallet_dAlloc();
}
final _CWallet_dAlloc_Dart _CWallet_dAlloc = _dl.lookupFunction<_CWallet_dAlloc_C, _CWallet_dAlloc_Dart>('CWallet_dAlloc');
typedef _CWallet_dAlloc_C = Pointer<Pointer<CWallet>> Function();
typedef _CWallet_dAlloc_Dart = Pointer<Pointer<CWallet>> Function();
/// C function `CWallet_dFree`.
void CWallet_dFree(
  Pointer<Pointer<CWallet>> dPtr,
) {
  _CWallet_dFree(dPtr);
}
final _CWallet_dFree_Dart _CWallet_dFree = _dl.lookupFunction<_CWallet_dFree_C, _CWallet_dFree_Dart>('CWallet_dFree');
typedef _CWallet_dFree_C = Void Function(
  Pointer<Pointer<CWallet>> dPtr,
);
typedef _CWallet_dFree_Dart = void Function(
  Pointer<Pointer<CWallet>> dPtr,
);
/// C function `ChainBtc_getAuthTokenList`.
Pointer<CError> ChainBtc_getAuthTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> tokens,
) {
  return _ChainBtc_getAuthTokenList(ctx, netType, startItem, pageSize, tokens);
}
final _ChainBtc_getAuthTokenList_Dart _ChainBtc_getAuthTokenList = _dl.lookupFunction<_ChainBtc_getAuthTokenList_C, _ChainBtc_getAuthTokenList_Dart>('ChainBtc_getAuthTokenList');
typedef _ChainBtc_getAuthTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Uint32 startItem,
  Uint32 pageSize,
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> tokens,
);
typedef _ChainBtc_getAuthTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCBtcChainTokenAuth>> tokens,
);
/// C function `ChainBtc_getDefaultTokenList`.
Pointer<CError> ChainBtc_getDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> tokens,
) {
  return _ChainBtc_getDefaultTokenList(ctx, netType, tokens);
}
final _ChainBtc_getDefaultTokenList_Dart _ChainBtc_getDefaultTokenList = _dl.lookupFunction<_ChainBtc_getDefaultTokenList_C, _ChainBtc_getDefaultTokenList_Dart>('ChainBtc_getDefaultTokenList');
typedef _ChainBtc_getDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> tokens,
);
typedef _ChainBtc_getDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCBtcChainTokenDefault>> tokens,
);
/// C function `ChainBtc_updateAuthDigitList`.
Pointer<CError> ChainBtc_updateAuthDigitList(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenAuth> authTokens,
) {
  return _ChainBtc_updateAuthDigitList(ctx, authTokens);
}
final _ChainBtc_updateAuthDigitList_Dart _ChainBtc_updateAuthDigitList = _dl.lookupFunction<_ChainBtc_updateAuthDigitList_C, _ChainBtc_updateAuthDigitList_Dart>('ChainBtc_updateAuthDigitList');
typedef _ChainBtc_updateAuthDigitList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenAuth> authTokens,
);
typedef _ChainBtc_updateAuthDigitList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenAuth> authTokens,
);
/// C function `ChainBtc_updateDefaultTokenList`.
Pointer<CError> ChainBtc_updateDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenDefault> defaultTokens,
) {
  return _ChainBtc_updateDefaultTokenList(ctx, defaultTokens);
}
final _ChainBtc_updateDefaultTokenList_Dart _ChainBtc_updateDefaultTokenList = _dl.lookupFunction<_ChainBtc_updateDefaultTokenList_C, _ChainBtc_updateDefaultTokenList_Dart>('ChainBtc_updateDefaultTokenList');
typedef _ChainBtc_updateDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenDefault> defaultTokens,
);
typedef _ChainBtc_updateDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCBtcChainTokenDefault> defaultTokens,
);
/// C function `ChainEee_decodeAccountInfo`.
Pointer<CError> ChainEee_decodeAccountInfo(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CDecodeAccountInfoParameters> parameters,
  Pointer<Pointer<CAccountInfo>> accountInfo,
) {
  return _ChainEee_decodeAccountInfo(ctx, netType, parameters, accountInfo);
}
final _ChainEee_decodeAccountInfo_Dart _ChainEee_decodeAccountInfo = _dl.lookupFunction<_ChainEee_decodeAccountInfo_C, _ChainEee_decodeAccountInfo_Dart>('ChainEee_decodeAccountInfo');
typedef _ChainEee_decodeAccountInfo_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CDecodeAccountInfoParameters> parameters,
  Pointer<Pointer<CAccountInfo>> accountInfo,
);
typedef _ChainEee_decodeAccountInfo_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CDecodeAccountInfoParameters> parameters,
  Pointer<Pointer<CAccountInfo>> accountInfo,
);
/// C function `ChainEee_eeeTransfer`.
Pointer<CError> ChainEee_eeeTransfer(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_eeeTransfer(ctx, netType, transferPayload, signedResult);
}
final _ChainEee_eeeTransfer_Dart _ChainEee_eeeTransfer = _dl.lookupFunction<_ChainEee_eeeTransfer_C, _ChainEee_eeeTransfer_Dart>('ChainEee_eeeTransfer');
typedef _ChainEee_eeeTransfer_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_eeeTransfer_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
/// C function `ChainEee_getAuthTokenList`.
Pointer<CError> ChainEee_getAuthTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> tokens,
) {
  return _ChainEee_getAuthTokenList(ctx, netType, startItem, pageSize, tokens);
}
final _ChainEee_getAuthTokenList_Dart _ChainEee_getAuthTokenList = _dl.lookupFunction<_ChainEee_getAuthTokenList_C, _ChainEee_getAuthTokenList_Dart>('ChainEee_getAuthTokenList');
typedef _ChainEee_getAuthTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Uint32 startItem,
  Uint32 pageSize,
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> tokens,
);
typedef _ChainEee_getAuthTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTokenAuth>> tokens,
);
/// C function `ChainEee_getBasicInfo`.
Pointer<CError> ChainEee_getBasicInfo(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CChainVersion> chainVersion,
  Pointer<Pointer<CSubChainBasicInfo>> basicInfo,
) {
  return _ChainEee_getBasicInfo(ctx, netType, chainVersion, basicInfo);
}
final _ChainEee_getBasicInfo_Dart _ChainEee_getBasicInfo = _dl.lookupFunction<_ChainEee_getBasicInfo_C, _ChainEee_getBasicInfo_Dart>('ChainEee_getBasicInfo');
typedef _ChainEee_getBasicInfo_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CChainVersion> chainVersion,
  Pointer<Pointer<CSubChainBasicInfo>> basicInfo,
);
typedef _ChainEee_getBasicInfo_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CChainVersion> chainVersion,
  Pointer<Pointer<CSubChainBasicInfo>> basicInfo,
);
/// C function `ChainEee_getDefaultTokenList`.
Pointer<CError> ChainEee_getDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> tokens,
) {
  return _ChainEee_getDefaultTokenList(ctx, netType, tokens);
}
final _ChainEee_getDefaultTokenList_Dart _ChainEee_getDefaultTokenList = _dl.lookupFunction<_ChainEee_getDefaultTokenList_C, _ChainEee_getDefaultTokenList_Dart>('ChainEee_getDefaultTokenList');
typedef _ChainEee_getDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> tokens,
);
typedef _ChainEee_getDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEeeChainTokenDefault>> tokens,
);
/// C function `ChainEee_getStorageKey`.
Pointer<CError> ChainEee_getStorageKey(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CStorageKeyParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> key,
) {
  return _ChainEee_getStorageKey(ctx, netType, parameters, key);
}
final _ChainEee_getStorageKey_Dart _ChainEee_getStorageKey = _dl.lookupFunction<_ChainEee_getStorageKey_C, _ChainEee_getStorageKey_Dart>('ChainEee_getStorageKey');
typedef _ChainEee_getStorageKey_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CStorageKeyParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> key,
);
typedef _ChainEee_getStorageKey_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CStorageKeyParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> key,
);
/// C function `ChainEee_getSyncRecord`.
Pointer<CError> ChainEee_getSyncRecord(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  Pointer<Pointer<CAccountInfoSyncProg>> syncRecord,
) {
  return _ChainEee_getSyncRecord(ctx, netType, account, syncRecord);
}
final _ChainEee_getSyncRecord_Dart _ChainEee_getSyncRecord = _dl.lookupFunction<_ChainEee_getSyncRecord_C, _ChainEee_getSyncRecord_Dart>('ChainEee_getSyncRecord');
typedef _ChainEee_getSyncRecord_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  Pointer<Pointer<CAccountInfoSyncProg>> syncRecord,
);
typedef _ChainEee_getSyncRecord_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  Pointer<Pointer<CAccountInfoSyncProg>> syncRecord,
);
/// C function `ChainEee_queryChainTxRecord`.
Pointer<CError> ChainEee_queryChainTxRecord(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
) {
  return _ChainEee_queryChainTxRecord(ctx, netType, account, startItem, pageSize, records);
}
final _ChainEee_queryChainTxRecord_Dart _ChainEee_queryChainTxRecord = _dl.lookupFunction<_ChainEee_queryChainTxRecord_C, _ChainEee_queryChainTxRecord_Dart>('ChainEee_queryChainTxRecord');
typedef _ChainEee_queryChainTxRecord_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  Uint32 startItem,
  Uint32 pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
);
typedef _ChainEee_queryChainTxRecord_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
);
/// C function `ChainEee_queryTokenxTxRecord`.
Pointer<CError> ChainEee_queryTokenxTxRecord(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
) {
  return _ChainEee_queryTokenxTxRecord(ctx, netType, account, startItem, pageSize, records);
}
final _ChainEee_queryTokenxTxRecord_Dart _ChainEee_queryTokenxTxRecord = _dl.lookupFunction<_ChainEee_queryTokenxTxRecord_C, _ChainEee_queryTokenxTxRecord_Dart>('ChainEee_queryTokenxTxRecord');
typedef _ChainEee_queryTokenxTxRecord_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  Uint32 startItem,
  Uint32 pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
);
typedef _ChainEee_queryTokenxTxRecord_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> account,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEeeChainTx>> records,
);
/// C function `ChainEee_saveExtrinsicDetail`.
Pointer<CError> ChainEee_saveExtrinsicDetail(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CExtrinsicContext> extrinsicCtx,
) {
  return _ChainEee_saveExtrinsicDetail(ctx, netType, extrinsicCtx);
}
final _ChainEee_saveExtrinsicDetail_Dart _ChainEee_saveExtrinsicDetail = _dl.lookupFunction<_ChainEee_saveExtrinsicDetail_C, _ChainEee_saveExtrinsicDetail_Dart>('ChainEee_saveExtrinsicDetail');
typedef _ChainEee_saveExtrinsicDetail_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CExtrinsicContext> extrinsicCtx,
);
typedef _ChainEee_saveExtrinsicDetail_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CExtrinsicContext> extrinsicCtx,
);
/// C function `ChainEee_tokenXTransfer`.
Pointer<CError> ChainEee_tokenXTransfer(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_tokenXTransfer(ctx, netType, transferPayload, signedResult);
}
final _ChainEee_tokenXTransfer_Dart _ChainEee_tokenXTransfer = _dl.lookupFunction<_ChainEee_tokenXTransfer_C, _ChainEee_tokenXTransfer_Dart>('ChainEee_tokenXTransfer');
typedef _ChainEee_tokenXTransfer_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_tokenXTransfer_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEeeTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
/// C function `ChainEee_txSign`.
Pointer<CError> ChainEee_txSign(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_txSign(ctx, netType, rawTx, signedResult);
}
final _ChainEee_txSign_Dart _ChainEee_txSign = _dl.lookupFunction<_ChainEee_txSign_C, _ChainEee_txSign_Dart>('ChainEee_txSign');
typedef _ChainEee_txSign_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_txSign_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
/// C function `ChainEee_txSubmittableSign`.
Pointer<CError> ChainEee_txSubmittableSign(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_txSubmittableSign(ctx, netType, rawTx, signedResult);
}
final _ChainEee_txSubmittableSign_Dart _ChainEee_txSubmittableSign = _dl.lookupFunction<_ChainEee_txSubmittableSign_C, _ChainEee_txSubmittableSign_Dart>('ChainEee_txSubmittableSign');
typedef _ChainEee_txSubmittableSign_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_txSubmittableSign_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CRawTxParam> rawTx,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
/// C function `ChainEee_updateAuthDigitList`.
Pointer<CError> ChainEee_updateAuthDigitList(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenAuth> authTokens,
) {
  return _ChainEee_updateAuthDigitList(ctx, authTokens);
}
final _ChainEee_updateAuthDigitList_Dart _ChainEee_updateAuthDigitList = _dl.lookupFunction<_ChainEee_updateAuthDigitList_C, _ChainEee_updateAuthDigitList_Dart>('ChainEee_updateAuthDigitList');
typedef _ChainEee_updateAuthDigitList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenAuth> authTokens,
);
typedef _ChainEee_updateAuthDigitList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenAuth> authTokens,
);
/// C function `ChainEee_updateBasicInfo`.
Pointer<CError> ChainEee_updateBasicInfo(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CSubChainBasicInfo> basicInfo,
) {
  return _ChainEee_updateBasicInfo(ctx, netType, basicInfo);
}
final _ChainEee_updateBasicInfo_Dart _ChainEee_updateBasicInfo = _dl.lookupFunction<_ChainEee_updateBasicInfo_C, _ChainEee_updateBasicInfo_Dart>('ChainEee_updateBasicInfo');
typedef _ChainEee_updateBasicInfo_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CSubChainBasicInfo> basicInfo,
);
typedef _ChainEee_updateBasicInfo_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CSubChainBasicInfo> basicInfo,
);
/// C function `ChainEee_updateDefaultTokenList`.
Pointer<CError> ChainEee_updateDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenDefault> defaultTokens,
) {
  return _ChainEee_updateDefaultTokenList(ctx, defaultTokens);
}
final _ChainEee_updateDefaultTokenList_Dart _ChainEee_updateDefaultTokenList = _dl.lookupFunction<_ChainEee_updateDefaultTokenList_C, _ChainEee_updateDefaultTokenList_Dart>('ChainEee_updateDefaultTokenList');
typedef _ChainEee_updateDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenDefault> defaultTokens,
);
typedef _ChainEee_updateDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEeeChainTokenDefault> defaultTokens,
);
/// C function `ChainEee_updateSyncRecord`.
Pointer<CError> ChainEee_updateSyncRecord(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CAccountInfoSyncProg> syncRecord,
) {
  return _ChainEee_updateSyncRecord(ctx, netType, syncRecord);
}
final _ChainEee_updateSyncRecord_Dart _ChainEee_updateSyncRecord = _dl.lookupFunction<_ChainEee_updateSyncRecord_C, _ChainEee_updateSyncRecord_Dart>('ChainEee_updateSyncRecord');
typedef _ChainEee_updateSyncRecord_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CAccountInfoSyncProg> syncRecord,
);
typedef _ChainEee_updateSyncRecord_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CAccountInfoSyncProg> syncRecord,
);
/// C function `ChainEth_addNonAuthDigit`.
Pointer<CError> ChainEth_addNonAuthDigit(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> tokens,
) {
  return _ChainEth_addNonAuthDigit(ctx, tokens);
}
final _ChainEth_addNonAuthDigit_Dart _ChainEth_addNonAuthDigit = _dl.lookupFunction<_ChainEth_addNonAuthDigit_C, _ChainEth_addNonAuthDigit_Dart>('ChainEth_addNonAuthDigit');
typedef _ChainEth_addNonAuthDigit_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> tokens,
);
typedef _ChainEth_addNonAuthDigit_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> tokens,
);
/// C function `ChainEth_decodeAdditionData`.
Pointer<CError> ChainEth_decodeAdditionData(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> encodeData,
  Pointer<Pointer<ffi.Utf8>> additionData,
) {
  return _ChainEth_decodeAdditionData(ctx, encodeData, additionData);
}
final _ChainEth_decodeAdditionData_Dart _ChainEth_decodeAdditionData = _dl.lookupFunction<_ChainEth_decodeAdditionData_C, _ChainEth_decodeAdditionData_Dart>('ChainEth_decodeAdditionData');
typedef _ChainEth_decodeAdditionData_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> encodeData,
  Pointer<Pointer<ffi.Utf8>> additionData,
);
typedef _ChainEth_decodeAdditionData_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> encodeData,
  Pointer<Pointer<ffi.Utf8>> additionData,
);
/// C function `ChainEth_getAuthTokenList`.
Pointer<CError> ChainEth_getAuthTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEthChainTokenAuth>> tokens,
) {
  return _ChainEth_getAuthTokenList(ctx, netType, startItem, pageSize, tokens);
}
final _ChainEth_getAuthTokenList_Dart _ChainEth_getAuthTokenList = _dl.lookupFunction<_ChainEth_getAuthTokenList_C, _ChainEth_getAuthTokenList_Dart>('ChainEth_getAuthTokenList');
typedef _ChainEth_getAuthTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Uint32 startItem,
  Uint32 pageSize,
  Pointer<Pointer<CArrayCEthChainTokenAuth>> tokens,
);
typedef _ChainEth_getAuthTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  int startItem,
  int pageSize,
  Pointer<Pointer<CArrayCEthChainTokenAuth>> tokens,
);
/// C function `ChainEth_getDefaultTokenList`.
Pointer<CError> ChainEth_getDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEthChainTokenDefault>> tokens,
) {
  return _ChainEth_getDefaultTokenList(ctx, netType, tokens);
}
final _ChainEth_getDefaultTokenList_Dart _ChainEth_getDefaultTokenList = _dl.lookupFunction<_ChainEth_getDefaultTokenList_C, _ChainEth_getDefaultTokenList_Dart>('ChainEth_getDefaultTokenList');
typedef _ChainEth_getDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEthChainTokenDefault>> tokens,
);
typedef _ChainEth_getDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<Pointer<CArrayCEthChainTokenDefault>> tokens,
);
/// C function `ChainEth_rawTxSign`.
Pointer<CError> ChainEth_rawTxSign(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthRawTxPayload> rawTxPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
) {
  return _ChainEth_rawTxSign(ctx, netType, rawTxPayload, password, signResult);
}
final _ChainEth_rawTxSign_Dart _ChainEth_rawTxSign = _dl.lookupFunction<_ChainEth_rawTxSign_C, _ChainEth_rawTxSign_Dart>('ChainEth_rawTxSign');
typedef _ChainEth_rawTxSign_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthRawTxPayload> rawTxPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
);
typedef _ChainEth_rawTxSign_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthRawTxPayload> rawTxPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
);
/// C function `ChainEth_txSign`.
Pointer<CError> ChainEth_txSign(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthTransferPayload> txPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
) {
  return _ChainEth_txSign(ctx, netType, txPayload, password, signResult);
}
final _ChainEth_txSign_Dart _ChainEth_txSign = _dl.lookupFunction<_ChainEth_txSign_C, _ChainEth_txSign_Dart>('ChainEth_txSign');
typedef _ChainEth_txSign_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthTransferPayload> txPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
);
typedef _ChainEth_txSign_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CEthTransferPayload> txPayload,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> signResult,
);
/// C function `ChainEth_updateAuthTokenList`.
Pointer<CError> ChainEth_updateAuthTokenList(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> authTokens,
) {
  return _ChainEth_updateAuthTokenList(ctx, authTokens);
}
final _ChainEth_updateAuthTokenList_Dart _ChainEth_updateAuthTokenList = _dl.lookupFunction<_ChainEth_updateAuthTokenList_C, _ChainEth_updateAuthTokenList_Dart>('ChainEth_updateAuthTokenList');
typedef _ChainEth_updateAuthTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> authTokens,
);
typedef _ChainEth_updateAuthTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenAuth> authTokens,
);
/// C function `ChainEth_updateDefaultTokenList`.
Pointer<CError> ChainEth_updateDefaultTokenList(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenDefault> defaultTokens,
) {
  return _ChainEth_updateDefaultTokenList(ctx, defaultTokens);
}
final _ChainEth_updateDefaultTokenList_Dart _ChainEth_updateDefaultTokenList = _dl.lookupFunction<_ChainEth_updateDefaultTokenList_C, _ChainEth_updateDefaultTokenList_Dart>('ChainEth_updateDefaultTokenList');
typedef _ChainEth_updateDefaultTokenList_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenDefault> defaultTokens,
);
typedef _ChainEth_updateDefaultTokenList_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CArrayCEthChainTokenDefault> defaultTokens,
);
/// <p class="para-brief"> 返回所有的Context, 有可能是0个 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_Contexts(
  Pointer<Pointer<CArrayCContext>> contexts,
) {
  return _Wallets_Contexts(contexts);
}
final _Wallets_Contexts_Dart _Wallets_Contexts = _dl.lookupFunction<_Wallets_Contexts_C, _Wallets_Contexts_Dart>('Wallets_Contexts');
typedef _Wallets_Contexts_C = Pointer<CError> Function(
  Pointer<Pointer<CArrayCContext>> contexts,
);
typedef _Wallets_Contexts_Dart = Pointer<CError> Function(
  Pointer<Pointer<CArrayCContext>> contexts,
);
/// C function `Wallets_all`.
Pointer<CError> Wallets_all(
  Pointer<CContext> ctx,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
) {
  return _Wallets_all(ctx, arrayWallet);
}
final _Wallets_all_Dart _Wallets_all = _dl.lookupFunction<_Wallets_all_C, _Wallets_all_Dart>('Wallets_all');
typedef _Wallets_all_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
);
typedef _Wallets_all_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
);
/// C function `Wallets_appPlatformType`.
Pointer<ffi.Utf8> Wallets_appPlatformType() {
  return _Wallets_appPlatformType();
}
final _Wallets_appPlatformType_Dart _Wallets_appPlatformType = _dl.lookupFunction<_Wallets_appPlatformType_C, _Wallets_appPlatformType_Dart>('Wallets_appPlatformType');
typedef _Wallets_appPlatformType_C = Pointer<ffi.Utf8> Function();
typedef _Wallets_appPlatformType_Dart = Pointer<ffi.Utf8> Function();
/// C function `Wallets_createWallet`.
Pointer<CError> Wallets_createWallet(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<CWallet>> wallet,
) {
  return _Wallets_createWallet(ctx, parameters, wallet);
}
final _Wallets_createWallet_Dart _Wallets_createWallet = _dl.lookupFunction<_Wallets_createWallet_C, _Wallets_createWallet_Dart>('Wallets_createWallet');
typedef _Wallets_createWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<CWallet>> wallet,
);
typedef _Wallets_createWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<CWallet>> wallet,
);
/// <p class="para-brief"> 查询当前wallet 与 chain</p>
Pointer<CError> Wallets_currentWalletChain(
  Pointer<CContext> ctx,
  Pointer<Pointer<ffi.Utf8>> walletId,
  Pointer<Pointer<ffi.Utf8>> chainType,
) {
  return _Wallets_currentWalletChain(ctx, walletId, chainType);
}
final _Wallets_currentWalletChain_Dart _Wallets_currentWalletChain = _dl.lookupFunction<_Wallets_currentWalletChain_C, _Wallets_currentWalletChain_Dart>('Wallets_currentWalletChain');
typedef _Wallets_currentWalletChain_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Pointer<ffi.Utf8>> walletId,
  Pointer<Pointer<ffi.Utf8>> chainType,
);
typedef _Wallets_currentWalletChain_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Pointer<ffi.Utf8>> walletId,
  Pointer<Pointer<ffi.Utf8>> chainType,
);
/// <p class="para-brief"> 生成数据库文件名，只有数据库文件名不存在（为null或“”）时才创建文件名 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_dbName(
  Pointer<CDbName> name,
  Pointer<Pointer<CDbName>> outName,
) {
  return _Wallets_dbName(name, outName);
}
final _Wallets_dbName_Dart _Wallets_dbName = _dl.lookupFunction<_Wallets_dbName_C, _Wallets_dbName_Dart>('Wallets_dbName');
typedef _Wallets_dbName_C = Pointer<CError> Function(
  Pointer<CDbName> name,
  Pointer<Pointer<CDbName>> outName,
);
typedef _Wallets_dbName_Dart = Pointer<CError> Function(
  Pointer<CDbName> name,
  Pointer<Pointer<CDbName>> outName,
);
/// C function `Wallets_exportWallet`.
Pointer<CError> Wallets_exportWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> mnemonic,
) {
  return _Wallets_exportWallet(ctx, walletId, password, mnemonic);
}
final _Wallets_exportWallet_Dart _Wallets_exportWallet = _dl.lookupFunction<_Wallets_exportWallet_C, _Wallets_exportWallet_Dart>('Wallets_exportWallet');
typedef _Wallets_exportWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> mnemonic,
);
typedef _Wallets_exportWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
  Pointer<Pointer<ffi.Utf8>> mnemonic,
);
/// C function `Wallets_findById`.
Pointer<CError> Wallets_findById(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CWallet>> wallet,
) {
  return _Wallets_findById(ctx, walletId, wallet);
}
final _Wallets_findById_Dart _Wallets_findById = _dl.lookupFunction<_Wallets_findById_C, _Wallets_findById_Dart>('Wallets_findById');
typedef _Wallets_findById_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CWallet>> wallet,
);
typedef _Wallets_findById_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CWallet>> wallet,
);
/// <p class="para-brief">注：只加载了wallet的id name等直接的基本数据，子对象（如链）的数据没有加载</p>
Pointer<CError> Wallets_findWalletBaseByName(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> walletArray,
) {
  return _Wallets_findWalletBaseByName(ctx, name, walletArray);
}
final _Wallets_findWalletBaseByName_Dart _Wallets_findWalletBaseByName = _dl.lookupFunction<_Wallets_findWalletBaseByName_C, _Wallets_findWalletBaseByName_Dart>('Wallets_findWalletBaseByName');
typedef _Wallets_findWalletBaseByName_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> walletArray,
);
typedef _Wallets_findWalletBaseByName_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> walletArray,
);
/// <p class="para-brief"> 返回第一个Context, 有可能是空值 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_firstContext(
  Pointer<Pointer<CContext>> context,
) {
  return _Wallets_firstContext(context);
}
final _Wallets_firstContext_Dart _Wallets_firstContext = _dl.lookupFunction<_Wallets_firstContext_C, _Wallets_firstContext_Dart>('Wallets_firstContext');
typedef _Wallets_firstContext_C = Pointer<CError> Function(
  Pointer<Pointer<CContext>> context,
);
typedef _Wallets_firstContext_Dart = Pointer<CError> Function(
  Pointer<Pointer<CContext>> context,
);
/// C function `Wallets_generateMnemonic`.
Pointer<CError> Wallets_generateMnemonic(
  Pointer<Pointer<ffi.Utf8>> mnemonic,
) {
  return _Wallets_generateMnemonic(mnemonic);
}
final _Wallets_generateMnemonic_Dart _Wallets_generateMnemonic = _dl.lookupFunction<_Wallets_generateMnemonic_C, _Wallets_generateMnemonic_Dart>('Wallets_generateMnemonic');
typedef _Wallets_generateMnemonic_C = Pointer<CError> Function(
  Pointer<Pointer<ffi.Utf8>> mnemonic,
);
typedef _Wallets_generateMnemonic_Dart = Pointer<CError> Function(
  Pointer<Pointer<ffi.Utf8>> mnemonic,
);
/// <p class="para-brief"> 只有到CError为 Error::SUCCESS()时返值才有意义 返回值 hasAny: true表示至少有一个; Fail: false，没有</p>
Pointer<CError> Wallets_hasAny(
  Pointer<CContext> ctx,
  Pointer<Uint32> hasAny,
) {
  return _Wallets_hasAny(ctx, hasAny);
}
final _Wallets_hasAny_Dart _Wallets_hasAny = _dl.lookupFunction<_Wallets_hasAny_C, _Wallets_hasAny_Dart>('Wallets_hasAny');
typedef _Wallets_hasAny_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Uint32> hasAny,
);
typedef _Wallets_hasAny_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Uint32> hasAny,
);
/// C function `Wallets_hideTokenAddress`.
Pointer<CError> Wallets_hideTokenAddress(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
) {
  return _Wallets_hideTokenAddress(ctx, netType, tokenAddress);
}
final _Wallets_hideTokenAddress_Dart _Wallets_hideTokenAddress = _dl.lookupFunction<_Wallets_hideTokenAddress_C, _Wallets_hideTokenAddress_Dart>('Wallets_hideTokenAddress');
typedef _Wallets_hideTokenAddress_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
);
typedef _Wallets_hideTokenAddress_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
);
/// <p class="para-brief"> 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_init(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> context,
) {
  return _Wallets_init(parameter, context);
}
final _Wallets_init_Dart _Wallets_init = _dl.lookupFunction<_Wallets_init_C, _Wallets_init_Dart>('Wallets_init');
typedef _Wallets_init_C = Pointer<CError> Function(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> context,
);
typedef _Wallets_init_Dart = Pointer<CError> Function(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> context,
);
/// <p class="para-brief"> 返回最后的Context, 有可能是空值 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_lastContext(
  Pointer<Pointer<CContext>> context,
) {
  return _Wallets_lastContext(context);
}
final _Wallets_lastContext_Dart _Wallets_lastContext = _dl.lookupFunction<_Wallets_lastContext_C, _Wallets_lastContext_Dart>('Wallets_lastContext');
typedef _Wallets_lastContext_C = Pointer<CError> Function(
  Pointer<Pointer<CContext>> context,
);
typedef _Wallets_lastContext_Dart = Pointer<CError> Function(
  Pointer<Pointer<CContext>> context,
);
/// C function `Wallets_lockRead`.
Pointer<CError> Wallets_lockRead(
  Pointer<CContext> ctx,
) {
  return _Wallets_lockRead(ctx);
}
final _Wallets_lockRead_Dart _Wallets_lockRead = _dl.lookupFunction<_Wallets_lockRead_C, _Wallets_lockRead_Dart>('Wallets_lockRead');
typedef _Wallets_lockRead_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_lockRead_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
/// C function `Wallets_lockWrite`.
Pointer<CError> Wallets_lockWrite(
  Pointer<CContext> ctx,
) {
  return _Wallets_lockWrite(ctx);
}
final _Wallets_lockWrite_Dart _Wallets_lockWrite = _dl.lookupFunction<_Wallets_lockWrite_C, _Wallets_lockWrite_Dart>('Wallets_lockWrite');
typedef _Wallets_lockWrite_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_lockWrite_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
/// C function `Wallets_queryBalance`.
Pointer<CError> Wallets_queryBalance(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CArrayCTokenAddress>> tokenAddress,
) {
  return _Wallets_queryBalance(ctx, netType, walletId, tokenAddress);
}
final _Wallets_queryBalance_Dart _Wallets_queryBalance = _dl.lookupFunction<_Wallets_queryBalance_C, _Wallets_queryBalance_Dart>('Wallets_queryBalance');
typedef _Wallets_queryBalance_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CArrayCTokenAddress>> tokenAddress,
);
typedef _Wallets_queryBalance_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CArrayCTokenAddress>> tokenAddress,
);
/// C function `Wallets_removeWallet`.
Pointer<CError> Wallets_removeWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
) {
  return _Wallets_removeWallet(ctx, walletId, password);
}
final _Wallets_removeWallet_Dart _Wallets_removeWallet = _dl.lookupFunction<_Wallets_removeWallet_C, _Wallets_removeWallet_Dart>('Wallets_removeWallet');
typedef _Wallets_removeWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
);
typedef _Wallets_removeWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> password,
);
/// C function `Wallets_renameWallet`.
Pointer<CError> Wallets_renameWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> newName,
  Pointer<ffi.Utf8> walletId,
) {
  return _Wallets_renameWallet(ctx, newName, walletId);
}
final _Wallets_renameWallet_Dart _Wallets_renameWallet = _dl.lookupFunction<_Wallets_renameWallet_C, _Wallets_renameWallet_Dart>('Wallets_renameWallet');
typedef _Wallets_renameWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> newName,
  Pointer<ffi.Utf8> walletId,
);
typedef _Wallets_renameWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> newName,
  Pointer<ffi.Utf8> walletId,
);
/// C function `Wallets_resetWalletPassword`.
Pointer<CError> Wallets_resetWalletPassword(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> oldPsd,
  Pointer<ffi.Utf8> newPsd,
) {
  return _Wallets_resetWalletPassword(ctx, walletId, oldPsd, newPsd);
}
final _Wallets_resetWalletPassword_Dart _Wallets_resetWalletPassword = _dl.lookupFunction<_Wallets_resetWalletPassword_C, _Wallets_resetWalletPassword_Dart>('Wallets_resetWalletPassword');
typedef _Wallets_resetWalletPassword_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> oldPsd,
  Pointer<ffi.Utf8> newPsd,
);
typedef _Wallets_resetWalletPassword_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> oldPsd,
  Pointer<ffi.Utf8> newPsd,
);
/// <p class="para-brief">保存当前wallet 与 chain</p>
Pointer<CError> Wallets_saveCurrentWalletChain(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> chainType,
) {
  return _Wallets_saveCurrentWalletChain(ctx, walletId, chainType);
}
final _Wallets_saveCurrentWalletChain_Dart _Wallets_saveCurrentWalletChain = _dl.lookupFunction<_Wallets_saveCurrentWalletChain_C, _Wallets_saveCurrentWalletChain_Dart>('Wallets_saveCurrentWalletChain');
typedef _Wallets_saveCurrentWalletChain_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> chainType,
);
typedef _Wallets_saveCurrentWalletChain_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> chainType,
);
/// C function `Wallets_setCurrentDbVersion`.
Pointer<CError> Wallets_setCurrentDbVersion(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> versionValue,
) {
  return _Wallets_setCurrentDbVersion(ctx, versionValue);
}
final _Wallets_setCurrentDbVersion_Dart _Wallets_setCurrentDbVersion = _dl.lookupFunction<_Wallets_setCurrentDbVersion_C, _Wallets_setCurrentDbVersion_Dart>('Wallets_setCurrentDbVersion');
typedef _Wallets_setCurrentDbVersion_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> versionValue,
);
typedef _Wallets_setCurrentDbVersion_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> versionValue,
);
/// <p class="para-brief"> 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_uninit(
  Pointer<CContext> ctx,
) {
  return _Wallets_uninit(ctx);
}
final _Wallets_uninit_Dart _Wallets_uninit = _dl.lookupFunction<_Wallets_uninit_C, _Wallets_uninit_Dart>('Wallets_uninit');
typedef _Wallets_uninit_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_uninit_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
/// C function `Wallets_unlockRead`.
Pointer<CError> Wallets_unlockRead(
  Pointer<CContext> ctx,
) {
  return _Wallets_unlockRead(ctx);
}
final _Wallets_unlockRead_Dart _Wallets_unlockRead = _dl.lookupFunction<_Wallets_unlockRead_C, _Wallets_unlockRead_Dart>('Wallets_unlockRead');
typedef _Wallets_unlockRead_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_unlockRead_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
/// C function `Wallets_unlockWrite`.
Pointer<CError> Wallets_unlockWrite(
  Pointer<CContext> ctx,
) {
  return _Wallets_unlockWrite(ctx);
}
final _Wallets_unlockWrite_Dart _Wallets_unlockWrite = _dl.lookupFunction<_Wallets_unlockWrite_C, _Wallets_unlockWrite_Dart>('Wallets_unlockWrite');
typedef _Wallets_unlockWrite_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_unlockWrite_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
/// C function `Wallets_updateBalance`.
Pointer<CError> Wallets_updateBalance(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
) {
  return _Wallets_updateBalance(ctx, netType, tokenAddress);
}
final _Wallets_updateBalance_Dart _Wallets_updateBalance = _dl.lookupFunction<_Wallets_updateBalance_C, _Wallets_updateBalance_Dart>('Wallets_updateBalance');
typedef _Wallets_updateBalance_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
);
typedef _Wallets_updateBalance_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTokenAddress> tokenAddress,
);
