import 'dart:ffi'; // For FFI
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as pathLib;
import 'package:path_provider/path_provider.dart';

final DynamicLibrary _nativeAddLib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open("liborm_rustorm.so");
  } else if (Platform.isWindows) {
    return DynamicLibrary.open("orm_rustorm.dll");
  } else if (Platform.isLinux) {
    return DynamicLibrary.open("liborm_rustorm.so");
  } else {
    return DynamicLibrary.process();
  }
}();

final void Function(Pointer<Int8>) tryRustOrm = _nativeAddLib
    .lookup<NativeFunction<Void Function(Pointer<Int8>)>>("tryRustOrm")
    .asFunction();

final void Function() dTryRustOrm = () async {
  var filepath = (await getApplicationDocumentsDirectory()).path;
  filepath = pathLib.join(filepath,"orm_rustorm.db").substring(0);
  Pointer<Int8> s = Utf8.toUtf8(filepath).cast();
  tryRustOrm(s);
  free(s.cast<Pointer<Utf8>>());
};
