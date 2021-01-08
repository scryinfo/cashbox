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
  int ref_count;
  Pointer<ffi.Utf8> free_;
  Pointer<ffi.Utf8> reserved;
  Pointer<ffi.Utf8> misc_frozen;
  Pointer<ffi.Utf8> fee_frozen;

  static Pointer<CAccountInfo> allocate() {
    return ffi.allocate<CAccountInfo>();
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
    return ffi.allocate<CAccountInfoSyncProg>();
  }

  static CAccountInfoSyncProg from(int ptr) {
    return Pointer<CAccountInfoSyncProg>.fromAddress(ptr).ref;
  }
}

/// C function `CAccountInfoSyncProg_dAlloc`.
Pointer<Pointer<CAccountInfoSyncProg>> CAccountInfoSyncProg_dAlloc() {
  return _CAccountInfoSyncProg_dAlloc();
}

final _CAccountInfoSyncProg_dAlloc_Dart _CAccountInfoSyncProg_dAlloc =
    _dl.lookupFunction<_CAccountInfoSyncProg_dAlloc_C,
        _CAccountInfoSyncProg_dAlloc_Dart>('CAccountInfoSyncProg_dAlloc');

typedef _CAccountInfoSyncProg_dAlloc_C = Pointer<Pointer<CAccountInfoSyncProg>>
    Function();
typedef _CAccountInfoSyncProg_dAlloc_Dart
    = Pointer<Pointer<CAccountInfoSyncProg>> Function();

/// C function `CAccountInfo_dAlloc`.
Pointer<Pointer<CAccountInfo>> CAccountInfo_dAlloc() {
  return _CAccountInfo_dAlloc();
}

final _CAccountInfo_dAlloc_Dart _CAccountInfo_dAlloc =
    _dl.lookupFunction<_CAccountInfo_dAlloc_C, _CAccountInfo_dAlloc_Dart>(
        'CAccountInfo_dAlloc');

typedef _CAccountInfo_dAlloc_C = Pointer<Pointer<CAccountInfo>> Function();
typedef _CAccountInfo_dAlloc_Dart = Pointer<Pointer<CAccountInfo>> Function();

/// C function `CAccountInfo_dFree`.
void CAccountInfo_dFree(
  Pointer<Pointer<CAccountInfo>> dPtr,
) {
  _CAccountInfo_dFree(dPtr);
}

final _CAccountInfo_dFree_Dart _CAccountInfo_dFree =
    _dl.lookupFunction<_CAccountInfo_dFree_C, _CAccountInfo_dFree_Dart>(
        'CAccountInfo_dFree');

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
class CArrayCContext extends Struct {
  Pointer<CContext> ptr;
  @Uint64()
  int len;
  @Uint64()
  int cap;

  static Pointer<CArrayCContext> allocate() {
    return ffi.allocate<CArrayCContext>();
  }

  static CArrayCContext from(int ptr) {
    return Pointer<CArrayCContext>.fromAddress(ptr).ref;
  }
}

/// <p class="para-brief"> alloc ** [CArray]</p>
Pointer<Pointer<CArrayCContext>> CArrayCContext_dAlloc() {
  return _CArrayCContext_dAlloc();
}

final _CArrayCContext_dAlloc_Dart _CArrayCContext_dAlloc =
    _dl.lookupFunction<_CArrayCContext_dAlloc_C, _CArrayCContext_dAlloc_Dart>(
        'CArrayCContext_dAlloc');

typedef _CArrayCContext_dAlloc_C = Pointer<Pointer<CArrayCContext>> Function();
typedef _CArrayCContext_dAlloc_Dart = Pointer<Pointer<CArrayCContext>>
    Function();

/// C function `CArrayCContext_dFree`.
void CArrayCContext_dFree(
  Pointer<Pointer<CArrayCContext>> dPtr,
) {
  _CArrayCContext_dFree(dPtr);
}

final _CArrayCContext_dFree_Dart _CArrayCContext_dFree =
    _dl.lookupFunction<_CArrayCContext_dFree_C, _CArrayCContext_dFree_Dart>(
        'CArrayCContext_dFree');

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

final _CArrayCWallet_dAlloc_Dart _CArrayCWallet_dAlloc =
    _dl.lookupFunction<_CArrayCWallet_dAlloc_C, _CArrayCWallet_dAlloc_Dart>(
        'CArrayCWallet_dAlloc');

