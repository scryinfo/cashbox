import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/kits.dart';

void main() {
  test("free", () {
    Pointer<Int32> ptr = null;
    try {
      ffi.free(ptr);
      expect("", "throw exception");
    } catch (e) {}

    ptr = nullptr;
    ffi.free(ptr);

    ptr = 0.toInt32Ptr();
    ffi.free(ptr);
    expect(false, ptr == nullptr);
  });
}
