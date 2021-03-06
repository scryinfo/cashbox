import 'dart:ffi'; // For FFI
import 'dart:io';

final DynamicLibrary nativeAddLib = () {
  if (Platform.isAndroid) {
    return DynamicLibrary.open("libcdl.so");
  } else if (Platform.isWindows) {
    //demo/ffi/cdl/target/x86_64-pc-windows-gnu/debug/cdl.dll
    const dllName = "cdl.dll";
    String path = "";
    if(new File(dllName).existsSync()){
      path = dllName;
    }else if(new File("../target/debug/" + dllName).existsSync()){
      path = "../target/debug/" + dllName;
    }else if(new File("../target/x86_64-pc-windows-gnu/debug/" + dllName).existsSync()){
      path = "../target/x86_64-pc-windows-gnu/debug/" + dllName;
    }
    path = Platform.script.resolve(path).path;
    return DynamicLibrary.open(path);
  } else if (Platform.isLinux) {
    return DynamicLibrary.open("libcdl.so");
  } else {
    return DynamicLibrary.process();
  }
}();

final int Function(int x, int y) add = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("add")
    .asFunction();
