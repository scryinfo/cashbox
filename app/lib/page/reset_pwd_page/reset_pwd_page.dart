import 'dart:typed_data';

import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';
import '../../widgets/list_item.dart';

class ResetPwdPage extends StatefulWidget {
  @override
  _ResetPwdPageState createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "重置密码",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildResetPwdWidget(),
        ),
      ),
    );
  }

  Widget _buildResetPwdWidget() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(5),
          right: ScreenUtil().setWidth(5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(10),
              _buildOldPwdLayout(),
              Gaps.scaleVGap(8),
              _buildNewPwdLayout(),
              Gaps.scaleVGap(8),
              _buildConfirmNewPwdLayout(),
              Gaps.scaleVGap(8),
              Container(
                alignment: Alignment.bottomCenter,
                width: ScreenUtil().setWidth(41),
                height: ScreenUtil().setHeight(9),
                color: Color.fromRGBO(26, 141, 198, 0.20),
                child: FlatButton(
                  onPressed: () async {
                    if (_verifyPwdSame()) {
                      String walletId = Provider
                          .of<WalletManagerProvide>(context)
                          .walletId;
                      Wallet wallet = await Wallets.instance.getWalletByWalletId(walletId);
                      String pwd = _oldPwdController.text.toString();
                      print("reset_pwd_page==>" + pwd.codeUnits.toString()); //[B@6922d7e
                      await wallet.resetPwd(
                          Uint8List.fromList(_newPwdController.text.codeUnits), Uint8List.fromList(_oldPwdController.text.codeUnits));

                      NavigatorUtils.push(context, Routes.eeePage, clearStack: true);
                    }
                  },
                  child: Text(
                    "确定更改",
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
      ),
    );
  }

  Widget _buildOldPwdLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "旧密码",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
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
                //labelText: "请输入钱包名",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请输入旧密码",
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
              controller: _oldPwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPwdLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "新密码",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
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
                hintText: "请输入新密码，建议大于8位，英文、数字混合",
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
              controller: _newPwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmNewPwdLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "再次输入新密码",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
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
                hintText: "再次输入新密码，进行验证",
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

  bool _verifyPwdSame() {
    if (_oldPwdController.text.isEmpty || _newPwdController.text.isEmpty || _confirmPwdController.text.isEmpty) {
      Fluttertoast.showToast(msg: "信息不能为空，请检查后重新尝试");
      return false;
    } else if (_newPwdController.text != _confirmPwdController.text) {
      Fluttertoast.showToast(msg: "两次输入的密码不一致，请重新查证");
      return false;
    }
    return true;
  }
}
