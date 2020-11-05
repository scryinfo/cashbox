// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

class NativeLibrary {
  /// Holds the Dynamic library.
  final ffi.DynamicLibrary _dylib;

  /// The symbols are looked up in [dynamicLibrary].
  NativeLibrary(ffi.DynamicLibrary dynamicLibrary) : _dylib = dynamicLibrary;

  void Cool_function(
    int i,
    int c,
    ffi.Pointer<CoolStruct> cs,
  ) {
    _Cool_function ??= _dylib
        .lookupFunction<_c_Cool_function, _dart_Cool_function>('Cool_function');
    return _Cool_function(
      i,
      c,
      cs,
    );
  }

  _dart_Cool_function _Cool_function;
}

class CoolStruct extends ffi.Struct {
  @ffi.Int32()
  int x;

  @ffi.Int32()
  int y;

  ffi.Pointer<ffi.Int32> arrayInt;
}

typedef _c_Cool_function = ffi.Void Function(
  ffi.Int32 i,
  ffi.Int8 c,
  ffi.Pointer<CoolStruct> cs,
);

typedef _dart_Cool_function = void Function(
  int i,
  int c,
  ffi.Pointer<CoolStruct> cs,
);
