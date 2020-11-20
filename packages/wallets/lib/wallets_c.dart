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

/// C struct `Address`.
class Address extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<ffi.Utf8> address;
  Pointer<ffi.Utf8> publicKey;
  static Pointer<Address> allocate() {
    return ffi.allocate<Address>();
  }


  static Address from(int ptr) {
    return Pointer<Address>.fromAddress(ptr).ref;
  }

}

/// C struct `BtcChain`.
class BtcChain extends Struct {
  
  Pointer<ChainShared> chainShared;
  Pointer<CArrayBtcChainToken> tokens;
  static Pointer<BtcChain> allocate() {
    return ffi.allocate<BtcChain>();
  }


  static BtcChain from(int ptr) {
    return Pointer<BtcChain>.fromAddress(ptr).ref;
  }

}

/// C struct `BtcChainToken`.
class BtcChainToken extends Struct {
  
  Pointer<TokenShared> tokenShared;
  static Pointer<BtcChainToken> allocate() {
    return ffi.allocate<BtcChainToken>();
  }


  static BtcChainToken from(int ptr) {
    return Pointer<BtcChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayBtcChainToken extends Struct {
  
  Pointer<BtcChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayBtcChainToken> allocate() {
    return ffi.allocate<CArrayBtcChainToken>();
  }


  static CArrayBtcChainToken from(int ptr) {
    return Pointer<CArrayBtcChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayEeeChainToken extends Struct {
  
  Pointer<EeeChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayEeeChainToken> allocate() {
    return ffi.allocate<CArrayEeeChainToken>();
  }


  static CArrayEeeChainToken from(int ptr) {
    return Pointer<CArrayEeeChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayEthChainToken extends Struct {
  
  Pointer<EthChainToken> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayEthChainToken> allocate() {
    return ffi.allocate<CArrayEthChainToken>();
  }


  static CArrayEthChainToken from(int ptr) {
    return Pointer<CArrayEthChainToken>.fromAddress(ptr).ref;
  }

}

/// <p class="para-brief"> c的数组需要定义两个字段，所定义一个结构体进行统一管理 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替</p>
class CArrayWallet extends Struct {
  
  Pointer<Wallet> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;
  static Pointer<CArrayWallet> allocate() {
    return ffi.allocate<CArrayWallet>();
  }


  static CArrayWallet from(int ptr) {
    return Pointer<CArrayWallet>.fromAddress(ptr).ref;
  }

}

/// C function `CArrayWallet_alloc`.
Pointer<CArrayWallet> CArrayWallet_alloc() {
  return _CArrayWallet_alloc();
}
final _CArrayWallet_alloc_Dart _CArrayWallet_alloc = _dl.lookupFunction<_CArrayWallet_alloc_C, _CArrayWallet_alloc_Dart>('CArrayWallet_alloc');
typedef _CArrayWallet_alloc_C = Pointer<CArrayWallet> Function();
typedef _CArrayWallet_alloc_Dart = Pointer<CArrayWallet> Function();

/// C function `CArrayWallet_free`.
void CArrayWallet_free(
  Pointer<CArrayWallet> ptr,
) {
  _CArrayWallet_free(ptr);
}
final _CArrayWallet_free_Dart _CArrayWallet_free = _dl.lookupFunction<_CArrayWallet_free_C, _CArrayWallet_free_Dart>('CArrayWallet_free');
typedef _CArrayWallet_free_C = Void Function(
  Pointer<CArrayWallet> ptr,
);
typedef _CArrayWallet_free_Dart = void Function(
  Pointer<CArrayWallet> ptr,
);

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

/// C struct `ChainShared`.
class ChainShared extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> walletId;
  Pointer<ffi.Utf8> chainType;
  Pointer<Address> walletAddress;
  static Pointer<ChainShared> allocate() {
    return ffi.allocate<ChainShared>();
  }


  static ChainShared from(int ptr) {
    return Pointer<ChainShared>.fromAddress(ptr).ref;
  }

}

/// C struct `Context`.
class Context extends Struct {
  
  static Pointer<Context> allocate() {
    return ffi.allocate<Context>();
  }


  static Context from(int ptr) {
    return Pointer<Context>.fromAddress(ptr).ref;
  }

}

/// C struct `EeeChain`.
class EeeChain extends Struct {
  
  Pointer<ChainShared> chainShared;
  Pointer<Address> address;
  Pointer<CArrayEeeChainToken> tokens;
  static Pointer<EeeChain> allocate() {
    return ffi.allocate<EeeChain>();
  }


  static EeeChain from(int ptr) {
    return Pointer<EeeChain>.fromAddress(ptr).ref;
  }

}

/// C struct `EeeChainToken`.
class EeeChainToken extends Struct {
  
  Pointer<TokenShared> tokenShared;
  static Pointer<EeeChainToken> allocate() {
    return ffi.allocate<EeeChainToken>();
  }


  static EeeChainToken from(int ptr) {
    return Pointer<EeeChainToken>.fromAddress(ptr).ref;
  }

}

/// C struct `EthChain`.
class EthChain extends Struct {
  
  Pointer<ChainShared> chain_shared;
  Pointer<CArrayEthChainToken> tokens;
  static Pointer<EthChain> allocate() {
    return ffi.allocate<EthChain>();
  }


  static EthChain from(int ptr) {
    return Pointer<EthChain>.fromAddress(ptr).ref;
  }

}

/// C struct `EthChainToken`.
class EthChainToken extends Struct {
  
  Pointer<TokenShared> tokenShared;
  static Pointer<EthChainToken> allocate() {
    return ffi.allocate<EthChainToken>();
  }


  static EthChainToken from(int ptr) {
    return Pointer<EthChainToken>.fromAddress(ptr).ref;
  }

}

/// C struct `InitParameters`.
class InitParameters extends Struct {
  
  @Uint64()
  int code;
  static Pointer<InitParameters> allocate() {
    return ffi.allocate<InitParameters>();
  }


  static InitParameters from(int ptr) {
    return Pointer<InitParameters>.fromAddress(ptr).ref;
  }

}

/// C struct `TokenShared`.
class TokenShared extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> nextId;
  Pointer<ffi.Utf8> name;
  Pointer<ffi.Utf8> symbol;
  static Pointer<TokenShared> allocate() {
    return ffi.allocate<TokenShared>();
  }


  static TokenShared from(int ptr) {
    return Pointer<TokenShared>.fromAddress(ptr).ref;
  }

}

/// C struct `UnInitParameters`.
class UnInitParameters extends Struct {
  
  @Uint64()
  int code;
  static Pointer<UnInitParameters> allocate() {
    return ffi.allocate<UnInitParameters>();
  }


  static UnInitParameters from(int ptr) {
    return Pointer<UnInitParameters>.fromAddress(ptr).ref;
  }

}

/// C struct `Wallet`.
class Wallet extends Struct {
  
  Pointer<ffi.Utf8> id;
  Pointer<ffi.Utf8> nextId;
  Pointer<EthChain> ethChains;
  Pointer<EeeChain> eeeChains;
  Pointer<BtcChain> btcChains;
  static Pointer<Wallet> allocate() {
    return ffi.allocate<Wallet>();
  }


  static Wallet from(int ptr) {
    return Pointer<Wallet>.fromAddress(ptr).ref;
  }

}

/// C function `Wallet_alloc`.
Pointer<Wallet> Wallet_alloc() {
  return _Wallet_alloc();
}
final _Wallet_alloc_Dart _Wallet_alloc = _dl.lookupFunction<_Wallet_alloc_C, _Wallet_alloc_Dart>('Wallet_alloc');
typedef _Wallet_alloc_C = Pointer<Wallet> Function();
typedef _Wallet_alloc_Dart = Pointer<Wallet> Function();

/// C function `Wallet_free`.
void Wallet_free(
  Pointer<Wallet> ptr,
) {
  _Wallet_free(ptr);
}
final _Wallet_free_Dart _Wallet_free = _dl.lookupFunction<_Wallet_free_C, _Wallet_free_Dart>('Wallet_free');
typedef _Wallet_free_C = Void Function(
  Pointer<Wallet> ptr,
);
typedef _Wallet_free_Dart = void Function(
  Pointer<Wallet> ptr,
);

/// C function `Wallets_all`.
Pointer<CError> Wallets_all(
  Pointer<Context> ctx,
  Pointer<CArrayWallet> ptr,
) {
  return _Wallets_all(ctx, ptr);
}
final _Wallets_all_Dart _Wallets_all = _dl.lookupFunction<_Wallets_all_C, _Wallets_all_Dart>('Wallets_all');
typedef _Wallets_all_C = Pointer<CError> Function(
  Pointer<Context> ctx,
  Pointer<CArrayWallet> ptr,
);
typedef _Wallets_all_Dart = Pointer<CError> Function(
  Pointer<Context> ctx,
  Pointer<CArrayWallet> ptr,
);

/// C function `Wallets_init`.
Pointer<CError> Wallets_init(
  Pointer<InitParameters> params,
) {
  return _Wallets_init(params);
}
final _Wallets_init_Dart _Wallets_init = _dl.lookupFunction<_Wallets_init_C, _Wallets_init_Dart>('Wallets_init');
typedef _Wallets_init_C = Pointer<CError> Function(
  Pointer<InitParameters> params,
);
typedef _Wallets_init_Dart = Pointer<CError> Function(
  Pointer<InitParameters> params,
);

/// C function `Wallets_lockRead`.
int Wallets_lockRead() {
  return _Wallets_lockRead();
}
final _Wallets_lockRead_Dart _Wallets_lockRead = _dl.lookupFunction<_Wallets_lockRead_C, _Wallets_lockRead_Dart>('Wallets_lockRead');
typedef _Wallets_lockRead_C = Uint16 Function();
typedef _Wallets_lockRead_Dart = int Function();

/// C function `Wallets_lockWrite`.
int Wallets_lockWrite() {
  return _Wallets_lockWrite();
}
final _Wallets_lockWrite_Dart _Wallets_lockWrite = _dl.lookupFunction<_Wallets_lockWrite_C, _Wallets_lockWrite_Dart>('Wallets_lockWrite');
typedef _Wallets_lockWrite_C = Uint16 Function();
typedef _Wallets_lockWrite_Dart = int Function();

/// C function `Wallets_uninit`.
Pointer<CError> Wallets_uninit(
  Pointer<UnInitParameters> params,
) {
  return _Wallets_uninit(params);
}
final _Wallets_uninit_Dart _Wallets_uninit = _dl.lookupFunction<_Wallets_uninit_C, _Wallets_uninit_Dart>('Wallets_uninit');
typedef _Wallets_uninit_C = Pointer<CError> Function(
  Pointer<UnInitParameters> params,
);
typedef _Wallets_uninit_Dart = Pointer<CError> Function(
  Pointer<UnInitParameters> params,
);

/// C function `Wallets_unlockRead`.
int Wallets_unlockRead() {
  return _Wallets_unlockRead();
}
final _Wallets_unlockRead_Dart _Wallets_unlockRead = _dl.lookupFunction<_Wallets_unlockRead_C, _Wallets_unlockRead_Dart>('Wallets_unlockRead');
typedef _Wallets_unlockRead_C = Uint16 Function();
typedef _Wallets_unlockRead_Dart = int Function();

/// C function `Wallets_unlockWrite`.
int Wallets_unlockWrite() {
  return _Wallets_unlockWrite();
}
final _Wallets_unlockWrite_Dart _Wallets_unlockWrite = _dl.lookupFunction<_Wallets_unlockWrite_C, _Wallets_unlockWrite_Dart>('Wallets_unlockWrite');
typedef _Wallets_unlockWrite_C = Uint16 Function();
typedef _Wallets_unlockWrite_Dart = int Function();
