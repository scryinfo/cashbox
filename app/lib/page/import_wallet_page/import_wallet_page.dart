import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';

class ImportWalletPage extends StatefulWidget {
  @override
  _ImportWalletPageState createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  TextEditingController _mneController = TextEditingController();
  TextEditingController _walletNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  bool _eeeChainChoose = true;
  var mneString = "";

  @override
  void initState() {
    super.initState();
    _walletNameController.addListener(_listenMnemonic);
    _pwdController.addListener(_listenWalletName);
    _confirmPwdController.addListener(_listenPwd);
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
          centerTitle: S.of(context).import_wallet,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildImportWalletWidget(),
        ),
      ),
    );
  }

  Widget _buildImportWalletWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(2),
            _buildMnemonicWidget(),
            Gaps.scaleVGap(3),
            _buildWalletNameWidget(),
            Gaps.scaleVGap(5),
            _buildPwdWidget(),
            Gaps.scaleVGap(5),
            _buildConfirmPwdWidget(),
            Gaps.scaleVGap(5),
            _buildChainChooseLayout(),
            Gaps.scaleVGap(8),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () async {
                  _checkAndDoImportWallet();
                },
                child: Text(
                  S.of(context).import_wallet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.03,
                    fontSize: ScreenUtil.instance.setSp(3.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMnemonicWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).mnemonic,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 16,
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            //height: ScreenUtil().setHeight(30),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(30),
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: 15,
                    ),
                    maxLines: 4,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setHeight(5),
                        right: ScreenUtil().setWidth(5),
                        top: ScreenUtil().setHeight(7),
                        bottom: ScreenUtil().setHeight(7),
                      ),
                      labelText: mneString,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                      ),
                      hintText: S.of(context).pls_input_mnemonic,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    controller: _mneController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(30),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(5),
                    right: ScreenUtil().setWidth(3),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      Future<String> qrResult = QrScanUtil.instance.qrscan();
                      qrResult.then((t) {
                        setState(() {
                          mneString = t.toString();
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

  Widget _buildWalletNameWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).wallet_name,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 16,
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
                hintText: S.of(context).pls_input_wallet_name,
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
              controller: _walletNameController,
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
                fontSize: 16,
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
                hintText: S.of(context).input_format_hint,
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
              controller: _pwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPwdWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).ensure_pwd,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 16,
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
                hintText: S.of(context).pls_pwd_again,
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
              controller: _confirmPwdController,
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
            S.of(context).choose_multi_chain,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 13,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Checkbox(
                  value: _eeeChainChoose,
                  onChanged: (newValue) {
                    setState(
                      () {
                        _eeeChainChoose = newValue;
                      },
                    );
                  },
                ),
                Text(
                  "ETH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            )),
          ],
        ),
      ],
    ));
  }

  //验证 助记词 不能为空
  void _listenMnemonic() {
    String mnemonic = _mneController.text;
    if (mnemonic.isEmpty || mnemonic.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).mnemonic_is_not_null);
      return;
    }
  }

  //验证 钱包名 不能为空
  void _listenWalletName() {
    String name = _walletNameController.text;
    if (name.isEmpty || name.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).wallet_name_not_null);
      return;
    }
  }

  //验证 钱包名 不能为空
  void _listenPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).pwd_not_null);
      return;
    }
  }

  bool _verifyImportWallet() {
    String mnemonic = _mneController.text;
    String walletName = _walletNameController.text;
    String pwd = _pwdController.text;
    String confirmPwd = _confirmPwdController.text;
    if (mnemonic.isEmpty ||
        mnemonic.length < 1 ||
        walletName.isEmpty ||
        walletName.length < 1 ||
        pwd.isEmpty ||
        pwd.length < 1 ||
        confirmPwd.isEmpty ||
        confirmPwd.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).some_info_is_null);
      return false;
    }
    if (pwd.toString() != confirmPwd.toString()) {
      Fluttertoast.showToast(msg: S.of(context).pwd_is_not_same);
      return false;
    }
    return true;
  }

  Future _checkAndDoImportWallet() async {
    if (_verifyImportWallet()) {
      var isSuccess = await Wallets.instance.saveWallet(_walletNameController.text, Uint8List.fromList(_pwdController.text.codeUnits),
          Uint8List.fromList(_mneController.text.codeUnits), WalletType.WALLET);
      if (isSuccess) {
        NavigatorUtils.push(
          context,
          Routes.ethPage,
          clearStack: true,
        );
      } else {
        Fluttertoast.showToast(msg: S.of(context).verify_failure_to_mnemonic);
      }
    }
  }
}
