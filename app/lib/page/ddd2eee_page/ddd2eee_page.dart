import 'dart:async';

import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Ddd2EeePage extends StatefulWidget {
  @override
  _Ddd2EeePageState createState() => _Ddd2EeePageState();
}

class _Ddd2EeePageState extends State<Ddd2EeePage> {
  TextEditingController _eeeAddressController = TextEditingController();
  TextEditingController _dddAmountController = TextEditingController();
  ChainType chainType;
  bool isShowExactGas = false;
  int precision = 8; //Decimal precision
  int eth2gasUnit = 1000 * 1000 * 1000; // 1 ETH = 1e9 gwei (10 to the ninth power) = 1e18 wei
  String Gwei = "Gwei";
  String arrowDownIcon = "assets/images/ic_expand.png";
  String arrowUpIcon = "assets/images/ic_collapse.png";
  String arrowIcon = "assets/images/ic_collapse.png";
  double mMaxGasPrice;
  double mMinGasPrice;
  double mMaxGasLimit;
  double mMinGasLimit;
  double mGasPriceValue;
  double mGasLimitValue;
  double mMaxGasFee;
  double mMinGasFee;
  double mGasFeeValue;
  String dddBalance = "";
  String ethBalance = "";
  String fromAddress = "";
  String toExchangeAddress = VendorConfig.MAIN_NET_DDD2EEE_RECEIVE_ETH_ADDRESS; //default MAIN_NET
  String nonce = "";
  int decimal = 0;

  @override
  void initState() {
    super.initState();
    initDataConfig();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mMaxGasPrice = GlobalConfig.getMaxGasPrice(GlobalConfig.EthGasPriceKey);
    mMinGasPrice = GlobalConfig.getMinGasPrice(GlobalConfig.EthGasPriceKey);
    mMaxGasLimit = GlobalConfig.getMaxGasLimit(GlobalConfig.EthGasLimitKey);
    mMinGasLimit = GlobalConfig.getMinGasLimit(GlobalConfig.EthGasLimitKey);
    mGasPriceValue = GlobalConfig.getDefaultGasPrice(GlobalConfig.EthGasPriceKey);
    mGasLimitValue = GlobalConfig.getDefaultGasLimit(GlobalConfig.EthGasLimitKey);

    mMaxGasFee = mMaxGasLimit * mMaxGasPrice / eth2gasUnit;
    mMinGasFee = mMinGasLimit * mMinGasPrice / eth2gasUnit;
    mGasFeeValue = mGasLimitValue * mGasPriceValue / eth2gasUnit;
  }

