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

    {
      var initP = new InitParameters();
      initP.dbName.cashboxWallets = "cashbox_wallets.db";
      initP.dbName.cashboxMnemonic = "cashbox_mnemonic.db";
      initP.dbName.walletMainnet = "wallet_mainnet.db";
      initP.dbName.walletPrivate = "wallet_private.db";
      initP.dbName.walletTestnet = "wallet_testnet.db";
      initP.dbName.walletTestnetPrivate = "wallet_testnet_private.db";
      wallet.init(initP);

      expect(true, wallet.context != null);
      var id = ffi.Utf8.fromUtf8(wallet.context.ref.id);
      expect(true, id.isNotEmpty);
    }
    {
      var err = wallet.safeRead(() {
        //...
      });
      expect(true, err.isSuccess());
      err = wallet.safeRead(() {
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
    {
      var mnemonic = clib.CStr_dAlloc();
      var cerr = clib.Wallets_generateMnemonic(mnemonic);
      var err = Error.fromC(cerr);
      expect(true, err.isSuccess());
    }
    wallet.uninit();
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


