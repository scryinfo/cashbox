import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

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

class DlResult1<T1> {
  Error err;
  T1 data1;

  DlResult1(this.data1, this.err);

  bool isSuccess() => err.isSuccess();
}

class DlResult2<T1, T2> {
  Error err;
  T1 data1;
  T2 data2;

  DlResult2(this.data1, this.data2, this.err);

  bool isSuccess() => err.isSuccess();
}

class DlResult3<T1, T2, T3> {
  Error err;
  T1 data1;
  T2 data2;
  T3 data3;

  DlResult3(this.data1, this.data2, this.err);

  bool isSuccess() => err.isSuccess();
}
