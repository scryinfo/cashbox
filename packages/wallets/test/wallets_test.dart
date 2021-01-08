import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dart' as clib;
import 'package:wallets/wallets_c.dc.dart';

void main() {
  test('Wallets', () async {
    var wallet = Wallets.mainIsolate();
    {
      var initP = new InitParameters();
      {
        initP.dbName.path = "./temp";
        initP.dbName.prefix = "test_";
        initP.dbName = Wallets.dbName(initP.dbName);
      }
      wallet.init(initP);

      expect(true, wallet.ptrContext != null);
      var id = ffi.Utf8.fromUtf8(wallet.ptrContext.ref.id);
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
      var err = await compute(computeFun, wallet.context);
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

Error computeFun(Context ctx) {
  var wallet = Wallets.subIsolate(ctx);
  var err = wallet.safeRead(() {
    //...
  });
  return err;
}
