import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/wallets_c.dc.dart';

extension _InitParameters on InitParameters {
  bool eq(InitParameters other) {
    if (this == other) {
      return true;
    } else if (this.contextNote == other.contextNote) {
      if (this.dbName == other.dbName) {
        return true;
      } else if (this.dbName.path == other.dbName.path &&
          this.dbName.prefix == other.dbName.prefix &&
          this.dbName.cashboxWallets == other.dbName.cashboxWallets &&
          this.dbName.cashboxMnemonic == other.dbName.cashboxMnemonic &&
          this.dbName.walletMainnet == other.dbName.walletMainnet &&
          this.dbName.walletPrivate == other.dbName.walletPrivate &&
          this.dbName.walletTestnet == other.dbName.walletTestnet &&
          this.dbName.walletTestnetPrivate == other.dbName.walletTestnetPrivate) return true;
    }
    return false;
  }
}

void main() {
  test("InitParameters", () {
    var parameter = new InitParameters();
    expect("", parameter.contextNote);
    expect("", parameter.dbName.path);
    var ptrParameter = parameter.toCPtr();
    var newParameter = InitParameters.fromC(ptrParameter);
    expect(true, parameter.eq(newParameter));
    InitParameters.free(ptrParameter);
    ptrParameter = nullptr;
    InitParameters.free(ptrParameter);
    newParameter = InitParameters.fromC(ptrParameter);
    expect("", newParameter.contextNote);

    parameter.dbName.prefix = "";
    parameter.dbName.path = "test";
    ptrParameter = parameter.toCPtr();
    newParameter = InitParameters.fromC(ptrParameter);
    expect(parameter.dbName.path, newParameter.dbName.path);
    expect(parameter.dbName.prefix, newParameter.dbName.prefix);
  });
}
