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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
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
  bool existInputInfo = false;
  double txValueDouble = 0.0;
  String defaultGasLimit = "210000"; // default : 21000 * 10
  int eth2Unit = 1000 * 1000 * 1000 * 1000 * 1000 * 1000; // 1 ETH = 1e18 wei = 1e9 gwei
  TextEditingController _gasPriceController = TextEditingController(); //default :wei from layout input
  TextEditingController _gasController = TextEditingController();
  double allGasFee = 0.0;

  @override
  void initState() {
    super.initState();
    registryListen();
  }

  registryListen() {
    _gasController.text = defaultGasLimit;
    _gasPriceController.addListener(() {
      _updateGasFee();
    });
    _gasController.addListener(() {
      _updateGasFee();
    });
    _loadGasOracle();
    wcEventPlugin.receiveBroadcastStream().listen((event) {
      try {
        txInfoMap = Map.from(event);
        Logger().d("wcEventPlugin : txInfoMap is--->", txInfoMap.toString());
        if (!txInfoMap.containsKey("from") ||
            !txInfoMap.containsKey("to") ||
            !txInfoMap.containsKey("value") ||
            !txInfoMap.containsKey("data")) {
          Fluttertoast.showToast(msg: translate("wc_tx_format_error"));
          return;
        }
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

  _loadGasOracle() async {
    var gasOracleMap = await loadGasOracle(WalletsControl().currentWallet().ethChain.chainShared.chainType.toChainType());
    if (gasOracleMap == null) {
      return;
    }
    if (gasOracleMap.containsKey("ProposeGasPrice") != null) {
      _gasPriceController.text = gasOracleMap["ProposeGasPrice"];
    }
  }

  _updateGasFee() {
    if (_gasPriceController.text.toString().isEmpty || _gasController.text.toString().isEmpty) {
      allGasFee = 0.0;
      return;
    }
    num gasPrice = int.parse(_gasPriceController.text.toString());
    num gasLimit = int.parse(_gasController.text.toString());
    allGasFee = gasPrice.toDouble() * gasLimit.toDouble();
    allGasFee = allGasFee / (1000 * 1000 * 1000); //gwei to eth
    setState(() {
      this.allGasFee = allGasFee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // not back to previous page
      },
      child: Container(
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
          Provider.of<WcInfoProvide>(context, listen: false).dappName ?? "" + translate("already_connect_wallet") ?? "",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blue,
              fontSize: ScreenUtil().setSp(4),
              fontStyle: FontStyle.normal),
        ),
        Text(
          Provider.of<WcInfoProvide>(context, listen: false).dappUrl ?? "",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blueGrey,
              fontSize: ScreenUtil().setSp(3),
              fontStyle: FontStyle.normal),
        ),
      ],
    ));
  }

  Widget _buildDappIconWidget() {
    return CachedNetworkImage(
        imageUrl: Provider.of<WcInfoProvide>(context, listen: false).dappIconUrl ?? " ",
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
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
        ),
        child: Column(
          children: [
            Container(
              child: Text(
                translate("success_connect"),
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.blueGrey,
                    fontSize: ScreenUtil().setSp(4),
                    fontStyle: FontStyle.normal),
              ),
            ),
            Gaps.scaleVGap(3),
            Container(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: translate("chain_address_info"),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.blueGrey,
                        fontSize: ScreenUtil().setSp(4),
                        fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                    text: WalletsControl.getInstance().currentWallet()?.ethChain.chainShared.walletAddress.address ?? "",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.blueGrey,
                        fontSize: ScreenUtil().setSp(3.5),
                        fontStyle: FontStyle.normal),
                  )
                ]),
              ),
            )
          ],
        ));
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
                  child: Text(translate("payment_info"),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(3.7),
                      )),
                ),
                Container(
                  width: ScreenUtil().setWidth(54),
                  child: Text(translate("eth_transfer"),
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
                  child: Text(translate("receive_address"),
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
                  child: Text(translate("pay_address"),
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
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  _showCustomGasFeeAlert();
                },
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(18),
                      child: Text(translate("mine_fee"),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: ScreenUtil().setSp(3.7),
                          )),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(10),
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: ScreenUtil().setHeight(6),
                            child: Text((allGasFee.toString() ?? "0.0") + " ETH",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: ScreenUtil().setSp(3.5),
                                )),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child:
                                Text("= Gas(" + _gasController.text + ") * Gas Price(" + _gasPriceController.text + "GWEI)",
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
              )),
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
          defaultWidget: Text(translate('cancel')),
          progressWidget: CircularProgressIndicator(),
          onPressed: () async {
            setState(() {
              this.existInputInfo = false;
            });
            WcProtocolControl.getInstance().rejectTxReq(txInfoMap["id"]);
          },
        ),
        Gaps.scaleHGap(8),
        ProgressButton(
          width: ScreenUtil().setWidth(27),
          height: ScreenUtil().setHeight(9),
          defaultWidget: Text(translate('confirm')),
          progressWidget: const CircularProgressIndicator(),
          onPressed: () async {
            _showDialogToSignTx(context);
          },
        ),
      ],
    ));
  }

  _showDialogToSignTx(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('wallet_pwd').toString(),
          hintContent: translate('dapp_sign_hint_content') + WalletsControl.getInstance().currentWallet().name ?? "",
          hintInput: translate('input_pwd_hint').toString(),
          onPressed: (pwd) async {
            ProgressDialog prDialog = ProgressDialog(context: context);
            try {
              prDialog.show(msg: translate("handle_allow_connecting"));
              String value = txInfoMap["value"];
              String nonce = await loadTxAccount(txInfoMap["from"], WalletsControl.getInstance().currentChainType());
              if (nonce == null) {
                Fluttertoast.showToast(msg: translate("nonce_is_wrong"));
                prDialog.close();
                return;
              }
              if (value.length % 2 != 0) {
                value = value.substring(0, 2) + "0" + value.substring(2);
              }
              num gasPrice = int.parse(_gasPriceController.text.toString()) * (1000 * 1000 * 1000); // gwei---> wei
              EthWalletConnectTx ethWalletConnectTx = EthWalletConnectTx()
                ..typeTxId = 0
                ..data = txInfoMap["data"]
                ..from = txInfoMap["from"]
                ..to = txInfoMap["to"]
                ..nonce = nonce
                ..value = value
                ..gasPrice = gasPrice.toString()
                ..gas = _gasController.text.toString(); // Unit: wei
              var resultObj =
                  EthChainControl.getInstance().wcTxSign(ethWalletConnectTx, NoCacheString()..buffer = StringBuffer(pwd));
              setState(() {
                this.existInputInfo = false;
              });
              if (resultObj != null) {
                String txHash = await sendRawTx(ChainType.EthTest, resultObj.toString());
                Fluttertoast.showToast(msg: translate("sign_success_and_uploading"), timeInSecForIosWeb: 5);
                WcProtocolControl().approveTx(txInfoMap["id"].toString(), txHash);
                prDialog.close();
              } else {
                prDialog.close();
                Fluttertoast.showToast(msg: translate("sign_failure_check_pwd"), timeInSecForIosWeb: 5);
              }
              NavigatorUtils.goBack(context);
            } catch (e) {
              Logger().d("wcTxSign  error is :", e.toString());
              NavigatorUtils.goBack(context);
            }
          },
        );
      },
    );
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
            defaultWidget: Text(translate("disconnect")),
            progressWidget: const CircularProgressIndicator(),
            height: 40,
            onPressed: () async {
              WcProtocolControl.getInstance().rejectLogIn();
              NavigatorUtils.push(context, Routes.entrancePage, clearStack: false);
            },
          ),
          Gaps.scaleHGap(8),
        ],
      ),
    );
  }

  _showCustomGasFeeAlert() {
    Alert(
        context: context,
        title: translate("gas_setting"),
        content: Column(
          children: <Widget>[
            Container(
              child: Text(
                translate("recommend_default_hint"),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(3.0),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Gas Price (' + translate("tx_unit") + ':gwei)',
              ),
              controller: _gasPriceController,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Gas',
              ),
              controller: _gasController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            width: ScreenUtil().setWidth(30),
            onPressed: () {
              if (_gasController.text.isEmpty || _gasPriceController.text.isEmpty) {
                Fluttertoast.showToast(msg: translate("gas_cannot_empty"));
                return;
              }
              Navigator.pop(context);
            },
            child: Text(
              translate("confirm_and_submit"),
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(4)),
            ),
          )
        ]).show();
  }
}