typedef _CArrayCWallet_dAlloc_C = Pointer<Pointer<CArrayCWallet>> Function();
typedef _CArrayCWallet_dAlloc_Dart = Pointer<Pointer<CArrayCWallet>> Function();

/// C function `CArrayCWallet_dFree`.
void CArrayCWallet_dFree(
  Pointer<Pointer<CArrayCWallet>> dPtr,
) {
  _CArrayCWallet_dFree(dPtr);
}

final _CArrayCWallet_dFree_Dart _CArrayCWallet_dFree =
    _dl.lookupFunction<_CArrayCWallet_dFree_C, _CArrayCWallet_dFree_Dart>(
        'CArrayCWallet_dFree');

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
    return ffi.allocate<CArrayI64>();
  }

  static CArrayI64 from(int ptr) {
    return Pointer<CArrayI64>.fromAddress(ptr).ref;
  }
}

/// C function `CArrayInt64_dAlloc`.
Pointer<Pointer<CArrayI64>> CArrayInt64_dAlloc() {
  return _CArrayInt64_dAlloc();
}

final _CArrayInt64_dAlloc_Dart _CArrayInt64_dAlloc =
    _dl.lookupFunction<_CArrayInt64_dAlloc_C, _CArrayInt64_dAlloc_Dart>(
        'CArrayInt64_dAlloc');

typedef _CArrayInt64_dAlloc_C = Pointer<Pointer<CArrayI64>> Function();
typedef _CArrayInt64_dAlloc_Dart = Pointer<Pointer<CArrayI64>> Function();

/// C function `CArrayInt64_dFree`.
void CArrayInt64_dFree(
  Pointer<Pointer<CArrayI64>> dPtr,
) {
  _CArrayInt64_dFree(dPtr);
}

final _CArrayInt64_dFree_Dart _CArrayInt64_dFree =
    _dl.lookupFunction<_CArrayInt64_dFree_C, _CArrayInt64_dFree_Dart>(
        'CArrayInt64_dFree');

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

final _CBool_dAlloc_Dart _CBool_dAlloc =
    _dl.lookupFunction<_CBool_dAlloc_C, _CBool_dAlloc_Dart>('CBool_dAlloc');

typedef _CBool_dAlloc_C = Pointer<Pointer<Uint32>> Function();
typedef _CBool_dAlloc_Dart = Pointer<Pointer<Uint32>> Function();

/// C function `CBool_dFree`.
void CBool_dFree(
  Pointer<Pointer<Uint32>> dcs,
) {
  _CBool_dFree(dcs);
}

final _CBool_dFree_Dart _CBool_dFree =
    _dl.lookupFunction<_CBool_dFree_C, _CBool_dFree_Dart>('CBool_dFree');

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

/// C struct `CChainVersion`.
class CChainVersion extends Struct {
  Pointer<ffi.Utf8> genesisHash;
  @Int32()
  int runtimeVersion;
  @Int32()
  int txVersion;

  static Pointer<CChainVersion> allocate() {
    return ffi.allocate<CChainVersion>();
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
    return ffi.allocate<CContext>();
  }

  static CContext from(int ptr) {
    return Pointer<CContext>.fromAddress(ptr).ref;
  }
}

/// <p class="para-brief"> alloc ** [parameters::CContext]</p>
Pointer<Pointer<CContext>> CContext_dAlloc() {
  return _CContext_dAlloc();
}

final _CContext_dAlloc_Dart _CContext_dAlloc =
    _dl.lookupFunction<_CContext_dAlloc_C, _CContext_dAlloc_Dart>(
        'CContext_dAlloc');

typedef _CContext_dAlloc_C = Pointer<Pointer<CContext>> Function();
typedef _CContext_dAlloc_Dart = Pointer<Pointer<CContext>> Function();

/// <p class="para-brief"> free ** [parameters::CContext]</p>
void CContext_dFree(
  Pointer<Pointer<CContext>> dPtr,
) {
  _CContext_dFree(dPtr);
}

final _CContext_dFree_Dart _CContext_dFree = _dl
    .lookupFunction<_CContext_dFree_C, _CContext_dFree_Dart>('CContext_dFree');

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
    return ffi.allocate<CCreateWalletParameters>();
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
    return ffi.allocate<CDbName>();
  }

  static CDbName from(int ptr) {
    return Pointer<CDbName>.fromAddress(ptr).ref;
  }
}

