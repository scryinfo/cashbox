import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';

class TransferEthPage extends StatefulWidget {
  @override
  _TransferEthPageState createState() => _TransferEthPageState();
}

class _TransferEthPageState extends State<TransferEthPage> {
  TextEditingController _toAddrController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _extendMsgController = TextEditingController();
  String toAddrString;
  bool isShowExactGas = false;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initGasConfig();
    mMaxGasPrice = GlobalConfig.getMaxGasPrice("eth");
    mMinGasPrice = GlobalConfig.getMinGasPrice("eth");
    mMaxGasLimit = GlobalConfig.getMaxGasLimit("eth");
    mMinGasLimit = GlobalConfig.getMinGasLimit("eth");
    mGasPriceValue = GlobalConfig.getDefaultGasPrice("eth");
    mGasLimitValue = GlobalConfig.getDefaultGasLimit("eth");
    mMaxGasFee = mMaxGasLimit * mMaxGasPrice / (1000 * 1000 * 1000);
    mMinGasFee = mMinGasLimit * mMinGasPrice / (1000 * 1000 * 1000);
    mGasFeeValue = mGasLimitValue * mGasPriceValue / (1000 * 1000 * 1000);
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
          centerTitle: S.of(context).wallet_transfer,
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

  bool _verifyTransferInfo() {
    return true;
  }

