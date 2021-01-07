import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

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
  //转换到c，记得调用释放内存
  Pointer<C> toCPtr();

  toC(Pointer<C> ptr);

  //转换到dart，
  toDart(Pointer<C> c);
}

extension ErrorEx on Error {
  bool isSuccess() => this.code == 0;
}

Pointer<ffi.Utf8> toUtf8Null(String str) {
  if (str == null) {
    return nullptr;
  }
  return ffi.Utf8.toUtf8(str);
}

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

extension Utf8PtrEx on Pointer<ffi.Utf8> {
  void free() {
    ffi.free(this);
  }
}

extension Int8PtrEx on Pointer<Int8> {
  void free() {
    ffi.free(this);
  }
}

extension Int16PtrEx on Pointer<Int16> {
  void free() {
    ffi.free(this);
  }
}

extension Int32PtrEx on Pointer<Int32> {
  void free() {
    ffi.free(this);
  }
}

extension Int64PtrEx on Pointer<Int64> {
  void free() {
    ffi.free(this);
  }
}

extension Uint8PtrEx on Pointer<Uint8> {
  void free() {
    ffi.free(this);
  }
}

extension Uint16PtrEx on Pointer<Uint16> {
  void free() {
    ffi.free(this);
  }
}

extension Uint32PtrEx on Pointer<Uint32> {
  void free() {
    ffi.free(this);
  }
}

extension Uint64PtrEx on Pointer<Uint64> {
  void free() {
    ffi.free(this);
  }
}

extension FloatPtrEx on Pointer<Float> {
  void free() {
    ffi.free(this);
  }
}

extension DoublePtrEx on Pointer<Double> {
  void free() {
    ffi.free(this);
  }
}

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