/// C function `CDbName_dAlloc`.
Pointer<Pointer<CDbName>> CDbName_dAlloc() {
  return _CDbName_dAlloc();
}

final _CDbName_dAlloc_Dart _CDbName_dAlloc = _dl
    .lookupFunction<_CDbName_dAlloc_C, _CDbName_dAlloc_Dart>('CDbName_dAlloc');

typedef _CDbName_dAlloc_C = Pointer<Pointer<CDbName>> Function();
typedef _CDbName_dAlloc_Dart = Pointer<Pointer<CDbName>> Function();

/// C function `CDbName_dFree`.
void CDbName_dFree(
  Pointer<Pointer<CDbName>> dPtr,
) {
  _CDbName_dFree(dPtr);
}

final _CDbName_dFree_Dart _CDbName_dFree =
    _dl.lookupFunction<_CDbName_dFree_C, _CDbName_dFree_Dart>('CDbName_dFree');

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
    return ffi.allocate<CDecodeAccountInfoParameters>();
  }

  static CDecodeAccountInfoParameters from(int ptr) {
    return Pointer<CDecodeAccountInfoParameters>.fromAddress(ptr).ref;
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

final _CError_free_Dart _CError_free =
    _dl.lookupFunction<_CError_free_C, _CError_free_Dart>('CError_free');

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
  Pointer<ffi.Utf8> contextNote;

  static Pointer<CInitParameters> allocate() {
    return ffi.allocate<CInitParameters>();
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
    return ffi.allocate<CRawTxParam>();
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
    return ffi.allocate<CStorageKeyParameters>();
  }

  static CStorageKeyParameters from(int ptr) {
    return Pointer<CStorageKeyParameters>.fromAddress(ptr).ref;
  }
}

/// C function `CStr_dAlloc`.
Pointer<Pointer<ffi.Utf8>> CStr_dAlloc() {
  return _CStr_dAlloc();
}

final _CStr_dAlloc_Dart _CStr_dAlloc =
    _dl.lookupFunction<_CStr_dAlloc_C, _CStr_dAlloc_Dart>('CStr_dAlloc');

typedef _CStr_dAlloc_C = Pointer<Pointer<ffi.Utf8>> Function();
typedef _CStr_dAlloc_Dart = Pointer<Pointer<ffi.Utf8>> Function();

/// C function `CStr_dFree`.
void CStr_dFree(
  Pointer<Pointer<ffi.Utf8>> dcs,
) {
  _CStr_dFree(dcs);
}

final _CStr_dFree_Dart _CStr_dFree =
    _dl.lookupFunction<_CStr_dFree_C, _CStr_dFree_Dart>('CStr_dFree');

typedef _CStr_dFree_C = Void Function(
  Pointer<Pointer<ffi.Utf8>> dcs,
);
typedef _CStr_dFree_Dart = void Function(
  Pointer<Pointer<ffi.Utf8>> dcs,
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
    return ffi.allocate<CSubChainBasicInfo>();
  }

  static CSubChainBasicInfo from(int ptr) {
    return Pointer<CSubChainBasicInfo>.fromAddress(ptr).ref;
  }
}

/// C function `CSubChainBasicInfo_dAlloc`.
Pointer<Pointer<CSubChainBasicInfo>> CSubChainBasicInfo_dAlloc() {
  return _CSubChainBasicInfo_dAlloc();
}

final _CSubChainBasicInfo_dAlloc_Dart _CSubChainBasicInfo_dAlloc =
    _dl.lookupFunction<_CSubChainBasicInfo_dAlloc_C,
        _CSubChainBasicInfo_dAlloc_Dart>('CSubChainBasicInfo_dAlloc');

typedef _CSubChainBasicInfo_dAlloc_C = Pointer<Pointer<CSubChainBasicInfo>>
    Function();
typedef _CSubChainBasicInfo_dAlloc_Dart = Pointer<Pointer<CSubChainBasicInfo>>
    Function();

/// C function `CSubChainBasicInfo_dFree`.
void CSubChainBasicInfo_dFree(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
) {
  _CSubChainBasicInfo_dFree(dPtr);
}

final _CSubChainBasicInfo_dFree_Dart _CSubChainBasicInfo_dFree =
    _dl.lookupFunction<_CSubChainBasicInfo_dFree_C,
        _CSubChainBasicInfo_dFree_Dart>('CSubChainBasicInfo_dFree');

