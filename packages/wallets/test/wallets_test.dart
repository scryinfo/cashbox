import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/result.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

void main() {
  test('Wallets', () async {
    var wallets = Wallets.mainIsolate();
    {
      AppPlatformTypes platName = Wallets.appPlatformType();
      print(platName);
      expect(true, platName != null);
    }

    var initP = new InitParameters();
    {
      {
        initP.dbName.path = "./temp";
        initP.dbName.prefix = "test_";
        initP.dbName = Wallets.dbName(initP.dbName);

        initP.contextNote = "dart_test";
      }
      wallets.init(initP);

      expect(true, wallets.ptrContext != null);
      var id = wallets.ptrContext.ref.id.toDartString();
      expect(true, id.isNotEmpty);
      expect("dart_test", wallets.context.contextNote);
    }
    {
      var err = wallets.safeRead(() {
        //...
      });
      expect(true, err.isSuccess());
      err = wallets.safeRead(() {
        //...
      });
      expect(true, err.isSuccess());
      err = wallets.safeWrite(() {
        // ...
      });
      expect(true, err.isSuccess());
    }

    {
      var err = await compute(computeFun, wallets.context);
      expect(true, err.isSuccess());
      expect(ChainType.EEE, err.data1.chainType);
    }
    {
      var result = wallets.generateMnemonic(12);
      expect(true, result.isSuccess());
      CreateWalletParameters parameters = new CreateWalletParameters();
      {
        parameters.name = "test_one";
        parameters.password = "1";
        parameters.mnemonic = result.data1;
        parameters.walletType = WalletType.Normal.toEnumString();
      }
      var wallet = wallets.createWallet(parameters);
      // expect(true, wallet.isSuccess());
      // expect(parameters.name, wallet.data1.name);
      // expect(true, wallet.data1.ethChain.tokens.data.isNotEmpty);
      //todo
      // expect(true, wallet.data1?.btcChain?.tokens?.data?.isNotEmpty);
    }
    wallets.uninit();
  });
}

DlResult1<CurrentWallet> computeFun(Context ctx) {
  var wallet = Wallets.subIsolate(ctx);

  var err = wallet.saveCurrentWalletChain("any_test", ChainType.EEE);
  var first = wallet.currentWalletChain();
  return first;
}
