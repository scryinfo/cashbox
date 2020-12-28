import 'dart:ffi';

import 'package:wallets/wallets_c.dc.dart';

abstract class DC<C extends NativeType> {
  Pointer<C> toC();

  toDart(Pointer<C> c);
// free(Pointer<C> c); //
}

bool isSuccess(Error err) => err.code == 0;
