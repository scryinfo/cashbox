import 'dart:typed_data';

import 'package:app/control/qr_scan_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallets/enums.dart' as EnumKit;

class CreateTestWalletPage extends StatefulWidget {
  @override
  _CreateTestWalletPageState createState() => _CreateTestWalletPageState();
}

class _CreateTestWalletPageState extends State<CreateTestWalletPage> {
  bool _isChooseEthChain = true;
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _mnemonicController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _lastPressedAt; //上次点击时间
  @override
  void initState() {
    super.initState();
    _nameController.text = translate('test_wallet_title');
    changeMnemonic();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          // 两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false; // 不退出
        }
        _getBackToMainNet(); // not finish create test wallet
        return true; //退出
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(
            centerTitle: translate('create_test_wallet'),
            backgroundColor: Colors.transparent,
            actionName: translate('back_main_net'),
            isBack: false,
            onPressed: () async {
              _getBackToMainNet();
            },
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
            ),
            child: _buildTestWalletWidget(),
          ),
        ),
      ),
    );
  }

  _getBackToMainNet() async {
    bool isChangeNetOk = WalletsControl.getInstance().changeNetType(EnumKit.NetType.Main);
    if (!isChangeNetOk) {
      return;
    }
    NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
  }

  Widget _buildTestWalletWidget() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(160),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(2),
            Container(
              width: ScreenUtil().setWidth(80),
              child: Text(
                translate('test_wallet_and_mnemonic'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(4),
                ),
              ),
            ),
            Gaps.scaleVGap(1.5),
            Container(
              width: ScreenUtil().setWidth(80),
              child: Text(
                translate('judge_the_difference_between_two_wallet'),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: ScreenUtil().setSp(3),
                ),
                maxLines: 2,
              ),
            ),
            Gaps.scaleVGap(2.5),
            _buildVerifyInputMnemonic(),
            Gaps.scaleVGap(4),
            _buildChangeMnemonicWidget(),
            Gaps.scaleVGap(5),
            _buildWalletNameWidget(),
            Gaps.scaleVGap(5),
            _buildPwdWidget(),
            Gaps.scaleVGap(5),
            _buildChainChooseLayout(),
            Gaps.scaleVGap(12),
            _buildCreateBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyInputMnemonic() {
    return SingleChildScrollView(
      child: Container(
        height: ScreenUtil().setHeight(40),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(5),
          bottom: ScreenUtil().setWidth(5),
          right: ScreenUtil().setWidth(5),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.06),
          border: Border.all(
            width: 0.5,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              child: TextField(
                controller: _mnemonicController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3.5),
                  wordSpacing: 5,
                ),
                maxLines: 3,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  var status = await Permission.camera.status;
                  if (status.isGranted) {
                    _scanQrContent();
                  } else {
                    Map<Permission, PermissionStatus> statuses = await [Permission.camera].request();
                    if (statuses[Permission.camera] == PermissionStatus.granted) {
                      _scanQrContent();
                    } else {
                      Fluttertoast.showToast(
                          msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
                    }
                  }
                },
                child: Image.asset("assets/images/ic_scan.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scanQrContent() {
    Future<String> qrResult = QrScanControl.instance.qrscan();
    qrResult.then((t) {
      setState(() {
        _mnemonicController.text = t.toString();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: translate('qr_scan_unknown_error'));
    });
  }

  Widget _buildChangeMnemonicWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          changeMnemonic();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/ic_refresh.png"),
            ),
            Container(
              child: Text(
                translate('change_another_group'),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Gaps.scaleHGap(1),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletNameWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('wallet_name'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(4),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                // hintText: translate('pls_input_wallet_name'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _nameController,
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
              translate('wallet_pwd'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: translate('pls_set_wallet_pwd'),
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
              controller: _pwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChainChooseLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('choose_multi_chain'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    /*Container(
                        child: Opacity(
                      opacity: 0,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isChooseEeeChain,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  _isChooseEeeChain = newValue;
                                },
                              );
                            },
                          ),
                          Text(
                            translate('eee_chain_test,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(3),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Gaps.scaleHGap(5),                    */
                    Container(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isChooseEthChain,
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _isChooseEthChain = newValue;
                                });
                              }
                            },
                          ),
                          Text(
                            translate('eth_test_chain_name'), //eth_test_chain_name
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateBtn() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: ScreenUtil().setWidth(41),
      height: ScreenUtil().setHeight(9),
      color: Color.fromRGBO(26, 141, 198, 0.20),
      child: TextButton(
        onPressed: () async {
          _createTestWallet();
        },
        child: Text(
          translate('add_wallet'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 0.03,
            fontSize: ScreenUtil().setSp(3.2),
          ),
        ),
      ),
    );
  }

  void changeMnemonic() async {
    String mneStr = WalletsControl.getInstance().generateMnemonic(12);
    if (mneStr.isEmpty) {
      Logger().e("CreateWalletMnemonicPage=>", "mnemonic is null");
      return;
    }
    setState(() {
      _mnemonicController.text = mneStr;
      mneStr = "";
    });
  }

  bool _verifyWalletName() {
    if (_nameController.text.isEmpty || _nameController.text.length <= 0) {
      return false;
    } else {
      return true;
    }
  }

  bool _verifyPwdAndMnemonic() {
    //Mnemonic password is not empty
    if (_pwdController.text.isEmpty ||
        _pwdController.text.length <= 0 ||
        _mnemonicController.text.isEmpty ||
        _mnemonicController.text.length <= 0) {
      return false;
    } else {
      return true;
    }
  }

  _createTestWallet() async {
    bool isNameOk = _verifyWalletName();
    if (!isNameOk) {
      Fluttertoast.showToast(msg: translate('wallet_name_not_allow_is_null'));
      return;
    }
    bool isOk = _verifyPwdAndMnemonic();
    if (!isOk) {
      Fluttertoast.showToast(msg: translate('mne_pwd_not_allow_is_null'));
      return;
    }

    var newWalletObj = WalletsControl.getInstance().createWallet(Uint8List.fromList(_mnemonicController.text.codeUnits),
        EnumKit.WalletType.Test, _nameController.text, Uint8List.fromList(_pwdController.text.codeUnits));
    if (newWalletObj == null) {
      Fluttertoast.showToast(msg: translate('failure_create_test_wallet'));
      return;
    }
    bool isChangeNetOk = WalletsControl.getInstance().changeNetType(EnumKit.NetType.Test);
    if (!isChangeNetOk) {
      Fluttertoast.showToast(msg: translate('failure_create_test_wallet'));
      return;
    }
    Fluttertoast.showToast(msg: translate('success_create_test_wallet'));
    WalletsControl.getInstance().saveCurrentWalletChain(newWalletObj.id, EnumKit.ChainType.EthTest);
    NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=true', clearStack: true);
  }
}
