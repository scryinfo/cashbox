import 'dart:ffi';
import 'dart:io';

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
        //清除目录
        final dir = Directory(initP.dbName.path);
        dir.deleteSync(recursive: true);
      }
      wallets.init(initP);

      expect(nullptr, isNot(equals(wallets.ptrContext)));
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
      var resultMn = wallets.generateMnemonic(12);
      expect(true, resultMn.isSuccess());
      CreateWalletParameters parameters = new CreateWalletParameters();
      {
        parameters.name = "test_one";
        parameters.password = "1";
        parameters.mnemonic = resultMn.data1;
        parameters.walletType = WalletType.Normal.toEnumString();
      }
      var resultWallet = wallets.createWallet(parameters);
      expect(true, resultWallet.isSuccess());
      var wallet = resultWallet.data1;
      expect(parameters.name, wallet.name);
      expect(true, wallet.ethChain.tokens.data.isNotEmpty);
      expect(true, wallet.eeeChain.tokens.data.isNotEmpty);
      //todo
      // expect(true,wallet.btcChain.tokens.data.isNotEmpty);
      expect(parameters.walletType, wallet.walletType);

      var all = wallets.all();
      expect(true, all.isSuccess());
      expect(1, all.data1.length);
      wallet = all.data1[0];
      expect(parameters.name, wallet.name);
      expect(true, wallet.ethChain.tokens.data.isNotEmpty);
      expect(true, wallet.eeeChain.tokens.data.isNotEmpty);
      //todo
      // expect(true,wallet.btcChain.tokens.data.isNotEmpty);
      expect(parameters.walletType, wallet.walletType);
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
