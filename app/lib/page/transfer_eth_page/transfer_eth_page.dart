import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';

class TransferEthPage extends StatefulWidget {
  @override
  _TransferEthPageState createState() => _TransferEthPageState();
}

class _TransferEthPageState extends State<TransferEthPage> {
  TextEditingController _toAddressController = TextEditingController();
  TextEditingController _txValueController = TextEditingController();
  TextEditingController _backupMsgController = TextEditingController();
  String toAddressValue;
  bool isShowExactGas = false;
  int standardAddressLength = 42; //以太坊标准地址42位
  int eth2gasUnit = 1000 * 1000 * 1000; // 1 ETH = 1e9 gwei (10的九次方) = 1e18 wei
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
  String fromAddress = "";
  String contractAddress = "";
  int decimal = 0;

  @override
  void initState() {
    super.initState();
  }

  void initDataConfig() {
    {
      fromAddress = Provider.of<TransactionProvide>(context).fromAddress;
      contractAddress = Provider.of<TransactionProvide>(context).contractAddress;
      decimal = Provider.of<TransactionProvide>(context).decimal;
    }
    _txValueController.text = Provider.of<TransactionProvide>(context).txValue ?? "";
    _toAddressController.text = Provider.of<TransactionProvide>(context).toAddress ?? "";
    _backupMsgController.text = Provider.of<TransactionProvide>(context).backup ?? "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initDataConfig();
    if (contractAddress != null && contractAddress.trim() != "") {
      mMaxGasPrice = GlobalConfig.getMaxGasPrice(GlobalConfig.Erc20GasPriceKey);
      mMinGasPrice = GlobalConfig.getMinGasPrice(GlobalConfig.Erc20GasPriceKey);
      mMaxGasLimit = GlobalConfig.getMaxGasLimit(GlobalConfig.Erc20GasLimitKey);
      mMinGasLimit = GlobalConfig.getMinGasLimit(GlobalConfig.Erc20GasLimitKey);
      mGasPriceValue = GlobalConfig.getDefaultGasPrice(GlobalConfig.Erc20GasPriceKey);
      mGasLimitValue = GlobalConfig.getDefaultGasLimit(GlobalConfig.Erc20GasLimitKey);
    } else {
      mMaxGasPrice = GlobalConfig.getMaxGasPrice(GlobalConfig.EthGasPriceKey);
      mMinGasPrice = GlobalConfig.getMinGasPrice(GlobalConfig.EthGasPriceKey);
      mMaxGasLimit = GlobalConfig.getMaxGasLimit(GlobalConfig.EthGasLimitKey);
      mMinGasLimit = GlobalConfig.getMinGasLimit(GlobalConfig.EthGasLimitKey);
      mGasPriceValue = GlobalConfig.getDefaultGasPrice(GlobalConfig.EthGasPriceKey);
      mGasLimitValue = GlobalConfig.getDefaultGasLimit(GlobalConfig.EthGasLimitKey);
    }
    mMaxGasFee = mMaxGasLimit * mMaxGasPrice / eth2gasUnit;
    mMinGasFee = mMinGasLimit * mMinGasPrice / eth2gasUnit;
    mGasFeeValue = mGasLimitValue * mGasPriceValue / eth2gasUnit;
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
    if (_toAddressController.text.trim() == "") {
      Fluttertoast.showToast(msg: "请检查对方地址不能为空");
      return false;
    }
    // todo 暂时放开
    // if (_toAddressController.text.length != standardAddressLength) {
    //   Fluttertoast.showToast(msg: "对方地址格式 有问题");
    //   return false;
    // }
    if (_txValueController.text.trim() == "" || double.parse(_txValueController.text.trim()) <= 0) {
      Fluttertoast.showToast(msg: "转账数额不能为空，或者小于0");
      return false;
    }
    return true;
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
            _buildGasFeeWidget(),
            Gaps.scaleVGap(3),
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
                    _showPwdDialog(context);
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
        Gaps.scaleVGap(1),
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
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
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
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
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
                              contentPadding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
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
                            controller: _backupMsgController,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Gaps.scaleHGap(1);
  }

  Widget _buildToAddressWidget() {
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
                      labelText: toAddressValue,
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
                    controller: _toAddressController,
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
                          toAddressValue = t.toString();
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
              controller: _txValueController,
            ),
          ),
        ],
      ),
    );
  }

  void _showPwdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: "钱包密码",
          hintContent: "提示：请输入您的密码,进行签名操作。",
          hintInput: "请输入钱包密码",
          onPressed: (String pwd) async {
            print("_showPwdDialog pwd is ===>" + pwd);

            Wallet walletModel = await Wallets.instance.getNowWalletModel();
            ChainETH chainETH = walletModel.getChainByChainType(ChainType.ETH);
            String walletId = await Wallets.instance.getNowWalletId();
            String nonce = await loadTxAccount(fromAddress);
            if (nonce == null || nonce.trim() == "") {
              print("取的nonce值有问题");
              return;
            }
            // todo  链类型处理
            // todo  gas费单位统一
            var result = Wallets.instance.ethTxSign(
                walletId,
                chainETH.chainTypeToInt(ChainType.ETH),
                fromAddress,
                _toAddressController.text.toString(),
                contractAddress,
                _txValueController.text,
                _backupMsgController.text,
                Uint8List.fromList(pwd.codeUnits),
                mGasFeeValue.toString(),
                mGasLimitValue.toString(),
                nonce,
                decimal: decimal);
            // NavigatorUtils.push(
            //   context,
            //   Routes.eeePage,
            //   clearStack: true,
            // );
          },
        );
      },
    );
  }
}
