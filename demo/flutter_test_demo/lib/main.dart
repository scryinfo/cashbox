import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_demo/control/wallets_control.dart';
import 'package:grpc/grpc.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/enums.dart';
import 'package:logger/logger.dart';
import 'package:services/services.dart';

import 'configv/config/config.dart';
import 'configv/config/handle_config.dart';

import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    testGrpc();
  }



  testGrpc() async {
    var refresh =
    RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), "2.0.0", AppPlatformType.any, "82499105f009f80a1fe2f1db86efdec7", "", "");
    var channel = createClientChannel(refresh.refreshCall);
    BasicClientReq basicClientReq = new BasicClientReq();
    //String deviceId = await AppInfoUtil.instance.getDeviceId();
    String deviceId = "ddd device";
    //String signInfo = await AppInfoUtil.instance.getAppSignInfo();
    String signInfo = "82499105f009f80a1fe2f1db86efdec7";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String apkVersion = packageInfo.version;
    basicClientReq
      ..cashboxType = "GA"
      ..cashboxVersion = apkVersion // 2.0.0
      ..deviceId = deviceId ?? ""
      ..platformType = "aarch64-linux-android"
      ..signature = signInfo; // 82499105f009f80a1fe2f1db86efdec7
    final cashboxConfigOpenFaceClient = CashboxConfigOpenFaceClient(channel);
    try {
      CashboxConfigOpen_LatestConfigRes latestConfigRes = await cashboxConfigOpenFaceClient.latestConfig(basicClientReq);
      latestConfigRes.cashboxVersion;
      latestConfigRes.configVersion;
      latestConfigRes.conf;
      print("latestConfigRes  is ------>" + latestConfigRes.toString());
    } catch (e) {
      print("latestConfigRes  error is ------>" + e.toString());
    }


  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    logger.setLogLevel(LogLevel.Debug);
    // testWalletFunc();
  }

  testWalletFunc() async {
    Wallets wallets = await WalletsControl.getInstance().initWallet();
    if (wallets == null) {
      logger.i("wallet test ", "initWallet is null");
      return;
    }
    bool isHasAny = WalletsControl.getInstance().hasAny();
    if (!isHasAny) {
      logger.i("wallet test ", "isHasAny is " + isHasAny.toString());
    }
    String mne = WalletsControl.getInstance().generateMnemonic();
    logger.i("wallet test ", "mne is " + mne.toString());
    Wallet wallet = WalletsControl.getInstance().createWallet(mne, WalletType.Normal, "ddd", Uint8List.fromList("q".toString().codeUnits));
    logger.i("wallet test ", "wallet is " + wallet.toString());

    List<Wallet> walletList = WalletsControl.getInstance().walletsAll();
    if (walletList == null) {
      logger.e("wallet test ", "walletList is null~");
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
