import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'cdl_c.dart';

class Int8String {
  //由于toString方法已经存在，所以使用下面的名字
  static String int8toString(Pointer<Int8> pointer) {
    return pointer.cast<Utf8>().toDartString();
  }

  static Pointer<Utf8> toUtf8(Pointer<Int8> pointer) {
    return pointer.cast();
  }

  //使用完成之后，调用 freeInt8释放内存
  static Pointer<Int8> allocInt8(String str) {
    return str.toNativeUtf8().cast();
  }

  static freeInt8(Pointer<Int8> pointer) {
    //这里不进行类型转换，也是可以的，但为了与创建对应，所以作了转换
    calloc.free(pointer.cast<Utf8>());
  }
}

extension StringEx on String {
  Pointer<Int8> toPointerInt8() {
    return this.toNativeUtf8().cast();
  }
}

extension Utf8Ex on Pointer<Utf8> {
  void free() {
    if (this != nullptr && this.address != 0) {
      calloc.free(this);
    }
  }
}

extension Int8Ex on Pointer<Int8> {
  String toDartString() {
    return this == nullptr ? "" : this.cast<Utf8>().toDartString();
  }

  void free() {
    if (this != nullptr && this.address != 0) {
      calloc.free(this);
    }
  }
}

extension CArrayCCharEx on CArrayCChar{
  List<String> toList(){
    var list = <String>[];
    for(int i = 0; i < this.len; i++){
      list.add(this.ptr.elementAt(i).value.toDartString());
    }
    return list;
  }
}