typedef _CSubChainBasicInfo_dFree_C = Void Function(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
);
typedef _CSubChainBasicInfo_dFree_Dart = void Function(
  Pointer<Pointer<CSubChainBasicInfo>> dPtr,
);

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
    return ffi.allocate<CTokenShared>();
  }

  static CTokenShared from(int ptr) {
    return Pointer<CTokenShared>.fromAddress(ptr).ref;
  }
}

/// C struct `CTransferPayload`.
class CTransferPayload extends Struct {
  Pointer<ffi.Utf8> fromAccount;
  Pointer<ffi.Utf8> toAccount;
  Pointer<ffi.Utf8> value;
  @Uint32()
  int index;
  Pointer<CChainVersion> chainVersion;
  Pointer<ffi.Utf8> extData;
  Pointer<ffi.Utf8> password;

  static Pointer<CTransferPayload> allocate() {
    return ffi.allocate<CTransferPayload>();
  }

  static CTransferPayload from(int ptr) {
    return Pointer<CTransferPayload>.fromAddress(ptr).ref;
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
    return ffi.allocate<CWallet>();
  }

  static CWallet from(int ptr) {
    return Pointer<CWallet>.fromAddress(ptr).ref;
  }
}

/// C function `CWallet_dAlloc`.
Pointer<Pointer<CWallet>> CWallet_dAlloc() {
  return _CWallet_dAlloc();
}

final _CWallet_dAlloc_Dart _CWallet_dAlloc = _dl
    .lookupFunction<_CWallet_dAlloc_C, _CWallet_dAlloc_Dart>('CWallet_dAlloc');

typedef _CWallet_dAlloc_C = Pointer<Pointer<CWallet>> Function();
typedef _CWallet_dAlloc_Dart = Pointer<Pointer<CWallet>> Function();

/// C function `CWallet_dFree`.
void CWallet_dFree(
  Pointer<Pointer<CWallet>> dPtr,
) {
  _CWallet_dFree(dPtr);
}

final _CWallet_dFree_Dart _CWallet_dFree =
    _dl.lookupFunction<_CWallet_dFree_C, _CWallet_dFree_Dart>('CWallet_dFree');

typedef _CWallet_dFree_C = Void Function(
  Pointer<Pointer<CWallet>> dPtr,
);
typedef _CWallet_dFree_Dart = void Function(
  Pointer<Pointer<CWallet>> dPtr,
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

final _ChainEee_decodeAccountInfo_Dart _ChainEee_decodeAccountInfo =
    _dl.lookupFunction<_ChainEee_decodeAccountInfo_C,
        _ChainEee_decodeAccountInfo_Dart>('ChainEee_decodeAccountInfo');

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
  Pointer<CTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_eeeTransfer(ctx, netType, transferPayload, signedResult);
}

final _ChainEee_eeeTransfer_Dart _ChainEee_eeeTransfer =
    _dl.lookupFunction<_ChainEee_eeeTransfer_C, _ChainEee_eeeTransfer_Dart>(
        'ChainEee_eeeTransfer');

typedef _ChainEee_eeeTransfer_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_eeeTransfer_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
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

final _ChainEee_getBasicInfo_Dart _ChainEee_getBasicInfo =
    _dl.lookupFunction<_ChainEee_getBasicInfo_C, _ChainEee_getBasicInfo_Dart>(
        'ChainEee_getBasicInfo');

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

/// C function `ChainEee_getStorageKey`.
Pointer<CError> ChainEee_getStorageKey(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CStorageKeyParameters> parameters,
  Pointer<Pointer<ffi.Utf8>> key,
) {
  return _ChainEee_getStorageKey(ctx, netType, parameters, key);
}

final _ChainEee_getStorageKey_Dart _ChainEee_getStorageKey =
    _dl.lookupFunction<_ChainEee_getStorageKey_C, _ChainEee_getStorageKey_Dart>(
        'ChainEee_getStorageKey');

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

final _ChainEee_getSyncRecord_Dart _ChainEee_getSyncRecord =
    _dl.lookupFunction<_ChainEee_getSyncRecord_C, _ChainEee_getSyncRecord_Dart>(
        'ChainEee_getSyncRecord');

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

/// C function `ChainEee_tokenXTransfer`.
Pointer<CError> ChainEee_tokenXTransfer(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
) {
  return _ChainEee_tokenXTransfer(ctx, netType, transferPayload, signedResult);
}

