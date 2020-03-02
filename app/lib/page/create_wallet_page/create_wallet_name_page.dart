import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';

class CreateWalletNamePage extends StatefulWidget {
  @override
  _CreateWalletNamePageState createState() => _CreateWalletNamePageState();
}

class _CreateWalletNamePageState extends State<CreateWalletNamePage> {
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
    _pwdController.addListener(_listenWalletName); //监听密码 输入框
    _confirmPwdController.addListener(_listenPwd); //监听确认密码 输入框
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
          centerTitle: S.of(context).create_wallet,
          backgroundColor: Colors.transparent,
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
      child: FlatButton(
        onPressed: () {
          if (_verifyToCreateWallet()) {
            Provider.of<CreateWalletProcessProvide>(context).setWalletName(_nameController.text);
            Provider.of<CreateWalletProcessProvide>(context).setPwd(Uint8List.fromList(_pwdController.text.codeUnits));
            NavigatorUtils.push(context, Routes.createWalletMnemonicPage);
          }
        },
        child: Container(
          width: ScreenUtil().setWidth(41),
          child: Text(
            S.of(context).add_wallet,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
              fontSize: ScreenUtil.instance.setSp(3.5),
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
              S.of(context).wallet_name,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
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
              S.of(context).wallet_pwd,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil.instance.setSp(3.5),
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
                hintText: S.of(context).advice_pwd_format,
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
              S.of(context).pls_pwd_again,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil.instance.setSp(3.5),
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
                hintText: S.of(context).pls_ensure_confirm_pwd.toString(),
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
            S.of(context).choose_multi_chain,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.85),
              fontSize: ScreenUtil.instance.setSp(3.5),
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
                  S.of(context).eth_token_name,
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
      Fluttertoast.showToast(msg: S.of(context).wallet_name_not_null);
      return;
    }
  }

  void _listenPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).pwd_not_null);
      return;
    }
  }

  bool _verifyToCreateWallet() {
    //验证：数据不为空
    if (_nameController.text.isEmpty ||
        _nameController.text.length < 1 ||
        _pwdController.text.isEmpty ||
        _pwdController.text.length < 1 ||
        _confirmPwdController.text.isEmpty ||
        _confirmPwdController.text.length < 1) {
      Fluttertoast.showToast(msg: S.of(context).some_info_is_null);
      return false;
    }
    //验证：两次密码一致
    if (_confirmPwdController.text != _pwdController.text) {
      Fluttertoast.showToast(msg: S.of(context).pwd_is_not_same);
      return false;
    }
    //验证：勾选 链
    if (!_eeeChainChoose) {
      Fluttertoast.showToast(msg: S.of(context).pls_ensure_eee_chain);
      return false;
    }
    return true;
  }
}
