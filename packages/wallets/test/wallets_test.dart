import 'package:flutter_test/flutter_test.dart';

import 'package:wallets/wallets.dart';

void main() {
  test('Wallets lock', () {
    var wallet = Wallets.instance();
    var r = wallet.safeRead(() {
      //...
    });
    expect(true, r);
    r = wallet.safeWrite(() {
      // ...
    });
    expect(true, r);
  });
}
