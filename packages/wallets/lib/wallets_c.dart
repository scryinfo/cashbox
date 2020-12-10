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

/// C struct `CAddress`.
class CAddress extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<ffi.Utf8> address;
  Pointer<ffi.Utf8> publicKey;
  static Pointer<CAddress> allocate() {
    return ffi.allocate<CAddress>();
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
    return ffi.allocate<CArrayCBtcChainToken>();
  }


  static CArrayCBtcChainToken from(int ptr) {
    return Pointer<CArrayCBtcChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEeeChainToken extends Struct {
  
  Pointer<CEeeChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEeeChainToken> allocate() {
    return ffi.allocate<CArrayCEeeChainToken>();
  }


  static CArrayCEeeChainToken from(int ptr) {
    return Pointer<CArrayCEeeChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCEthChainToken extends Struct {
  
  Pointer<CEthChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCEthChainToken> allocate() {
    return ffi.allocate<CArrayCEthChainToken>();
  }


  static CArrayCEthChainToken from(int ptr) {
    return Pointer<CArrayCEthChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayCWallet extends Struct {
  
  Pointer<CWallet> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayCWallet> allocate() {
    return ffi.allocate<CArrayCWallet>();
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

/// C struct `CBtcChain`.
class CBtcChain extends Struct {
  
  Pointer<CChainShared> chainShared;
  Pointer<CArrayCBtcChainToken> tokens;
  static Pointer<CBtcChain> allocate() {
    return ffi.allocate<CBtcChain>();
  }


  static CBtcChain from(int ptr) {
    return Pointer<CBtcChain>.fromAddress(ptr).ref;
  }

}

/// C struct `CBtcChainToken`.
class CBtcChainToken extends Struct {
  
  Pointer<CBtcChainTokenShared> btcChainTokenShared;
  static Pointer<CBtcChainToken> allocate() {
    return ffi.allocate<CBtcChainToken>();
  }


  static CBtcChainToken from(int ptr) {
    return Pointer<CBtcChainToken>.fromAddress(ptr).ref;
  }

}

/// C struct `CBtcChainTokenShared`.
class CBtcChainTokenShared extends Struct {
  
  Pointer<CTokenShared> tokenShared;
  static Pointer<CBtcChainTokenShared> allocate() {
    return ffi.allocate<CBtcChainTokenShared>();
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
    return ffi.allocate<CChainShared>();
  }


  static CChainShared from(int ptr) {
    return Pointer<CChainShared>.fromAddress(ptr).ref;
  }

}

/// C function `CChar_free`.
void CChar_free(
  Pointer<ffi.Utf8> cs,
) {
  _CChar_free(cs);
}
final _CChar_free_Dart _CChar_free = _dl.lookupFunction<_CChar_free_C, _CChar_free_Dart>('CChar_free');
typedef _CChar_free_C = Void Function(
  Pointer<ffi.Utf8> cs,
);
typedef _CChar_free_Dart = void Function(
  Pointer<ffi.Utf8> cs,
);

/// C struct `CContext`.
class CContext extends Struct {
  
  Pointer<ffi.Utf8> id;
  static Pointer<CContext> allocate() {
    return ffi.allocate<CContext>();
  }


  static CContext from(int ptr) {
    return Pointer<CContext>.fromAddress(ptr).ref;
  }

}

/// C function `CContext_dAlloc`.
Pointer<Pointer<CContext>> CContext_dAlloc() {
  return _CContext_dAlloc();
}
final _CContext_dAlloc_Dart _CContext_dAlloc = _dl.lookupFunction<_CContext_dAlloc_C, _CContext_dAlloc_Dart>('CContext_dAlloc');
typedef _CContext_dAlloc_C = Pointer<Pointer<CContext>> Function();
typedef _CContext_dAlloc_Dart = Pointer<Pointer<CContext>> Function();

/// C function `CContext_dFree`.
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
  static Pointer<CCreateWalletParameters> allocate() {
    return ffi.allocate<CCreateWalletParameters>();
  }


  static CCreateWalletParameters from(int ptr) {
    return Pointer<CCreateWalletParameters>.fromAddress(ptr).ref;
  }

}

/// C struct `CDbName`.
class CDbName extends Struct {
  
  Pointer<ffi.Utf8> cashboxWallets;
  Pointer<ffi.Utf8> cashboxMnemonic;
  Pointer<ffi.Utf8> walletMainnet;
  Pointer<ffi.Utf8> walletPrivate;
  Pointer<ffi.Utf8> walletTestnet;
  Pointer<ffi.Utf8> walletTestnetPrivate;
  static Pointer<CDbName> allocate() {
    return ffi.allocate<CDbName>();
  }


  static CDbName from(int ptr) {
    return Pointer<CDbName>.fromAddress(ptr).ref;
  }

}

/// C struct `CEeeChain`.
class CEeeChain extends Struct {
  
  Pointer<CChainShared> chainShared;
  Pointer<CAddress> address;
  Pointer<CArrayCEeeChainToken> tokens;
  static Pointer<CEeeChain> allocate() {
    return ffi.allocate<CEeeChain>();
  }


  static CEeeChain from(int ptr) {
    return Pointer<CEeeChain>.fromAddress(ptr).ref;
  }

}

/// C struct `CEeeChainToken`.
class CEeeChainToken extends Struct {
  
  Pointer<CEeeChainTokenShared> eeeChainTokenShared;
  static Pointer<CEeeChainToken> allocate() {
    return ffi.allocate<CEeeChainToken>();
  }


  static CEeeChainToken from(int ptr) {
    return Pointer<CEeeChainToken>.fromAddress(ptr).ref;
  }

}

/// C struct `CEeeChainTokenShared`.
class CEeeChainTokenShared extends Struct {
  
  Pointer<CTokenShared> tokenShared;
  static Pointer<CEeeChainTokenShared> allocate() {
    return ffi.allocate<CEeeChainTokenShared>();
  }


  static CEeeChainTokenShared from(int ptr) {
    return Pointer<CEeeChainTokenShared>.fromAddress(ptr).ref;
  }

}

/// C struct `CError`.
class CError extends Struct {
  
  @Uint64()
  int code;
  Pointer<ffi.Utf8> message;
  static Pointer<CError> allocate() {
    return ffi.allocate<CError>();
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
    return ffi.allocate<CEthChain>();
  }


  static CEthChain from(int ptr) {
    return Pointer<CEthChain>.fromAddress(ptr).ref;
  }

}

/// C struct `CEthChainToken`.
class CEthChainToken extends Struct {
  
  Pointer<CEthChainTokenShared> ethChainTokenShared;
  static Pointer<CEthChainToken> allocate() {
    return ffi.allocate<CEthChainToken>();
  }


  static CEthChainToken from(int ptr) {
    return Pointer<CEthChainToken>.fromAddress(ptr).ref;
  }

}

/// C struct `CEthChainTokenShared`.
class CEthChainTokenShared extends Struct {
  
  Pointer<CTokenShared> tokenShared;
  static Pointer<CEthChainTokenShared> allocate() {
    return ffi.allocate<CEthChainTokenShared>();
  }


  static CEthChainTokenShared from(int ptr) {
    return Pointer<CEthChainTokenShared>.fromAddress(ptr).ref;
  }

}

/// C struct `CInitParameters`.
class CInitParameters extends Struct {
  
  Pointer<CDbName> dbName;
  static Pointer<CInitParameters> allocate() {
    return ffi.allocate<CInitParameters>();
  }


  static CInitParameters from(int ptr) {
    return Pointer<CInitParameters>.fromAddress(ptr).ref;
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
  Pointer<ffi.Utf8> cs,
) {
  _CStr_free(cs);
}
final _CStr_free_Dart _CStr_free = _dl.lookupFunction<_CStr_free_C, _CStr_free_Dart>('CStr_free');
typedef _CStr_free_C = Void Function(
  Pointer<ffi.Utf8> cs,
);
typedef _CStr_free_Dart = void Function(
  Pointer<ffi.Utf8> cs,
);

/// C struct `CTokenShared`.
class CTokenShared extends Struct {
  
  Pointer<ffi.Utf8> chainType;
  Pointer<ffi.Utf8> name;
  Pointer<ffi.Utf8> symbol;
  Pointer<ffi.Utf8> logoUrl;
  Pointer<ffi.Utf8> logoBytes;
  Pointer<ffi.Utf8> project;
  @Int32()
  int auth;
  static Pointer<CTokenShared> allocate() {
    return ffi.allocate<CTokenShared>();
  }


  static CTokenShared from(int ptr) {
    return Pointer<CTokenShared>.fromAddress(ptr).ref;
  }

}

/// C struct `CUnInitParameters`.
class CUnInitParameters extends Struct {
  
  static Pointer<CUnInitParameters> allocate() {
    return ffi.allocate<CUnInitParameters>();
  }


  static CUnInitParameters from(int ptr) {
    return Pointer<CUnInitParameters>.fromAddress(ptr).ref;
  }

}

/// C struct `CWallet`.
class CWallet extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> nextId;
  Pointer<CEthChain> ethChain;
  Pointer<CEeeChain> eeeChain;
  Pointer<CBtcChain> btcChain;
  static Pointer<CWallet> allocate() {
    return ffi.allocate<CWallet>();
  }


  static CWallet from(int ptr) {
    return Pointer<CWallet>.fromAddress(ptr).ref;
  }

}

/// C function `CWallet_alloc`.
Pointer<CWallet> CWallet_alloc() {
  return _CWallet_alloc();
}
final _CWallet_alloc_Dart _CWallet_alloc = _dl.lookupFunction<_CWallet_alloc_C, _CWallet_alloc_Dart>('CWallet_alloc');
typedef _CWallet_alloc_C = Pointer<CWallet> Function();
typedef _CWallet_alloc_Dart = Pointer<CWallet> Function();

/// C function `CWallet_free`.
void CWallet_free(
  Pointer<CWallet> ptr,
) {
  _CWallet_free(ptr);
}
final _CWallet_free_Dart _CWallet_free = _dl.lookupFunction<_CWallet_free_C, _CWallet_free_Dart>('CWallet_free');
typedef _CWallet_free_C = Void Function(
  Pointer<CWallet> ptr,
);
typedef _CWallet_free_Dart = void Function(
  Pointer<CWallet> ptr,
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

/// C function `Wallets_createWallet`.
Pointer<CError> Wallets_createWallet(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> walletId,
) {
  return _Wallets_createWallet(ctx, parameters, walletId);
}
final _Wallets_createWallet_Dart _Wallets_createWallet = _dl.lookupFunction<_Wallets_createWallet_C, _Wallets_createWallet_Dart>('Wallets_createWallet');
typedef _Wallets_createWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> walletId,
);
typedef _Wallets_createWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CCreateWalletParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> walletId,
);

/// C function `Wallets_deleteWallet`.
Pointer<CError> Wallets_deleteWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
) {
  return _Wallets_deleteWallet(ctx, walletId);
}
final _Wallets_deleteWallet_Dart _Wallets_deleteWallet = _dl.lookupFunction<_Wallets_deleteWallet_C, _Wallets_deleteWallet_Dart>('Wallets_deleteWallet');
typedef _Wallets_deleteWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
);
typedef _Wallets_deleteWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
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

/// C function `Wallets_findByName`.
Pointer<CError> Wallets_findByName(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
) {
  return _Wallets_findByName(ctx, name, arrayWallet);
}
final _Wallets_findByName_Dart _Wallets_findByName = _dl.lookupFunction<_Wallets_findByName_C, _Wallets_findByName_Dart>('Wallets_findByName');
typedef _Wallets_findByName_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
);
typedef _Wallets_findByName_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> name,
  Pointer<Pointer<CArrayCWallet>> arrayWallet,
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

/// <p class="para-brief"> Success: true; Fail: false</p>
Pointer<CError> Wallets_hasOne(
  Pointer<CContext> ctx,
) {
  return _Wallets_hasOne(ctx);
}
final _Wallets_hasOne_Dart _Wallets_hasOne = _dl.lookupFunction<_Wallets_hasOne_C, _Wallets_hasOne_Dart>('Wallets_hasOne');
typedef _Wallets_hasOne_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_hasOne_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);

/// <p class="para-brief"> dart中不要复制Context的内存，会在调用 [Wallets_uninit] 释放内存</p>
Pointer<CError> Wallets_init(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> ctx,
) {
  return _Wallets_init(parameter, ctx);
}
final _Wallets_init_Dart _Wallets_init = _dl.lookupFunction<_Wallets_init_C, _Wallets_init_Dart>('Wallets_init');
typedef _Wallets_init_C = Pointer<CError> Function(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> ctx,
);
typedef _Wallets_init_Dart = Pointer<CError> Function(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> ctx,
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

/// C function `Wallets_uninit`.
Pointer<CError> Wallets_uninit(
  Pointer<CContext> ctx,
  Pointer<CUnInitParameters> parameter,
) {
  return _Wallets_uninit(ctx, parameter);
}
final _Wallets_uninit_Dart _Wallets_uninit = _dl.lookupFunction<_Wallets_uninit_C, _Wallets_uninit_Dart>('Wallets_uninit');
typedef _Wallets_uninit_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CUnInitParameters> parameter,
);
typedef _Wallets_uninit_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<CUnInitParameters> parameter,
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
