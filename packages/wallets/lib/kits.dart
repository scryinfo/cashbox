import 'dart:ffi';

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