final _ChainEee_tokenXTransfer_Dart _ChainEee_tokenXTransfer = _dl
    .lookupFunction<_ChainEee_tokenXTransfer_C, _ChainEee_tokenXTransfer_Dart>(
        'ChainEee_tokenXTransfer');

typedef _ChainEee_tokenXTransfer_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTransferPayload> transferPayload,
  Pointer<Pointer<ffi.Utf8>> signedResult,
);
typedef _ChainEee_tokenXTransfer_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CTransferPayload> transferPayload,
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

final _ChainEee_txSign_Dart _ChainEee_txSign =
    _dl.lookupFunction<_ChainEee_txSign_C, _ChainEee_txSign_Dart>(
        'ChainEee_txSign');

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

final _ChainEee_txSubmittableSign_Dart _ChainEee_txSubmittableSign =
    _dl.lookupFunction<_ChainEee_txSubmittableSign_C,
        _ChainEee_txSubmittableSign_Dart>('ChainEee_txSubmittableSign');

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

/// C function `ChainEee_updateBasicInfo`.
Pointer<CError> ChainEee_updateBasicInfo(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CSubChainBasicInfo> basicInfo,
) {
  return _ChainEee_updateBasicInfo(ctx, netType, basicInfo);
}

final _ChainEee_updateBasicInfo_Dart _ChainEee_updateBasicInfo =
    _dl.lookupFunction<_ChainEee_updateBasicInfo_C,
        _ChainEee_updateBasicInfo_Dart>('ChainEee_updateBasicInfo');

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

/// C function `ChainEee_updateSyncRecord`.
Pointer<CError> ChainEee_updateSyncRecord(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> netType,
  Pointer<CAccountInfoSyncProg> syncRecord,
) {
  return _ChainEee_updateSyncRecord(ctx, netType, syncRecord);
}

final _ChainEee_updateSyncRecord_Dart _ChainEee_updateSyncRecord =
    _dl.lookupFunction<_ChainEee_updateSyncRecord_C,
        _ChainEee_updateSyncRecord_Dart>('ChainEee_updateSyncRecord');

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

/// <p class="para-brief"> 返回所有的Context, 有可能是0个 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_Contexts(
  Pointer<Pointer<CArrayCContext>> contexts,
) {
  return _Wallets_Contexts(contexts);
}

final _Wallets_Contexts_Dart _Wallets_Contexts =
    _dl.lookupFunction<_Wallets_Contexts_C, _Wallets_Contexts_Dart>(
        'Wallets_Contexts');

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

final _Wallets_all_Dart _Wallets_all =
    _dl.lookupFunction<_Wallets_all_C, _Wallets_all_Dart>('Wallets_all');

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
  Pointer<Pointer<CWallet>> wallet,
) {
  return _Wallets_createWallet(ctx, parameters, wallet);
}

final _Wallets_createWallet_Dart _Wallets_createWallet =
    _dl.lookupFunction<_Wallets_createWallet_C, _Wallets_createWallet_Dart>(
        'Wallets_createWallet');

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

final _Wallets_currentWalletChain_Dart _Wallets_currentWalletChain =
    _dl.lookupFunction<_Wallets_currentWalletChain_C,
        _Wallets_currentWalletChain_Dart>('Wallets_currentWalletChain');

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

final _Wallets_dbName_Dart _Wallets_dbName = _dl
    .lookupFunction<_Wallets_dbName_C, _Wallets_dbName_Dart>('Wallets_dbName');

typedef _Wallets_dbName_C = Pointer<CError> Function(
  Pointer<CDbName> name,
  Pointer<Pointer<CDbName>> outName,
);
typedef _Wallets_dbName_Dart = Pointer<CError> Function(
  Pointer<CDbName> name,
  Pointer<Pointer<CDbName>> outName,
);

/// C function `Wallets_findById`.
Pointer<CError> Wallets_findById(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<Pointer<CWallet>> wallet,
) {
  return _Wallets_findById(ctx, walletId, wallet);
}

final _Wallets_findById_Dart _Wallets_findById =
    _dl.lookupFunction<_Wallets_findById_C, _Wallets_findById_Dart>(
        'Wallets_findById');

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

final _Wallets_findWalletBaseByName_Dart _Wallets_findWalletBaseByName =
    _dl.lookupFunction<_Wallets_findWalletBaseByName_C,
        _Wallets_findWalletBaseByName_Dart>('Wallets_findWalletBaseByName');

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

final _Wallets_firstContext_Dart _Wallets_firstContext =
    _dl.lookupFunction<_Wallets_firstContext_C, _Wallets_firstContext_Dart>(
        'Wallets_firstContext');

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

