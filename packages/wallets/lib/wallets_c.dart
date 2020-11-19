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

/// C function `CChar_free`.
void CChar_free(
  Pointer<ffi.Utf8> cs,
) {
  _CChar_free(cs);
}

final _CChar_free_Dart _CChar_free =
    _dl.lookupFunction<_CChar_free_C, _CChar_free_Dart>('CChar_free');

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

final _CError_free_Dart _CError_free =
    _dl.lookupFunction<_CError_free_C, _CError_free_Dart>('CError_free');

typedef _CError_free_C = Void Function(
  Pointer<CError> error,
);
typedef _CError_free_Dart = void Function(
  Pointer<CError> error,
);

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

/// C function `Wallets_init`.
Pointer<CError> Wallets_init(
  Pointer<InitParameters> params,
) {
  return _Wallets_init(params);
}

final _Wallets_init_Dart _Wallets_init =
    _dl.lookupFunction<_Wallets_init_C, _Wallets_init_Dart>('Wallets_init');

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

final _Wallets_lockRead_Dart _Wallets_lockRead =
    _dl.lookupFunction<_Wallets_lockRead_C, _Wallets_lockRead_Dart>(
        'Wallets_lockRead');

typedef _Wallets_lockRead_C = Uint16 Function();
typedef _Wallets_lockRead_Dart = int Function();

/// C function `Wallets_lockWrite`.
int Wallets_lockWrite() {
  return _Wallets_lockWrite();
}

final _Wallets_lockWrite_Dart _Wallets_lockWrite =
    _dl.lookupFunction<_Wallets_lockWrite_C, _Wallets_lockWrite_Dart>(
        'Wallets_lockWrite');

typedef _Wallets_lockWrite_C = Uint16 Function();
typedef _Wallets_lockWrite_Dart = int Function();

/// C function `Wallets_uninit`.
Pointer<CError> Wallets_uninit(
  Pointer<UnInitParameters> params,
) {
  return _Wallets_uninit(params);
}

final _Wallets_uninit_Dart _Wallets_uninit = _dl
    .lookupFunction<_Wallets_uninit_C, _Wallets_uninit_Dart>('Wallets_uninit');

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

final _Wallets_unlockRead_Dart _Wallets_unlockRead =
    _dl.lookupFunction<_Wallets_unlockRead_C, _Wallets_unlockRead_Dart>(
        'Wallets_unlockRead');

typedef _Wallets_unlockRead_C = Uint16 Function();
typedef _Wallets_unlockRead_Dart = int Function();

/// C function `Wallets_unlockWrite`.
int Wallets_unlockWrite() {
  return _Wallets_unlockWrite();
}

final _Wallets_unlockWrite_Dart _Wallets_unlockWrite =
    _dl.lookupFunction<_Wallets_unlockWrite_C, _Wallets_unlockWrite_Dart>(
        'Wallets_unlockWrite');

typedef _Wallets_unlockWrite_C = Uint16 Function();
typedef _Wallets_unlockWrite_Dart = int Function();
