import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/control/wc_protocol_control.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/wc_info_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/global.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class WcConnectedPage extends StatefulWidget {
  const WcConnectedPage() : super();

  @override
  _WcConnectedPageState createState() => _WcConnectedPageState();
}

class _WcConnectedPageState extends State<WcConnectedPage> {
  static const wcEventPlugin = const EventChannel('wc_event_protocol_channel');
  Map txInfoMap = Map();
  bool existInputInfo = false;
  double txValueDouble = 0.0;
  int eth2Unit = 1000 * 1000 * 1000 * 1000 * 1000 * 1000; // 1 ETH = 1e18 wei = 1e9 gwei
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context);
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    registryListen();
  }

  registryListen() {
    wcEventPlugin.receiveBroadcastStream().listen((event) {
      print("receiveBoard event ------->" + event.toString());
      txInfoMap = Map.from(event);
      Logger().d("wcEventPlugin : txInfoMap is--->", txInfoMap.toString());
      if (!txInfoMap.containsKey("from") || !txInfoMap.containsKey("to") || !txInfoMap.containsKey("value") || !txInfoMap.containsKey("data")) {
        Logger().e("txValue txInfoMap not match :", txInfoMap.toString());
        return;
      }
      try {
        txValueDouble = Utils.hexToDouble(txInfoMap["value"]) / eth2Unit;
      } catch (e) {
        txValueDouble = 0.0;
        Logger().e("txValue format error", e.toString());
      }
      setState(() {
        this.existInputInfo = true;
      });
    }, onDone: () {
      Logger().d("wcEventPlugin", "message done");
    }, onError: (obj) {
      Logger().d("wcEventPlugin", "onError obj is --->" + obj.toString());
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
          isBack: false,
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
          Gaps.scaleVGap(2),
          _buildHeadIconWidget(),
          Gaps.scaleVGap(10),
          Container(
            height: ScreenUtil().setHeight(75),
            width: ScreenUtil().setWidth(75),
            alignment: Alignment.center,
            child: existInputInfo ? _buildInputInfoWidget() : _buildAddressWidget(),
          ),
          Gaps.scaleVGap(5),
          _buildDisconnectBtnWidget(),
        ],
      ),
    );
  }

  Widget _buildHeadIconWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        Gaps.scaleVGap(8),
        _buildDappIconWidget(),
        Text(
          Provider.of<WcInfoProvide>(context).dappName ?? "" + "已经连接到你的钱包",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
        ),
        Text(
          Provider.of<WcInfoProvide>(context).dappUrl ?? "",
          style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildDappIconWidget() {
    return CachedNetworkImage(
        imageUrl: Provider.of<WcInfoProvide>(context).dappIconUrl ?? " ",
        width: ScreenUtil().setWidth(25),
        height: ScreenUtil().setHeight(25),
        placeholder: (context, url) => Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(25),
              height: ScreenUtil().setHeight(25),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    Gaps.scaleVGap(3),
                    Container(
                      width: ScreenUtil().setWidth(40),
                      child: Text(
                        "Icon loading",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: ScreenUtil().setSp(3.5),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        errorWidget: (context, url, error) => Container(
              width: ScreenUtil().setWidth(25),
              height: ScreenUtil().setHeight(25),
              child: Icon(Icons.error),
            ),
        fit: BoxFit.scaleDown);
  }

  Widget _buildAddressWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(0.5),
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "Address is: ",
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
          ),
          TextSpan(
            text: WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address ?? "",
            style: TextStyle(decoration: TextDecoration.none, color: Colors.blueGrey, fontSize: ScreenUtil().setSp(3.5), fontStyle: FontStyle.normal),
          )
        ]),
      ),
    );
  }

  Widget _buildInputInfoWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(10),
            width: ScreenUtil().setWidth(40),
            child: Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  txValueDouble.toString() ?? " " + "ETH",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: ScreenUtil().setSp(4.5),
                  ),
                ),
              ),
            ),
          ),
          Gaps.scaleVGap(3),
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(73),
            height: ScreenUtil().setHeight(1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(73),
                height: ScreenUtil().setWidth(0.1),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(6),
            child: Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(18),
                  child: Text("支付信息",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
                Container(
                  width: ScreenUtil().setWidth(54),
                  child: Text("ETH转账",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
              ],
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(73),
            height: ScreenUtil().setHeight(1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(73),
                height: ScreenUtil().setWidth(0.1),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(6),
            child: Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(18),
                  child: Text("收款地址",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
                Container(
                  width: ScreenUtil().setWidth(54),
                  child: Text(txInfoMap["to"] ?? " ",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.3),
                      )),
                ),
              ],
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(73),
            height: ScreenUtil().setHeight(1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(73),
                height: ScreenUtil().setWidth(0.1),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(6),
            child: Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(18),
                  child: Text("付款地址",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
                Container(
                  width: ScreenUtil().setWidth(54),
                  child: Text(txInfoMap["from"] ?? " ",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.3),
                      )),
                ),
              ],
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(73),
            height: ScreenUtil().setHeight(1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(73),
                height: ScreenUtil().setWidth(0.1),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(10),
            child: Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(18),
                  child: Text("矿工费",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
                Container(
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: ScreenUtil().setHeight(6),
                        child: Text("0.00002788 ETH",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: ScreenUtil().setSp(3.5),
                            )),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("= Gas(173,782) * Gas Price(1.60 GWEI)",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: ScreenUtil().setSp(2.8),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(4),
                  child: Image.asset("assets/images/ic_enter.png"),
                )
              ],
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            width: ScreenUtil().setWidth(73),
            height: ScreenUtil().setHeight(1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(73),
                height: ScreenUtil().setWidth(0.1),
              ),
            ),
          ),
          Gaps.scaleVGap(5),
          _buildChooseBtnWidget(),
        ],
      ),
    );
  }

  Widget _buildChooseBtnWidget() {
    return Container(
        child: Row(
      children: [
        Gaps.scaleHGap(5),
        ProgressButton(
          width: ScreenUtil().setWidth(27),
          height: ScreenUtil().setHeight(9),
          defaultWidget: const Text('Reject'),
          progressWidget: const CircularProgressIndicator(),
          onPressed: () async {
            // Do some background task
            WcProtocolControl.getInstance().rejectLogIn(txInfoMap["id"]);
            NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
          },
        ),
        Gaps.scaleHGap(8),
        ProgressButton(
          width: ScreenUtil().setWidth(27),
          height: ScreenUtil().setHeight(9),
          defaultWidget: const Text('Confirm'),
          progressWidget: const CircularProgressIndicator(),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PwdDialog(
                  title: translate('wallet_pwd').toString(),
                  hintContent: translate('dapp_sign_hint_content') + WalletsControl.getInstance().currentWallet().name ?? "",
                  hintInput: translate('input_pwd_hint').toString(),
                  onPressed: (pwd) async {
                    try {
                      String value = txInfoMap["value"];
                      String nonce = await loadTxAccount(txInfoMap["from"], WalletsControl.getInstance().currentChainType());
                      if (nonce == null) {
                        // todo add toast hint
                        return;
                      }
                      String gas = "206040"; // 0x9b2d4
                      String gasPrice = "10000000000";
                      if (value.length % 2 != 0) {// assemble
                        value = value.substring(0, 2) + "0" + value.substring(2);
                      }
                      EthWalletConnectTx ethWalletConnectTx = EthWalletConnectTx()
                        ..data = txInfoMap["data"]
                        ..from = txInfoMap["from"]
                        ..to = txInfoMap["to"]
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
            // WcProtocolControl.getInstance().approveLogIn(WalletsControl.getInstance().currentWallet().ethChain.chainShared.walletAddress.address);
          },
        ),
      ],
    ));
  }

  Widget _buildDisconnectBtnWidget() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.scaleHGap(8),
            ProgressButton(
              width: ScreenUtil().setWidth(75),
              defaultWidget: const Text('断开连接'),
              progressWidget: const CircularProgressIndicator(),
              height: 40,
              onPressed: () async {
                // Do some background task
                WcProtocolControl.getInstance().rejectLogIn(Provider.of<WcInfoProvide>(context, listen: false).sessionId);
                NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
              },
            ),
            Gaps.scaleHGap(8),
          ],
        ));
  }
}
