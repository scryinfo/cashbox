
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:wallets/wallets_c.dart';

class Error {
  int code;
  String message;

  Error(){
    code = 0;
    message = "";
  }
  Error.fromC(Pointer<CError> err) {
    code = err.ref.code;
    message = Utf8.fromUtf8(err.ref.message);
  }

  bool isSuccess() => code == 0;
}

