import 'dart:ffi'; // For FFI
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as pathLib;
import 'package:path_provider/path_provider.dart';

final DynamicLibrary _nativeAddLib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open("liborm_diesel.so");
  } else if (Platform.isWindows) {
    return DynamicLibrary.open("orm_diesel.dll");
  } else if (Platform.isLinux) {
    return DynamicLibrary.open("liborm_diesel.so");
  } else {
    return DynamicLibrary.process();
  }
}();

final void Function(Pointer<Int8>) tryDiesel = _nativeAddLib
    .lookup<NativeFunction<Void Function(Pointer<Int8>)>>("tryDiesel")
    .asFunction();

final void Function() dTryDiesel = () async {
  var filepath = (await getApplicationDocumentsDirectory()).path;
  filepath = pathLib.join(filepath, "orm_diesel.db").substring(0);
  Pointer<Int8> s = filepath.toNativeUtf8().cast();
  tryDiesel(s);
  calloc.free(s.cast<Pointer<Utf8>>());
};
