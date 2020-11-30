import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/parameter.dart';

import 'package:wallets/wallets.dart';

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

void main() {
  test('Wallets', () {
    var wallet = Wallets.instance();
    var param = new InitParameters();
    wallet.init(param);

     expect(true, wallet.context != null);
     var id = ffi.Utf8.fromUtf8(wallet.context.ref.id);
     expect(true, id.isNotEmpty);

    var r = wallet.safeRead(() {
      //...
    });
    expect(true, r);
    r = wallet.safeWrite(() {
      // ...
    });
    expect(true, r);

    wallet.uninit();

  });
}