  void initGasConfig() {}

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
            _buildToAddrWidget(),
            Gaps.scaleVGap(5),
            _buildValueWidget(),
            Gaps.scaleVGap(5),
            _buildPwdWidget(),
            Gaps.scaleVGap(5),
            _buildGasFeeWidget(),
            Gaps.scaleVGap(5),
            _buildHideDetailWidget(),
            Gaps.scaleVGap(15),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () async {
                  if (_verifyTransferInfo()) {
                    Wallet wallet = await Wallets.instance.getNowWalletModel();
                    ChainEEE chainEEE = wallet.getChainByChainType(ChainType.EEE);
                    //todo 1009 parker
                    Map map = await chainEEE.eeeEnergyTransfer("5FYmQQAcL3LyRM215UjXKZhDVBWens66BEL5SoN4qw4JQeuB",
                        Uint8List.fromList(_pwdController.text.codeUnits), _toAddrController.text, _valueController.text, _extendMsgController.text);
                    //NavigatorUtils.push(
                    //  context,
                    //  Routes.eeePage,
                    //  clearStack: true,
                    //);
                  }
                },
                child: Text(
                  S.of(context).click_to_transfer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                    width: ScreenUtil.instance.setWidth(40),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "矿工费",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil.instance.setWidth(40),
                    child: Text(
                      Utils.formatDouble(mGasFeeValue, 8).toString() + "eth",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil.instance.setSp(3),
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
              margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(2)),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    mMinGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil.instance.setSp(2.3),
                    ),
                  ),
                  new Expanded(
                      child: new Slider(
                    min: mMinGasFee,
                    max: mMaxGasFee,
                    onChanged: (double value) {
                      setState(() {
                        mGasFeeValue = Utils.formatDouble(value, 6);
                        print("mGasFeeValue===>" + mGasFeeValue.toString());
                      });
                    },
                    divisions: 100,
                    //不想出现刻度和气泡,删除这个属性就可以了，自己实验
                    label: '$mGasFeeValue',
                    value: mGasFeeValue,
                  )),
                  new Text(
                    mMaxGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil.instance.setSp(2.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: GestureDetector(
              onTap: () async {
                setState(() {
                  isShowExactGas = !isShowExactGas;
                  if (isShowExactGas) {
                    arrowIcon = arrowDownIcon;
                  } else {
                    arrowIcon = arrowUpIcon;
                  }
                  print("isShowExactGas=-=====>" + isShowExactGas.toString());
                });
              },
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil.instance.setWidth(75),
                    child: Text(
                      "高级设置",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: ScreenUtil.instance.setSp(2.3),
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
    return isShowExactGas? AnimatedOpacity(
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
                            width: ScreenUtil.instance.setWidth(40),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gas Price",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: ScreenUtil.instance.setSp(2.5),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: ScreenUtil.instance.setWidth(40),
                            child: Text(
                              Utils.formatDouble(mGasPriceValue, 8).toString() + " wei",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: ScreenUtil.instance.setSp(2.5),
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
                            mMinGasPrice.toString() + "Gwei",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: ScreenUtil.instance.setSp(2.3),
                            ),
                          ),
                          new Expanded(
                              child: new Slider(
                            min: mMinGasPrice,
                            max: mMaxGasPrice,
                            onChanged: (double value) {
                              setState(() {
                                mGasPriceValue = value;
                                mGasFeeValue = mGasPriceValue * mGasLimitValue / (1000 * 1000 * 1000);
                                print("===>" + mGasPriceValue.toString() + "||===>" + mGasFeeValue.toString());
                              });
                            },
                            divisions: 100,
                            //不想出现刻度和气泡,删除这个属性就可以了，自己实验
                            label: '$mGasPriceValue',
                            value: mGasPriceValue,
                          )),
                          new Text(
                            mMaxGasPrice.toString() + "Gwei",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: ScreenUtil.instance.setSp(2.3),
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
                            width: ScreenUtil.instance.setWidth(40),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gas Limit",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: ScreenUtil.instance.setSp(2.5),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: ScreenUtil.instance.setWidth(40),
                            child: Text(
                              mGasLimitValue.toString(),
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                fontSize: ScreenUtil.instance.setSp(2.5),
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
                              fontSize: ScreenUtil.instance.setSp(2.3),
                            ),
                          ),
                          new Expanded(
                              child: new Slider(
                            min: mMinGasLimit,
                            max: mMaxGasLimit,
                            onChanged: (double value) {
                              setState(() {
                                mGasLimitValue = value;
                                mGasFeeValue = mGasPriceValue * mGasLimitValue / (1000 * 1000 * 1000);
                                print("===>" + mGasLimitValue.toString() + "||===>" + mGasFeeValue.toString());
                              });
                            },
                            divisions: 100,
                            //不想出现刻度和气泡,删除这个属性就可以了，自己实验
                            label: '$mGasLimitValue',
                            value: mGasLimitValue,
                          )),
                          new Text(
                            mMaxGasLimit.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: ScreenUtil.instance.setSp(2.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      S.of(context).extend_msg,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                    ),
                  ),
                  Gaps.scaleVGap(2),
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(13),
                    child: TextField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                        filled: true,
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintText: S.of(context).hint_extend_msg_option,
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: ScreenUtil.instance.setSp(3.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(1.0),
                          ),
                        ),
                      ),
                      controller: _extendMsgController,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ) : Gaps.scaleHGap(1);
  }

  Widget _buildToAddrWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).receive_address,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil.instance.setSp(3),
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
                      fontSize: ScreenUtil.instance.setSp(3.5),
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
                      labelText: toAddrString,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                      hintText: S.of(context).pls_input_receive_address,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    controller: _toAddrController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(12),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(3),
                    right: ScreenUtil().setWidth(3),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      Future<String> qrResult = QrScanUtil.instance.qrscan();
                      qrResult.then((t) {
                        setState(() {
                          toAddrString = t.toString();
                        });
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: S.of(context).unknown_error_in_scan_qr_code);
                      });
                    },
                    child: Image.asset("assets/images/ic_scan.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).transaction_amount,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil.instance.setSp(3),
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
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil.instance.setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.instance.setSp(3),
                ),
                hintText: S.of(context).pls_input_transaction_amount,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil.instance.setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _valueController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPwdWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).pwd,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil.instance.setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(13),
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: S.of(context).pls_input_wallet_pwd,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil.instance.setSp(3.5),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _pwdController,
            ),
          ),
        ],
      ),
    );
  }
}
