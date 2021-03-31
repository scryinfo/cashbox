import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as pathLib;
import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

const int CTrue = 1;
const int CFalse = 0;
//分配置内存并清零
Pointer<T> allocateZero<T extends NativeType>({int count = 1}) {
  final int totalSize = count * sizeOf<T>();
  var ptr = ffi.calloc.allocate<T>(totalSize);
  var temp = ptr.cast<Uint8>();
  for (var i = 0; i < totalSize; i++) {
    temp.elementAt(i).value = 0;
  }
  return ptr;
}

//dart <=> c struct
abstract class DC<C extends NativeType> {
  //把数据转换为指针类型，会分配内存，记得释放内存
  Pointer<C> toCPtr();

  //把数据赋值给指针
  toC(Pointer<C> ptr);

  //把数据赋值给指针
  toCInstance(C instance);

  //转换到dart，
  toDart(Pointer<C> c);

  toDartInstance(C instance);
}

extension ErrorEx on Error {
  bool isSuccess() => this.code == 0;
}

//指针转抽象为string类型
String fromUtf8Null(Pointer<ffi.Utf8> ptr) {
  return ptr == nullptr ? "" : ptr.toDartString();
}

extension StringEx on String {
  Pointer<ffi.Utf8> toCPtrUtf8() {
    return this.toNativeUtf8();
  }
  Pointer<Int8> toCPtrInt8() {
    return this.toNativeUtf8().cast();
  }
}

//释放指针的指针的内存
extension Utf8DoublePtrEx on Pointer<Pointer<ffi.Utf8>> {
  void free(int len) {
    for (var i = 0; i < len; i++) {
      Pointer<ffi.Utf8> el = this.elementAt(i).value;
      el.free();
      this.elementAt(i).value = nullptr;
    }
    ffi.calloc.free(this);
  }
}

//释放内存
extension Utf8PtrEx on Pointer<ffi.Utf8> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
  // String toDataString(){
  //   return fromUtf8Null(this);
  // }
}

//释放指针的指针的内存
extension Int8DoublePtrEx on Pointer<Pointer<Int8>> {
  void free(int len) {
    for (var i = 0; i < len; i++) {
      Pointer<Int8> el = this.elementAt(i).value;
      el.free();
      this.elementAt(i).value = nullptr;
    }
    ffi.calloc.free(this);
  }
}

//释放内存
extension Int8PtrEx on Pointer<Int8> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
  String toDartString(){
    return this == nullptr?"":this.cast<ffi.Utf8>().toDartString();
  }
}

//释放内存
extension Int16PtrEx on Pointer<Int16> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Int32PtrEx on Pointer<Int32> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Int64PtrEx on Pointer<Int64> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Uint8PtrEx on Pointer<Uint8> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Uint16PtrEx on Pointer<Uint16> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Uint32PtrEx on Pointer<Uint32> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension Uint64PtrEx on Pointer<Uint64> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension FloatPtrEx on Pointer<Float> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//释放内存
extension DoublePtrEx on Pointer<Double> {
  void free() {
    if (this != nullptr && this.address != 0) {
      ffi.calloc.free(this);
    }
  }
}

//bool值判断，转换指针
extension IntEx on int {
  bool isTrue() => this == CTrue;

  Pointer<Uint32> toBoolPtr() {
    var ptr = ffi.calloc<Uint32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int8> toInt8Ptr() {
    var ptr = ffi.calloc<Int8>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int16> toInt16Ptr() {
    var ptr = ffi.calloc<Int16>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int32> toInt32Ptr() {
    var ptr = ffi.calloc<Int32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int64> toInt64Ptr() {
    var ptr = ffi.calloc<Int64>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint8> toUint8Ptr() {
    var ptr = ffi.calloc<Uint8>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint16> toUint16Ptr() {
    var ptr = ffi.calloc<Uint16>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint32> toUint32Ptr() {
    var ptr = ffi.calloc<Uint32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint64> toUint64Ptr() {
    var ptr = ffi.calloc<Uint64>();
    ptr.value = this;
    return ptr;
  }
}

extension BoolEx on bool {
  int toInt() => this ? CTrue : CFalse;
}

//转换指针
extension DoubleEx on double {
  Pointer<Float> toFloatPtr() {
    var ptr = ffi.calloc<Float>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Double> toDoublePtr() {
    var ptr = ffi.calloc<Double>();
    ptr.value = this;
    return ptr;
  }
}

class NoCacheString {
  StringBuffer buffer = new StringBuffer();

  @override
  String toString() {
    return buffer.toString();
  }

  Pointer<ffi.Utf8> toCPtrUtf8() {
    //todo
    return toString().toCPtrUtf8();
  }
  Pointer<Int8> toCPtrInt8() {
    //todo
    return toString().toCPtrInt8();
  }
  static void freeUtf8(Pointer<ffi.Utf8> str) {
    //todo
    if (str != null && str != nullptr) {
      ffi.calloc.free(str);
    }
  }
  static void freeInt8(Pointer<Int8> str) {
    //todo
    if (str != null && str != nullptr) {
      ffi.calloc.free(str);
    }
  }
  clean() {
    buffer.clear();
  }
}

String _platformPath(String name, {String? path}) {
  if (path == null) path = "";
  String dlPath = "";
  if (Platform.isLinux || Platform.isAndroid) {
    // dlPath = pathLib.join(path, "lib" + name + ".so");
    dlPath = "/home/scry/gopath/src/github.com/scryinfo/cashbox/packages/wallets/libwallets_cdl.so";
  } else if (Platform.isMacOS) {
    dlPath = pathLib.join(path, "lib" + name + ".dylib");
  } else if (Platform.isWindows) {
    dlPath = pathLib.join(path, name + ".dll");
  } else {
    throw Exception("Platform not implemented");
  }
  if (!(File(dlPath).existsSync())) {
    dlPath = Platform.script.resolve(dlPath).path;
  }
  return dlPath;
}

DynamicLibrary dlOpenPlatformSpecific(String name, {String? path}) {
  String fullPath = _platformPath(name, path: path);
  return DynamicLibrary.open(fullPath);
}
