import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/control/wc_protocol_control.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/router_handler.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/global.dart';
import 'package:logger/logger.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets_c.dc.dart';

class WcConnectedPage extends StatefulWidget {
  const WcConnectedPage() : super();

  @override
  _WcConnectedPageState createState() => _WcConnectedPageState();
}

class _WcConnectedPageState extends State<WcConnectedPage> {
  static const wcEventPlugin = const EventChannel('wc_event_protocol_channel');
  Map txInfoMap = Map();

  @override
  void initState() {
    super.initState();
    registryListen();
  }

  registryListen() {
    wcEventPlugin.receiveBroadcastStream().listen((event) {
      print("receiveBoard ev ------->" + event.toString());
      txInfoMap = Map.from(event);
      print("txInfoMap------->" + txInfoMap.toString());
    }, onDone: () {
      print("receiveBoard onDone------》");
    }, onError: (obj) {
      print("receiveBoard onError------>" + obj.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "WalletConnect",
          backgroundColor: Colors.transparent,
          onPressed: () async {
            NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
          },
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildApproveWidget(),
        ),
      ),
    );
  }

  Widget _buildApproveWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(8),
          _buildHeadIconWidget(),
          _buildAddressWidget(),
          _buildChooseBtnWidget(),
        ],
      ),
    );
  }

  Widget _buildHeadIconWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(8),
        Image.asset("assets/images/ic_logo.png"),
        Text(
          "dd",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildAddressWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(8),
        Text(
          "Address is :",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildChooseBtnWidget() {
    return SingleChildScrollView(
        child: Row(
      children: [
        Gaps.scaleHGap(8),
        ProgressButton(
          width: ScreenUtil().setWidth(30),
          defaultWidget: const Text('点击签名'),
          progressWidget: const CircularProgressIndicator(),
          height: 40,
          onPressed: () async {
            // Do some background task
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PwdDialog(
                  title: translate('wallet_pwd').toString(),
                  hintContent: translate('dapp_sign_hint_content') + WalletsControl.getInstance().currentWallet().name ?? "",
                  hintInput: translate('input_pwd_hint').toString(),
                  onPressed: (pwd) async {
                    try {
                      String data = txInfoMap["data"];
                      String from = txInfoMap["from"];
                      String to = txInfoMap["to"];
                      int id = txInfoMap["id"];
                      String value = txInfoMap["value"];
                      String nonce = await loadTxAccount(from, ChainType.EthTest);
                      String gas = "206040"; // 0x9b2d4
                      String gasPrice = "10000000000";
                      if (value.length % 2 != 0) {
                        value = value.substring(0, 2) + "0" + value.substring(2);
                      }
                      print("txInfoMap------->" + from + "||" + to + "||" + id.toString() + "||" + value.toString() + "||" + nonce);
                      print("txInfoMap------->" + "||" + "||" + data + "||");
                      EthWalletConnectTx ethWalletConnectTx = EthWalletConnectTx()
                        ..data = data
                        ..from = from
                        ..to = to
                        ..nonce = nonce
                        ..value = value
                        ..gasPrice = gasPrice
                        ..gas = gas;
                      var resultObj = EthChainControl.getInstance().wcTxSign(ethWalletConnectTx, NoCacheString()..buffer = StringBuffer(pwd));
                      if (resultObj != null) {
                        Logger().d("wcTxSign  resultObj is -----===>", resultObj.toString());
                        // String txHash = await sendRawTx(ChainType.EthTest, resultObj.toString());
                        // Logger().d("broadcast txHash is ===>", txHash);
                        // WcProtocolControl().approveTx(txInfoMap["id"].toString(), from,to,txHash,gas,gasPrice,nonce);
                        // WcProtocolControl().approveTx(txInfoMap["id"].toString(), from,to,resultObj,gas,gasPrice,nonce);
                      } else {
                        Logger().d("wcTxSign  resultObj is null-----===>", resultObj.toString());
                      }
                    } catch (e) {
                      Logger().d("wcTxSign  error is -----===>", e.toString());
                    }
                  },
                );
              },
            );

            // WcProtocolControl.getInstance().rejectLogIn();
          },
        ),
      ],
    ));
  }
}
