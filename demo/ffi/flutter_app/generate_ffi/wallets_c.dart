/// bindings for `cdl`
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;
// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
/// Reference to the Dynamic Library, it should be only used for low-level access
final DynamicLibrary dl = _dl;
DynamicLibrary _open() {
  if (Platform.isWindows) return DynamicLibrary.open('cdl.dll');
  if (Platform.isLinux) return DynamicLibrary.open('libcdl.so');
  if (Platform.isAndroid) return DynamicLibrary.open('libcdl.so');
  throw UnsupportedError('This platform is not supported.');
}
/// C struct `Data`.
class Data extends Struct {
  @Int32()
  int intType;
  Pointer<ffi.Utf8> charType;
  Pointer<Int32> arrayInt;
  @Uint64()
  int arrayIntLength;
  Pointer<Data> arrayData;
  @Uint64()
  int arrayDataLength;
  Pointer<Data> pointData;
  static Pointer<Data> allocate() {
    return ffi.calloc<Data>();
  }
  static Data from(int ptr) {
    return Pointer<Data>.fromAddress(ptr).ref;
  }
}
/// C function `Data_free`.
void Data_free(
  Pointer<Data> cd,
) {
  _Data_free(cd);
}
final _Data_free_Dart _Data_free = _dl.lookupFunction<_Data_free_C, _Data_free_Dart>('Data_free');
typedef _Data_free_C = Void Function(
  Pointer<Data> cd,
);
typedef _Data_free_Dart = void Function(
  Pointer<Data> cd,
);
/// C function `Data_new`.
Pointer<Data> Data_new() {
  return _Data_new();
}
final _Data_new_Dart _Data_new = _dl.lookupFunction<_Data_new_C, _Data_new_Dart>('Data_new');
typedef _Data_new_C = Pointer<Data> Function();
typedef _Data_new_Dart = Pointer<Data> Function();
/// C function `Data_use`.
Pointer<Data> Data_use(
  Pointer<Data> cd,
) {
  return _Data_use(cd);
}
final _Data_use_Dart _Data_use = _dl.lookupFunction<_Data_use_C, _Data_use_Dart>('Data_use');
typedef _Data_use_C = Pointer<Data> Function(
  Pointer<Data> cd,
);
typedef _Data_use_Dart = Pointer<Data> Function(
  Pointer<Data> cd,
);
/// C function `Str_free`.
void Str_free(
  Pointer<ffi.Utf8> cs,
) {
  _Str_free(cs);
}
final _Str_free_Dart _Str_free = _dl.lookupFunction<_Str_free_C, _Str_free_Dart>('Str_free');
typedef _Str_free_C = Void Function(
  Pointer<ffi.Utf8> cs,
);
typedef _Str_free_Dart = void Function(
  Pointer<ffi.Utf8> cs,
);
/// C function `add`.
int add(
  int a,
  int b,
) {
  return _add(a, b);
}
final _add_Dart _add = _dl.lookupFunction<_add_C, _add_Dart>('add');
typedef _add_C = Int32 Function(
  Int32 a,
  Int32 b,
);
typedef _add_Dart = int Function(
  int a,
  int b,
);
/// C function `addStr`.
Pointer<ffi.Utf8> addStr(
  Pointer<ffi.Utf8> cs,
) {
  return _addStr(cs);
}
final _addStr_Dart _addStr = _dl.lookupFunction<_addStr_C, _addStr_Dart>('addStr');
typedef _addStr_C = Pointer<ffi.Utf8> Function(
  Pointer<ffi.Utf8> cs,
);
typedef _addStr_Dart = Pointer<ffi.Utf8> Function(
  Pointer<ffi.Utf8> cs,
);
