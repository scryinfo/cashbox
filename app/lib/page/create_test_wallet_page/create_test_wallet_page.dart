import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';

class CreateTestWalletPage extends StatefulWidget {
  @override
  _CreateTestWalletPageState createState() => _CreateTestWalletPageState();
}

class _CreateTestWalletPageState extends State<CreateTestWalletPage> {
  bool _isChooseEeeChain = true;
  bool _isChooseEthChain = true;
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _mnemonicController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = translate('test_wallet_title');
    changeMnemonic();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('create_test_wallet'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildTestWalletWidget(),
        ),
      ),
    );
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
                  Future<String> qrResult = QrScanUtil.instance.qrscan();
                  qrResult.then((t) {
                    setState(() {
                      _mnemonicController.text = t.toString();
                    });
                  }).catchError((e) {
                    Fluttertoast.showToast(msg: translate('qr_scan_unknown_error'));
                  });
                },
                child: Image.asset("assets/images/ic_scan.png"),
              ),
            ),
          ],
        ),
      ),
    );
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
                fontSize: ScreenUtil.instance.setSp(4),
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
                fontSize: ScreenUtil.instance.setSp(3.5),
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
                  fontSize: ScreenUtil.instance.setSp(3),
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
                fontSize: ScreenUtil.instance.setSp(3.5),
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
                              fontSize: ScreenUtil.instance.setSp(3),
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
                              setState(
                                () {
                                  _isChooseEthChain = newValue;
                                },
                              );
                            },
                          ),
                          Text(
                            translate('eth_test_chain_name'), //eth_test_chain_name
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.instance.setSp(3),
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
      child: FlatButton(
        onPressed: () async {
          _createTestWallet();
        },
        child: Text(
          translate('add_wallet'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 0.03,
            fontSize: ScreenUtil.instance.setSp(3.2),
          ),
        ),
      ),
    );
  }

  void changeMnemonic() async {
    var mnemonic = await Wallets.instance.createMnemonic(12);
    if (mnemonic == null) {
      LogUtil.e("CreateWalletMnemonicPage=>", "mnemonic is null");
      return;
    }
    setState(() {
      _mnemonicController.text = String.fromCharCodes(mnemonic);
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
    //助记词密码不为空
    if (_pwdController.text.isEmpty || _pwdController.text.length <= 0 || _mnemonicController.text.isEmpty || _mnemonicController.text.length <= 0) {
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
    var isSuccess = await Wallets.instance.saveWallet(_nameController.text, Uint8List.fromList(_pwdController.text.codeUnits),
        Uint8List.fromList(_mnemonicController.text.codeUnits), WalletType.TEST_WALLET);
    if (isSuccess) {
      Fluttertoast.showToast(msg: translate('success_create_test_wallet'));
      NavigatorUtils.push(context, Routes.entryPage, clearStack: true);
    } else {
      Fluttertoast.showToast(msg: translate('failure_create_test_wallet'));
    }
  }
}
