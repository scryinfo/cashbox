import 'dart:typed_data';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eee_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallets/wallets_c.dc.dart';

class TransferEeePage extends StatefulWidget {
  @override
  _TransferEeePageState createState() => _TransferEeePageState();
}

class _TransferEeePageState extends State<TransferEeePage> {
  TextEditingController _toAddressController = TextEditingController();
  TextEditingController _txValueController = TextEditingController();
  TextEditingController _backupMsgController = TextEditingController();
  var chainAddress = "";
  int runtimeVersion;
  int txVersion;
  String digitBalance = "0";
  int nonce;
  String genesisHash;
  String digitName;
  bool isShowTxInput = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    digitName = Provider.of<TransactionProvide>(context).digitName;
    initEeeChainTxInfo();
  }

  initEeeChainTxInfo() async {
    ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
    Config config = await HandleConfig.instance.getConfig();
    if (digitName == null || digitName.isEmpty) {
      Fluttertoast.showToast(msg: translate('eee_config_error'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return;
    }
    if (digitName.toLowerCase() == config.tokenXSymbol.toLowerCase()) {
      //quick determine flag that relative to display widget
      {
        isShowTxInput = true;
        setState(() {
          this.isShowTxInput = true;
        });
      }
    }

    AccountInfo accountInfo = await EeeChainControl.getInstance()
        .loadEeeStorageMap(config.systemSymbol, config.accountSymbol, WalletsControl.getInstance().currentChainAddress());
    if (accountInfo == null) {
      Fluttertoast.showToast(msg: translate('eee_config_error'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return;
    }
    nonce = accountInfo.nonce;
    try {
      String eeeFree = accountInfo.freeBalance ?? "0";
      double eeeFreeBalance = BigInt.parse(eeeFree) / config.eeeUnit;
      digitBalance = eeeFreeBalance.toStringAsFixed(5) ?? "0";
    } catch (e) {
      digitBalance = "0";
    }
    if (digitName.toLowerCase() == config.tokenXSymbol.toLowerCase()) {
      Map tokenBalanceMap = await EeeChainControl.getInstance()
          .loadTokenXbalance(config.tokenXSymbol, config.balanceSymbol, WalletsControl.getInstance().currentChainAddress());
      if (tokenBalanceMap != null && tokenBalanceMap.containsKey("result")) {
        try {
          // double eeeFreeBalance = BigInt.parse(Utils.reverseHexValue2SmallEnd(tokenBalanceMap["result"]), radix: 16) / config.eeeUnit;
          double eeeFreeBalance =
              BigInt.parse(Utils.reverseHexValue2SmallEnd(tokenBalanceMap["result"]), radix: 16).toDouble(); // todo decimal and uint
          digitBalance = eeeFreeBalance.toStringAsFixed(5) ?? "0";
        } catch (e) {
          digitBalance = "0";
        }
      }
    }
    {
      Map blockHashMap = await scryXNetUtil.loadScryXBlockHash();
      if (blockHashMap == null || !blockHashMap.containsKey("result")) {
        Fluttertoast.showToast(msg: translate('eee_config_error'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
        return;
      }
      genesisHash = blockHashMap["result"];
    }

    {
      Map runtimeMap = await scryXNetUtil.loadScryXRuntimeVersion();
      if (runtimeMap == null || !runtimeMap.containsKey("result")) {
        Fluttertoast.showToast(msg: translate('eee_config_error'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
        return;
      }
      var resultMap = runtimeMap["result"];
      if (resultMap == null || !resultMap.containsKey("specVersion") || !resultMap.containsKey("transactionVersion")) {
        Fluttertoast.showToast(msg: translate('eee_config_error'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
        return;
      }
      runtimeVersion = resultMap["specVersion"];
      txVersion = resultMap["transactionVersion"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('wallet_transfer'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildTransferEeeWidget(),
        ),
      ),
    );
  }

  Widget _buildTransferEeeWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.scaleVGap(5),
            _buildToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildValueWidget(),
            Gaps.scaleVGap(5),
            isShowTxInput ? _buildBackupMsgWidget() : Text(""),
            Gaps.scaleVGap(15),
            _buildTransferBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildToAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('receive_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(13),
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: ScreenUtil().setSp(3.5),
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setHeight(3),
                        right: ScreenUtil().setWidth(10),
                        top: ScreenUtil().setHeight(5),
                        bottom: ScreenUtil().setHeight(5),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                      hintText: translate('pls_input_receive_address'),
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    controller: _toAddressController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  //width: ScreenUtil.getInstance().setWidth(13),
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(12),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(1),
                    right: ScreenUtil().setWidth(1),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        _scanQrContent();
                      } else {
                        Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
                        if (statuses[Permission.camera] == PermissionStatus.granted) {
                          _scanQrContent();
                        } else {
                          Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
                        }
                      }
                    },
                    icon: Image.asset("assets/images/ic_scan.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scanQrContent() async {
    try {
      String qrResult = await QrScanUtil.instance.qrscan();
      setState(() {
        _toAddressController.text = qrResult.toString();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: translate('unknown_error_in_scan_qr_code'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
    }
  }

  Widget _buildValueWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: translate('transaction_amount'),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: ScreenUtil().setSp(3),
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: " (" + translate('tx_unit') + digitName + ")",
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.35), fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                ),
              ]),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            height: ScreenUtil().setHeight(13),
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3),
                ),
                hintText: translate('pls_input_transaction_amount'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil().setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _txValueController,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[0-9.]")), //Only numbers or decimal points can be entered.
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupMsgWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('extend_msg'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            height: ScreenUtil().setHeight(13),
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3),
                ),
                hintText: translate('hint_extend_msg_option'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil().setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _backupMsgController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferBtnWidget() {
    return GestureDetector(
      onTap: () async {
        ProgressDialog.showProgressDialog(context, translate("check_data_format"));
        if (!_verifyDataFormat()) {
          NavigatorUtils.goBack(context);
          return;
        }
        NavigatorUtils.goBack(context);
        _showPwdDialog(context);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().setWidth(41),
        height: ScreenUtil().setHeight(9),
        color: Color.fromRGBO(26, 141, 198, 0.20),
        child: FlatButton(
          child: Text(
            translate('click_to_transfer'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
            ),
          ),
        ),
      ),
    );
  }

  bool _verifyDataFormat() {
    if (_toAddressController.text.trim() == "") {
      Fluttertoast.showToast(msg: translate('to_address_null').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return false;
    }
    if (_txValueController.text.trim() == "") {
      Fluttertoast.showToast(msg: translate('tx_value_is_0').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return false;
    }
    try {
      if (digitBalance == null || double.parse(_txValueController.text) > double.parse(digitBalance)) {
        Fluttertoast.showToast(msg: translate('balance_is_less'));
        return false;
      }
      if (_txValueController.text.startsWith(".")) {
        // case： float value that start with . without 0.
        _txValueController.text = double.parse(_txValueController.text).toString();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: translate('balance_is_less'));
      return false;
    }
    return true;
  }

  void _showPwdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('wallet_pwd').toString(),
          hintContent: translate('input_pwd_hint_detail').toString(),
          hintInput: translate('input_pwd_hint').toString(),
          onPressed: (String pwd) async {
            Map eeeTransferMap;
            String signInfo;
            Config config = await HandleConfig.instance.getConfig();
            if (digitName != null && digitName.toLowerCase() == config.eeeSymbol.toLowerCase()) {
              EeeTransferPayload eeeTransferPayload = EeeTransferPayload();
              eeeTransferPayload
                ..fromAccount = WalletsControl.getInstance().currentChainAddress()
                ..toAccount = _toAddressController.text.toString()
                ..value = _txValueController.text.toString()
                ..index = nonce
                ..password = pwd
                ..extData = "todo"
                ..chainVersion = EeeChainControl.getInstance().getChainVersion();
              signInfo = EeeChainControl.getInstance().eeeTransfer(eeeTransferPayload);
              if (signInfo == null || signInfo.isEmpty) {
                Fluttertoast.showToast(msg: translate('eee_config_error').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
                NavigatorUtils.goBack(context);
                return;
              }
            } else if (digitName != null && digitName.toLowerCase() == config.tokenXSymbol.toLowerCase()) {
              EeeTransferPayload eeeTransferPayload = EeeTransferPayload();
              eeeTransferPayload
                ..fromAccount = WalletsControl.getInstance().currentChainAddress()
                ..toAccount = _toAddressController.text.toString()
                ..value = _txValueController.text.toString()
                ..index = nonce
                ..password = pwd
                ..extData = _backupMsgController.text ?? ""
                ..chainVersion = EeeChainControl.getInstance().getChainVersion();
              signInfo = EeeChainControl.getInstance().tokenXTransfer(eeeTransferPayload);
            } else {
              Fluttertoast.showToast(msg: translate('eee_config_error').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
              NavigatorUtils.goBack(context);
              return;
            }
            if (signInfo == null || signInfo.isEmpty) {
              Fluttertoast.showToast(msg: translate('tx_sign_failure').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
              NavigatorUtils.goBack(context);
              return;
            }
            context.read<TransactionProvide>()
              ..setFromAddress(WalletsControl.getInstance().currentChainAddress())
              ..setValue(_txValueController.text)
              ..setToAddress(_toAddressController.text)
              ..setSignInfo(signInfo);
            NavigatorUtils.push(context, Routes.transferEeeConfirmPage);
          },
        );
      },
    );
  }

  bool _isMapStatusOk(Map returnMap) {
    if (returnMap == null || !returnMap.containsKey("status") || returnMap["status"] != 200) {
      return false;
    }
    return true;
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<TransactionProvide>().setSignInfo("");
  }
}