final _Wallets_generateMnemonic_Dart _Wallets_generateMnemonic =
    _dl.lookupFunction<_Wallets_generateMnemonic_C,
        _Wallets_generateMnemonic_Dart>('Wallets_generateMnemonic');

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

final _Wallets_hasAny_Dart _Wallets_hasAny = _dl
    .lookupFunction<_Wallets_hasAny_C, _Wallets_hasAny_Dart>('Wallets_hasAny');

typedef _Wallets_hasAny_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Uint32> hasAny,
);
typedef _Wallets_hasAny_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<Uint32> hasAny,
);

/// <p class="para-brief"> 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_init(
  Pointer<CInitParameters> parameter,
  Pointer<Pointer<CContext>> context,
) {
  return _Wallets_init(parameter, context);
}

final _Wallets_init_Dart _Wallets_init =
    _dl.lookupFunction<_Wallets_init_C, _Wallets_init_Dart>('Wallets_init');

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

final _Wallets_lastContext_Dart _Wallets_lastContext =
    _dl.lookupFunction<_Wallets_lastContext_C, _Wallets_lastContext_Dart>(
        'Wallets_lastContext');

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

final _Wallets_lockRead_Dart _Wallets_lockRead =
    _dl.lookupFunction<_Wallets_lockRead_C, _Wallets_lockRead_Dart>(
        'Wallets_lockRead');

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

final _Wallets_lockWrite_Dart _Wallets_lockWrite =
    _dl.lookupFunction<_Wallets_lockWrite_C, _Wallets_lockWrite_Dart>(
        'Wallets_lockWrite');

typedef _Wallets_lockWrite_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_lockWrite_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);

/// C function `Wallets_removeWallet`.
Pointer<CError> Wallets_removeWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
) {
  return _Wallets_removeWallet(ctx, walletId);
}

final _Wallets_removeWallet_Dart _Wallets_removeWallet =
    _dl.lookupFunction<_Wallets_removeWallet_C, _Wallets_removeWallet_Dart>(
        'Wallets_removeWallet');

typedef _Wallets_removeWallet_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
);
typedef _Wallets_removeWallet_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
);

/// C function `Wallets_renameWallet`.
Pointer<CError> Wallets_renameWallet(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> newName,
  Pointer<ffi.Utf8> walletId,
) {
  return _Wallets_renameWallet(ctx, newName, walletId);
}

final _Wallets_renameWallet_Dart _Wallets_renameWallet =
    _dl.lookupFunction<_Wallets_renameWallet_C, _Wallets_renameWallet_Dart>(
        'Wallets_renameWallet');

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

/// <p class="para-brief">保存当前wallet 与 chain</p>
Pointer<CError> Wallets_saveCurrentWalletChain(
  Pointer<CContext> ctx,
  Pointer<ffi.Utf8> walletId,
  Pointer<ffi.Utf8> chainType,
) {
  return _Wallets_saveCurrentWalletChain(ctx, walletId, chainType);
}

final _Wallets_saveCurrentWalletChain_Dart _Wallets_saveCurrentWalletChain =
    _dl.lookupFunction<_Wallets_saveCurrentWalletChain_C,
        _Wallets_saveCurrentWalletChain_Dart>('Wallets_saveCurrentWalletChain');

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

/// <p class="para-brief"> 如果成功返回 [wallets_types::Error::SUCCESS()]</p>
Pointer<CError> Wallets_uninit(
  Pointer<CContext> ctx,
) {
  return _Wallets_uninit(ctx);
}

final _Wallets_uninit_Dart _Wallets_uninit = _dl
    .lookupFunction<_Wallets_uninit_C, _Wallets_uninit_Dart>('Wallets_uninit');

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

final _Wallets_unlockRead_Dart _Wallets_unlockRead =
    _dl.lookupFunction<_Wallets_unlockRead_C, _Wallets_unlockRead_Dart>(
        'Wallets_unlockRead');

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

final _Wallets_unlockWrite_Dart _Wallets_unlockWrite =
    _dl.lookupFunction<_Wallets_unlockWrite_C, _Wallets_unlockWrite_Dart>(
        'Wallets_unlockWrite');

typedef _Wallets_unlockWrite_C = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
typedef _Wallets_unlockWrite_Dart = Pointer<CError> Function(
  Pointer<CContext> ctx,
);