  void initDataConfig() async {
    if (Wallets.instance.nowWallet == null) {
      await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true);
    }
    //case nowChain is not eth or eth_test
    switch (Wallets.instance.nowWallet.walletType) {
      case WalletType.WALLET:
        chainType = ChainType.ETH;
        break;
      case WalletType.TEST_WALLET:
        chainType = ChainType.ETH_TEST;
        break;
    }
    fromAddress = Wallets.instance.nowWallet.getChainByChainType(chainType).chainAddress;
    toExchangeAddress =
        chainType == ChainType.ETH ? VendorConfig.MAIN_NET_DDD2EEE_RECEIVE_ETH_ADDRESS : VendorConfig.TEST_NET_DDD2EEE_RECEIVE_ETH_ADDRESS;
    ethBalance = await loadEthBalance(fromAddress, chainType);
    dddBalance = await loadErc20Balance(fromAddress, chainType == ChainType.ETH ? DddMainNetContractAddress : DddTestNetContractAddress, chainType);
    setState(() {
      toExchangeAddress = toExchangeAddress;
      if (dddBalance != null) {
        _dddAmountController.text = dddBalance;
      }
    });
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
          centerTitle: translate('token_exchange'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildTransferEthWidget(),
        ),
      ),
    );
  }

  Widget _buildTransferEthWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.scaleVGap(4),
            _buildInstructionWidget(),
            Gaps.scaleVGap(5),
            _buildFromAddressWidget(),
            Gaps.scaleVGap(5),
            _buildToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildDddAmountWidget(),
            Gaps.scaleVGap(3),
            _buildEeeAddressWidget(),
            Gaps.scaleVGap(5),
            _buildGasFeeWidget(),
            Gaps.scaleVGap(3),
            _buildHideDetailWidget(),
            Gaps.scaleVGap(3),
            _buildExchangeBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_instruction'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: translate('exchange_instruction_content_hint1'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    )),
                TextSpan(
                    text: translate('exchange_instruction_content_hint2'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFromAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_from_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              fromAddress ?? "",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
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
              translate('exchange_to_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              toExchangeAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDddAmountWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_ddd_amount'),
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
                hintText: translate('pls_input_exchange_amount'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: ScreenUtil().setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _dddAmountController,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[0-9.]")), //Enter only numbers or decimal point.
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEeeAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('to_eee_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(13),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(13),
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
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
                        bottom: ScreenUtil().setHeight(0),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                      hintText: translate('pls_input_eee_address'),
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
                    controller: _eeeAddressController,
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
                          Fluttertoast.showToast(msg: translate("camera_permission_deny"), timeInSecForIos: 8);
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
      print("qrResult===>" + qrResult.toString());
      setState(() {
        _eeeAddressController.text = qrResult.toString();
      });
    } catch (e) {
      LogUtil.e("TransferEthPage", "qrscan appear unknow error===>" + e.toString());
      Fluttertoast.showToast(msg: translate('unknown_error_in_scan_qr_code'), timeInSecForIos: 3);
    }
  }

  Widget _buildGasFeeWidget() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(40),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      translate('mine_fee'),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil().setWidth(40),
                    child: Text(
                      Utils.formatDouble(mGasFeeValue, precision: precision).toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Container(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blueAccent,
              activeTickMarkColor: Colors.white,
              inactiveTickMarkColor: Colors.white,
              inactiveTrackColor: Colors.white70,
              valueIndicatorColor: Colors.blue,
              thumbColor: Colors.white,
              overlayColor: Colors.blueAccent,
            ),
            child: new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(2)),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    mMinGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil().setSp(2.3),
                    ),
                  ),
                  new Expanded(
                      child: new Slider(
                    min: mMinGasFee,
                    max: mMaxGasFee,
                    onChanged: (double value) {
                      setState(() {
                        mGasFeeValue = Utils.formatDouble(value, precision: precision);
                      });
                    },
                    divisions: 100,
                    //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                    label: '$mGasFeeValue',
                    value: mGasFeeValue,
                  )),
                  new Text(
                    mMaxGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil().setSp(2.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gaps.scaleVGap(1),
        Container(
          color: Colors.transparent,
          child: GestureDetector(
              onTap: () async {
                setState(() {
                  isShowExactGas = !isShowExactGas;
                  if (isShowExactGas) {
                    arrowIcon = arrowDownIcon;
                  } else {
                    arrowIcon = arrowUpIcon;
                  }
                });
              },
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil().setWidth(75),
                    child: Text(
                      translate('high_setting').toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: ScreenUtil().setSp(2.5),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(1)),
                    child: Image.asset(arrowIcon),
                  ),
                ],
              )),
        ),
        Gaps.scaleVGap(5),
      ],
    ));
  }

  Widget _buildHideDetailWidget() {
    return isShowExactGas
        ? AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isShowExactGas ? 1.0 : 0.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(40),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  translate('gas_price').toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    fontSize: ScreenUtil().setSp(2.5),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                width: ScreenUtil().setWidth(40),
                                child: Text(
                                  Utils.formatDouble(mGasPriceValue, precision: precision).toString() + " wei",
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    fontSize: ScreenUtil().setSp(2.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.pink,
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: Colors.white,
                            inactiveTrackColor: Colors.white70,
                            valueIndicatorColor: Colors.grey,
                            thumbColor: Colors.white,
                            overlayColor: Colors.pink,
                          ),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  mMinGasPrice.toString() + Gwei,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                                new Expanded(
                                    child: new Slider(
                                  min: mMinGasPrice,
                                  max: mMaxGasPrice,
                                  onChanged: (double value) {
                                    setState(() {
                                      mGasPriceValue = value;
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
                                      print("===>" + mGasPriceValue.toString() + "||===>" + mGasFeeValue.toString());
                                    });
                                  },
                                  divisions: 100,
                                  //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                                  label: '$mGasPriceValue',
                                  value: mGasPriceValue,
                                )),
                                new Text(
                                  mMaxGasPrice.toString() + Gwei,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(40),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translate('gas_limit').toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  width: ScreenUtil().setWidth(40),
                                  child: Text(
                                    mGasLimitValue.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.pink,
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: Colors.white,
                            inactiveTrackColor: Colors.white70,
                            valueIndicatorColor: Colors.grey,
                            thumbColor: Colors.white,
                            overlayColor: Colors.pink,
                          ),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  mMinGasLimit.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                                new Expanded(
                                    child: new Slider(
                                  min: mMinGasLimit,
                                  max: mMaxGasLimit,
                                  onChanged: (double value) {
                                    setState(() {
                                      mGasLimitValue = value;
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
                                      print("===>" + mGasLimitValue.toString() + "||===>" + mGasFeeValue.toString());
                                    });
                                  },
                                  divisions: 100,
                                  //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                                  label: '$mGasLimitValue',
                                  value: mGasLimitValue,
                                )),
                                new Text(
                                  mMaxGasLimit.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Gaps.scaleHGap(1);
  }

  Widget _buildExchangeBtnWidget() {
    return GestureDetector(
      onTap: () async {
        showProgressDialog(context, translate("check_data_format"));
        var verifyTxInfoResult = await _verifyTransferInfo();
        NavigatorUtils.goBack(context);
        if (!verifyTxInfoResult) {
          return;
        }
        Provider.of<TransactionProvide>(context)
          ..emptyDataRecord()
          ..setFromAddress(fromAddress)
          ..setBackup(_eeeAddressController.text)
          ..setValue(_dddAmountController.text)
          ..setGasPrice(mGasPriceValue.toInt().toString())
          ..setGas(mGasLimitValue.toInt().toString());
        NavigatorUtils.push(context, Routes.ddd2eeeConfirmPage);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().setWidth(41),
        height: ScreenUtil().setHeight(9),
        color: Color.fromRGBO(26, 141, 198, 0.20),
        child: FlatButton(
          child: Text(
            translate('click_to_exchange'),
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

  Future<bool> _verifyTransferInfo() async {
    if (_eeeAddressController.text.trim() == "") {
      Fluttertoast.showToast(msg: translate('to_address_null').toString(), timeInSecForIos: 3);
      return false;
    }

    //todo check eeeAddress by eee rule
    /* if (!Utils.checkByEthAddressFormat(_eeeAddressController.text)) {
      Fluttertoast.showToast(msg: translate("to_address_format_wrong"), timeInSecForIos: 5);
      return false;
    }*/

    if (_dddAmountController.text.trim() == "" || double.parse(_dddAmountController.text.trim()) <= 0) {
      Fluttertoast.showToast(msg: translate('tx_value_is_0').toString(), timeInSecForIos: 3);
      return false;
    }
    if (dddBalance == null || dddBalance == "" || double.parse(dddBalance) <= 0) {
      try {
        dddBalance = await loadErc20Balance(Wallets.instance.nowWallet.getChainByChainType(chainType).chainAddress,
            chainType == ChainType.ETH ? DddMainNetContractAddress : DddTestNetContractAddress, chainType);
      } catch (e) {
        Fluttertoast.showToast(msg: translate('unknown_in_value'));
        return false;
      }
    }
    if (_dddAmountController.text.isNotEmpty) {
      try {
        if (double.parse(dddBalance) < double.parse(_dddAmountController.text)) {
          Fluttertoast.showToast(msg: translate('balance_is_less'));
          return false;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: translate('unknown_in_value'));
        return false;
      }
    }
    if (ethBalance == null || ethBalance == "" || double.parse(ethBalance) <= 0) {
      try {
        ethBalance = await loadEthBalance(Wallets.instance.nowWallet.getChainByChainType(chainType).chainAddress, chainType);
      } catch (e) {
        Fluttertoast.showToast(msg: translate('unknown_in_value'));
        return false;
      }
    }
    if (ethBalance != null && ethBalance.isNotEmpty) {
      try {
        if (double.parse(ethBalance) <= 0) {
          Fluttertoast.showToast(msg: translate("not_enough_for_gas"));
          return false;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: translate("eth_balance_error") + e.toString());
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: translate("check_gas_state_failure"));
      return false;
    }
    return true;
  }
}
