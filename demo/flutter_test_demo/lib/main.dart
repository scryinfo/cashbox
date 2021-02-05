import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/enums.dart';
import 'package:logger/logger.dart';

import 'configv/config/config.dart';
import 'configv/config/handle_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Logger logger = Logger();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    logger.initConfig();

    Wallets wallets = await initWallet();
    if (wallets == null) {
      logger.d("wallet test ", "initWallet is null");
      return;
    }
    hasAny(wallets);
    createWallet(wallets);
    var walletList = walletsAll(wallets);
    currentWallet(wallets, walletList);

    renameWallet("wallet name", "new WalletName", walletList, wallets);

    walletList = walletsAll(wallets);
    saveCurrentWalletChain(walletList, wallets);
    removeWallet(walletList, wallets);
    walletList = walletsAll(wallets);
  }

  saveCurrentWalletChain(List<Wallet> walletList, Wallets wallets) {
    var targetWallet = walletList.firstWhere((element) {
      return element.name == "new WalletName";
    });
    if (targetWallet == null) {
      logger.d("wallet test ", "saveCurrentWalletChain targetWallet is ------> null");
    }
    var err = wallets.saveCurrentWalletChain(targetWallet.id, ChainType.ETH);
    logger.d("wallet test ", "saveCurrentWalletChain err" + err.toString());
  }

  removeWallet(List<Wallet> walletList, Wallets wallets) {
    var targetWallet = walletList.firstWhere((element) {
      return element.name == "new WalletName";
    });
    var err = wallets.removeWallet(targetWallet.id);
    logger.d("wallet test ", "removeWallet err" + err.toString());
  }

  renameWallet(String oldWalletName, String newWalletName, List<Wallet> walletList, Wallets wallets) {
    var targetWallet = walletList.firstWhere((element) {
      return element.name == oldWalletName;
    });
    var err = wallets.renameWallet(newWalletName, targetWallet.id);
    logger.d("wallet test ", "renameWallet err is --->" + err.toString());
  }

  Future<Wallets> initWallet() async {
    Wallets wallets = Wallets.mainIsolate();
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

  currentWallet(Wallets wallets, List<Wallet> walletList) {
    var curWallet = wallets.currentWalletChain();
    if (curWallet.isSuccess()) {
      wallets.findById(curWallet.data1.walletId);
    }
    var ele = walletList.firstWhere((element) {
      return element.id.toLowerCase() == curWallet.data1.walletId.toLowerCase();
    });
    if (ele == null) {
      logger.d("wallet test ", "currentWallet is ---------> null");
      return;
    }
    logger.d("wallet test ", "currentWallet is --->" + ele.toString());
  }

  walletsAll(Wallets wallets) {
    var allWalletObj = wallets.all();
    if (allWalletObj.isSuccess()) {
      logger.d("wallet test ", "allWalletObj is ====> " + allWalletObj.toString());
      List<Wallet> walletList = allWalletObj.data1;
      return walletList;
    }
  }

  createWallet(Wallets wallets) {
    var mneObj = wallets.generateMnemonic();
    if (!mneObj.isSuccess()) {
      logger.d("wallet test ", "mneObj.isSuccess() is false --->");
      return;
    }
    CreateWalletParameters createWalletParameters = CreateWalletParameters();
    createWalletParameters.walletType = "Normal";
    createWalletParameters.mnemonic = mneObj.data1;
    createWalletParameters.name = "wallet name";
    createWalletParameters.password = "q";

    var newWalletObj = wallets.createWallet(createWalletParameters);
    if (!newWalletObj.isSuccess()) {
      logger.d("wallet test ", "newWalletObj is false --->");
      return;
    }
    logger.d("wallet test ", "newWalletObj is --->" + newWalletObj.data1.toString());
  }

  hasAny(Wallets wallets) {
    var hasAnyObj = wallets.hasAny();
    if (hasAnyObj.isSuccess() && hasAnyObj.data1) {
      logger.d("wallet test ", "hasAnyObj.data1 --->" + hasAnyObj.data1.toString());
    }
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    Config config = await HandleConfig.instance.getConfig();
    print("before config.vendorConfig.toString()   ===>" + config.vendorConfig.toJson().toString());
    String aimString = '''{"serverConfigIp":"测试修改four","configVersion":""}'''; //测属性是否可以是空字串
    await HandleConfig.instance.addOrUpdateVendorConfig(aimString);
    config = await HandleConfig.instance.getConfig();
    print("after config.vendorConfig.toString()   ===>" + config.vendorConfig.toJson().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
