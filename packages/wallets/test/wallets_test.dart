import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:wallets/error.dart';
import 'package:wallets/parameter.dart';

import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dart' as clib;

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

void main() {
  test('Wallets', () async {
    var wallet = Wallets.instance();
    var initP = new InitParameters();
    {
      initP.dbName.cashboxWallets = "cashboxWallets.db";
      initP.dbName.cashboxMnemonic = "cashboxMnemonic.db";
      initP.dbName.walletMainnet = "walletMainnet.db";
      initP.dbName.walletPrivate = "walletPrivate.db";
      initP.dbName.walletTestnet = "walletTestnet.db";
      initP.dbName.walletTestnetPrivate = "walletTestnetPrivate.db";
    }
    {
      wallet.init(initP);

      expect(true, wallet.context != null);
      var id = ffi.Utf8.fromUtf8(wallet.context.ref.id);
      expect(true, id.isNotEmpty);

      var err = wallet.safeRead(() {
        //...
      });
      expect(true, err.isSuccess());
      err = wallet.safeWrite(() {
        // ...
      });
      expect(true, err.isSuccess());
    }

    {
      var err = await compute(computeFun, wallet.dContext.address);
      expect(true, err.isSuccess());
    }
    var uninitP = new UnInitParameters();
    wallet.uninit(uninitP);
  });
}
Error computeFun(int ctx) {
  var wallet = Wallets.instance();
  wallet.dContext = Pointer<Pointer<clib.CContext>>.fromAddress(ctx);
  var err = wallet.safeRead(() {
    //...
  });
  return err;
}


