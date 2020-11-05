import 'dart:ffi'; // For FFI
import 'dart:io';

final DynamicLibrary nativeAddLib = () {
  if(Platform.isAndroid){
    return DynamicLibrary.open("libcdl.so");
  }else if(Platform.isWindows){
    //demo/ffi/cdl/target/x86_64-pc-windows-gnu/debug/cdl.dll
    var path = Platform.script.resolve("../cdl/target/x86_64-pc-windows-gnu/debug/cdl.dll").path;
    return DynamicLibrary.open("D:/scryinfo/cashbox/demo/ffi/cdl/target/x86_64-pc-windows-gnu/debug/cdl.dll");
  }else if(Platform.isLinux){
    return DynamicLibrary.open("libcdl.so");
  }else{
    return DynamicLibrary.process();
  }
}();

final int Function(int x, int y) add =
nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("add")
    .asFunction();