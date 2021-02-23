import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

//分配置内存并清零
Pointer<T> allocateZero<T extends NativeType>({int count = 1}) {
  final int totalSize = count * sizeOf<T>();
  var ptr = ffi.allocate<T>();
  var temp = ptr.cast<Uint8>();
  for (var i = 0; i < totalSize; i++) {
    temp.elementAt(i).value = 0;
  }
  return ptr;
}

//dart 与 c struct之间相互转换
abstract class DC<C extends NativeType> {
  //把数据转换为指针类型，会分配内存，记得释放内存
  Pointer<C> toCPtr();

  //把数据赋值给指针
  toC(Pointer<C> ptr);

  //转换到dart，
  toDart(Pointer<C> c);
}

extension ErrorEx on Error {
  bool isSuccess() => this.code == 0;
}

//str转换为 Pointer<ffi.Utf8>类型，这里会分配内存，需要调用free释放内存
Pointer<ffi.Utf8> toUtf8Null(String str) {
  if (str == null) {
    return nullptr;
  }
  return ffi.Utf8.toUtf8(str);
}

//指针转抽象为string类型
String fromUtf8Null(Pointer<ffi.Utf8> ptr) {
  if (ptr == null || ptr == nullptr) {
    return null;
  }
  return ffi.Utf8.fromUtf8(ptr);
}

extension StringEx on String {
  Pointer<ffi.Utf8> toCPtr() {
    return toUtf8Null(this);
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
    ffi.free(this);
  }
}

//释放内存
extension Utf8PtrEx on Pointer<ffi.Utf8> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Int8PtrEx on Pointer<Int8> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Int16PtrEx on Pointer<Int16> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Int32PtrEx on Pointer<Int32> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Int64PtrEx on Pointer<Int64> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Uint8PtrEx on Pointer<Uint8> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Uint16PtrEx on Pointer<Uint16> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Uint32PtrEx on Pointer<Uint32> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension Uint64PtrEx on Pointer<Uint64> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension FloatPtrEx on Pointer<Float> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//释放内存
extension DoublePtrEx on Pointer<Double> {
  void free() {
    if (this != null && this != nullptr && this.address != 0) {
      ffi.free(this);
    }
  }
}

//bool值判断，转换指针
extension IntEx on int {
  bool isTrue() => this == 0;

  Pointer<Uint32> toBoolPtr() {
    var ptr = ffi.allocate<Uint32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int8> toInt8Ptr() {
    var ptr = ffi.allocate<Int8>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int16> toInt16Ptr() {
    var ptr = ffi.allocate<Int16>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int32> toInt32Ptr() {
    var ptr = ffi.allocate<Int32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Int64> toInt64Ptr() {
    var ptr = ffi.allocate<Int64>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint8> toUint8Ptr() {
    var ptr = ffi.allocate<Uint8>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint16> toUint16Ptr() {
    var ptr = ffi.allocate<Uint16>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint32> toUint32Ptr() {
    var ptr = ffi.allocate<Uint32>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Uint64> toUint64Ptr() {
    var ptr = ffi.allocate<Uint64>();
    ptr.value = this;
    return ptr;
  }
}

//转换指针
extension DoubleEx on double {
  Pointer<Float> toFloatPtr() {
    var ptr = ffi.allocate<Float>();
    ptr.value = this;
    return ptr;
  }

  Pointer<Double> toDoublePtr() {
    var ptr = ffi.allocate<Double>();
    ptr.value = this;
    return ptr;
  }
}

class NoCacheString {
  StringBuffer buffer;

  NoCacheString() {
    buffer = new StringBuffer();
  }

  @override
  String toString() {
    return buffer.toString();
  }

  Pointer<ffi.Utf8> toCPtr() {
    //todo
    return toString().toCPtr();
  }

  static void free(Pointer<ffi.Utf8> str) {
    //todo
    if (str != null && str != nullptr) {
      ffi.free(str);
    }
  }

  clean() {
    buffer.clear();
  }
}
