import 'dart:typed_data';

import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../res/styles.dart';
import '../../routers/fluro_navigator.dart';
import '../../routers/routers.dart';
import '../../widgets/app_bar.dart';

class CreateWalletNamePage extends StatefulWidget {
  @override
  _CreateWalletNamePageState createState() => _CreateWalletNamePageState();
}

class _CreateWalletNamePageState extends State<CreateWalletNamePage> {
  bool _ethChainChoose = true;
  bool _eeeChainChoose = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pwdController.addListener(_listenWalletName); //Monitor password input box
    _confirmPwdController.addListener(_listenPwd); //Monitor and confirm password input box
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_loading.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('create_wallet'),
          backgroundColor: Colors.transparent,
          onPressed: () {},
        ),
        body: _buildCreateWalletLayout(),
      ),
    );
  }

  Widget _buildCreateWalletLayout() {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(10),
            _buildWalletNameWidget(),
            Gaps.scaleVGap(8),
            _buildWalletPwdWidget(),
            Gaps.scaleVGap(8),
            _buildConfirmPwdWidget(),
            Gaps.scaleVGap(8),
            _buildChainChooseWidget(),
            Gaps.scaleVGap(8),
            _buildCreateBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateBtnWidget() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: ScreenUtil().setWidth(41),
      height: ScreenUtil().setHeight(9),
      color: Color.fromRGBO(26, 141, 198, 0.20),
      child: TextButton(
        onPressed: () {
          if (_verifyToCreateWallet()) {
            context.read<CreateWalletProcessProvide>().setWalletName(_nameController.text);
            context.read<CreateWalletProcessProvide>().setPwd(Uint8List.fromList(_pwdController.text.codeUnits));
            NavigatorUtils.push(context, Routes.createWalletMnemonicPage);
          }
        },
        child: Container(
          width: ScreenUtil().setWidth(41),
          child: Text(
            translate('create_wallet'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
              fontSize: ScreenUtil().setSp(3.5),
            ),
          ),
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
                hintText: translate('pls_input_wallet_name'),
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

  Widget _buildWalletPwdWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('wallet_pwd'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: translate('advice_pwd_format'),
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
              translate('pls_pwd_again'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: translate('pls_ensure_confirm_pwd'),
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

  Widget _buildChainChooseWidget() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            translate('choose_multi_chain'),
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.85),
              fontSize: ScreenUtil().setSp(3.5),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Checkbox(
                  value: _ethChainChoose,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(
                        () {
                          _ethChainChoose = newValue;
                        },
                      );
                    }
                  },
                ),
                Text(
                  translate('eth_token_name'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            )),
            Gaps.scaleHGap(5),
            Container(
                child: Row(
              children: <Widget>[
                Checkbox(
                  value: _eeeChainChoose,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(
                        () {
                          _eeeChainChoose = newValue;
                        },
                      );
                    }
                  },
                ),
                Text(
                  translate('eee_token_name'),
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

  void _listenWalletName() {
    String name = _nameController.text;
    if (name.isEmpty || name.length < 1) {
      Fluttertoast.showToast(msg: translate('wallet_name_not_null'));
      return;
    }
  }

  void _listenPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: translate('pwd_not_null'));
      return;
    }
  }

  bool _verifyToCreateWallet() {
    //Verification: data is not empty
    if (_nameController.text.isEmpty ||
        _nameController.text.length < 1 ||
        _pwdController.text.isEmpty ||
        _pwdController.text.length < 1 ||
        _confirmPwdController.text.isEmpty ||
        _confirmPwdController.text.length < 1) {
      Fluttertoast.showToast(msg: translate('some_info_is_null'));
      return false;
    }
    //Verification: the two passwords are consistent
    if (_confirmPwdController.text != _pwdController.text) {
      Fluttertoast.showToast(msg: translate('pwd_is_not_same'));
      return false;
    }
    //Verification: check the chain
    if (!_ethChainChoose) {
      Fluttertoast.showToast(msg: translate('pls_ensure_eth_chain'));
      return false;
    }
    return true;
  }
}
