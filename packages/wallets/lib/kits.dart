import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

//dart 与 c struct之间相互转换
abstract class DC<C extends NativeType> {
  //转换到c，记得调用释放内存
  Pointer<C> toC();

  //转换到dart，
  toDart(Pointer<C> c);
}

//检测Error是否成功
bool isSuccess(Error err) => err.code == 0;

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
