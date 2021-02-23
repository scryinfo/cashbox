import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/enums.dart';
import 'package:logger/logger.dart';

class WalletMgr {
  //Factory singleton class implementation
  factory WalletMgr() => _getInstance();

  static WalletMgr get instance => _getInstance();
  static WalletMgr _instance;

  WalletMgr._internal() {
    //init data
  }

  static WalletMgr _getInstance() {
    if (_instance == null) {
      _instance = new WalletMgr._internal();
    }
    return _instance;
  }

  Wallets wallets;

  Future<Wallets> getWalletList() async {
    wallets = Wallets.mainIsolate();
    var initP = new InitParameters();
    {
      Directory directory = await getExternalStorageDirectory(); // path:  Android/data/
      initP.dbName.path = directory.path;
      initP.dbName.prefix = "test_";
      initP.dbName = Wallets.dbName(initP.dbName);
    }
    var err = wallets.init(initP);
    if (err != null && err.code == 0) {
      print("success  initWallet --->" + err.toString());
      return wallets;
    } else {
      print("err initWallet--->" + err.toString());
      return null;
    }
  }

  Future<bool> hasAnyWallet() async {
    if (wallets == null) {
      if (await getWalletList() == null) {
        return false;
      }
    }
    var hasAnyObj = wallets.hasAny();
    if (hasAnyObj.isSuccess()) {
      return hasAnyObj.data1;
    }
    return false;
  }
}
