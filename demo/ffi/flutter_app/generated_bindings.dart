// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Bindings to `headers/example.h`.
class NativeLibrary {
  /// Holds the Dynamic library.
  final ffi.DynamicLibrary _dylib;

  /// The symbols are looked up in [dynamicLibrary].
  NativeLibrary(ffi.DynamicLibrary dynamicLibrary) : _dylib = dynamicLibrary;

  void cool_function(
    int i,
    int c,
    ffi.Pointer<CoolStruct> cs,
  ) {
    _cool_function ??= _dylib
        .lookupFunction<_c_cool_function, _dart_cool_function>('cool_function');
    return _cool_function(
      i,
      c,
      cs,
    );
  }

  _dart_cool_function _cool_function;
}

class CoolStruct extends ffi.Struct {
  @ffi.Int32()
  int x;

  @ffi.Int32()
  int y;

  ffi.Pointer<ffi.Int32> int_array;
}

typedef _c_cool_function = ffi.Void Function(
  ffi.Int32 i,
  ffi.Int8 c,
  ffi.Pointer<CoolStruct> cs,
);

typedef _dart_cool_function = void Function(
  int i,
  int c,
  ffi.Pointer<CoolStruct> cs,
);
