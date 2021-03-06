import 'dart:ffi'; // For FFI
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as pathLib;
import 'package:path_provider/path_provider.dart';

final DynamicLibrary _nativeAddLib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open("liborm_rbatis.so");
  } else if (Platform.isWindows) {
    return DynamicLibrary.open("orm_rbatis.dll");
  } else if (Platform.isLinux) {
    return DynamicLibrary.open("liborm_rbatis.so");
  } else {
    return DynamicLibrary.process();
  }
}();

final void Function(Pointer<Int8>) tryRbatis = _nativeAddLib
    .lookup<NativeFunction<Void Function(Pointer<Int8>)>>("tryRbatis")
    .asFunction();

final void Function() dTryRbatis = () async {
  var filepath = (await getApplicationDocumentsDirectory()).path;
  filepath = pathLib.join(filepath, "orm_rbatis.db").substring(0);
  Pointer<Int8> s = filepath.toNativeUtf8().cast();
  tryRbatis(s);
  calloc.free(s.cast<Pointer<Utf8>>());
};
