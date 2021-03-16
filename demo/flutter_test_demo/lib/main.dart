import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_demo/control/eth_chain_control.dart';
import 'package:flutter_test_demo/control/wallets_control.dart';
import 'package:flutter_test_demo/model/token.dart';
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
import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:wallets/wallets_c.dc.dart';

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
    final cashBoxType = "GA";
    final signInfo = "82499105f009f80a1fe2f1db86efdec7";
    final deviceId = "deviceIddddddd";
    final apkVersion = "2.0.0";
    var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), apkVersion, AppPlatformType.any, signInfo, "eeeddd", cashBoxType);
    var channel = createClientChannel(refresh.refreshCall);
    EthTokenOpen_QueryReq open_queryReq = new EthTokenOpen_QueryReq();

    BasicClientReq basicClientReq = new BasicClientReq();
    basicClientReq
      ..cashboxType = cashBoxType
      ..cashboxVersion = apkVersion
      ..deviceId = deviceId
      ..platformType = "aarch64-linux-android"
      ..signature = signInfo;

    PageReq pageReq = PageReq();
    pageReq..page = 0;
    open_queryReq
      ..info = basicClientReq
      ..page = pageReq
      ..isDefault = false;
    final ethTokenClient = EthTokenOpenFaceClient(channel);
    try {
      EthTokenOpen_QueryRes ethTokenOpen_QueryRes = await ethTokenClient.query(open_queryReq);
      print("ethTokenOpen_QueryRes  is ------>" + ethTokenOpen_QueryRes.toString());
      List<EthTokenOpen_Token> ethTokenList = ethTokenOpen_QueryRes.tokens;
      print("ethTokenOpen_QueryRes.length  is ------>" + ethTokenList.length.toString());
      List<TokenM> tokenMList = [];
      ArrayCEthChainTokenAuth arrayCEthChainTokenAuth = ArrayCEthChainTokenAuth();
      List<EthChainTokenAuth> ethChainTokenList = [];
      ethTokenList.forEach((element) {
        TokenM tokenM = TokenM()
          ..tokenId = element.id
          ..shortName = element.tokenShared.symbol
          ..contractAddress = element.contract
          ..decimal = element.decimal
          ..fullName = element.tokenShared.name;
        tokenMList.add(tokenM);
        print("ethTokenList item is --->" + element.id + "id" + element.tokenShared.name + "||" + element.tokenShared.symbol);
        EthChainTokenAuth ethChainTokenAuth = EthChainTokenAuth();
        ethChainTokenAuth
          ..chainTokenSharedId = element.tokenShardId
          ..position = element.position.toInt()
          ..contractAddress = element.contract
          ..ethChainTokenShared.decimal = element.decimal
          ..ethChainTokenShared.tokenShared.name = element.tokenShared.name
          ..ethChainTokenShared.tokenShared.symbol = element.tokenShared.symbol
          ..ethChainTokenShared.gasLimit = element.gasLimit.toInt()
          ..ethChainTokenShared.tokenShared.logoUrl = element.tokenShared.logoUrl;
        ethChainTokenList.add(ethChainTokenAuth);
      });
      arrayCEthChainTokenAuth.data = ethChainTokenList;
      await WalletsControl.getInstance().initWallet();
      EthChainControl.getInstance().updateAuthTokenList(arrayCEthChainTokenAuth);
      print("tokenM item is --->" + tokenMList.toString());
    } catch (e) {
      print("EthTokenOpen_QueryReq  error is ------>" + e.toString());
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    logger.setLogLevel(LogLevel.Debug);
    testWalletFunc();
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
    String mne = WalletsControl.getInstance().generateMnemonic(12);
    logger.i("wallet test ", "mne is " + mne.toString());
    Wallet wallet = WalletsControl.getInstance().createWallet(mne, WalletType.Normal, "ggg", Uint8List.fromList("q".toString().codeUnits));
    logger.i("wallet test ", "wallet is " + wallet.toString());

    List<Wallet> walletList = WalletsControl.getInstance().walletsAll();
    print("walletList info is --->" + walletList.toString());
    if (walletList == null) {
      logger.e("wallet test ", "walletList is null~");
      return;
    }
    walletList.forEach((element) {
      print("wallet test each wallet is --------->" + element.toString());
    });
    var curWallet = WalletsControl.getInstance().currentWallet();
    if (curWallet == null) {
      return;
    }
    var allTokenList = EthChainControl.getInstance().getAllTokenList(curWallet);
    var visibleTokenList = EthChainControl.getInstance().getVisibleTokenList();
    print("wallet test visibleTokenList is --------->" + visibleTokenList.toString());
    var curWalletMoney = WalletsControl.getInstance().getWalletMoney(curWallet);
    print("wallet test curWalletMoney is --------->" + curWalletMoney.toString());
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
