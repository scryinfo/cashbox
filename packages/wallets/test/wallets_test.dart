import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/kits.dart';

import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dart' as clib;

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/wallets_c.dc.dart';

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
      expect(true, isSuccess(err));
      err = wallet.safeRead(() {
        //...
      });
      expect(true, isSuccess(err));
      err = wallet.safeWrite(() {
        // ...
      });
      expect(true, isSuccess(err));
    }

    {
      var err = await compute(computeFun, wallet.dContext.address);
      expect(true, isSuccess(err));
    }
    {
      var mnemonic = clib.CStr_dAlloc();
      var cerr = clib.Wallets_generateMnemonic(mnemonic);
      var err = Error.fromC(cerr);
      expect(true, isSuccess(err));
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
