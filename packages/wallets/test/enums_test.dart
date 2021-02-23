import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/enums.dart';

void main() {
  test("NetType", () {
    for (var it in NetType.values) {
      expect(it, it.toEnumString().toNetType());
    }
  });

  test("ChainType", () {
    for (var it in ChainType.values) {
      expect(it, it.toEnumString().toChainType());
    }
  });

  test("WalletType", () {
    for (var it in WalletType.values) {
      expect(it, it.toEnumString().toWalletType());
    }
  });
}
