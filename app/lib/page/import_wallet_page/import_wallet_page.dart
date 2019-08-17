import 'package:app/util/qr_scan_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
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
  bool _EeeChainChoosed = true;
  var mneString = "";

  @override
  void initState() {
    super.initState();
    _walletNameController.addListener(_verifyMnemonic);
    _pwdController.addListener(_verifyWalletName);
    _confirmPwdController.addListener(_verifyPwd);
  }

  void _verifyMnemonic() {
    String mnemonic = _mneController.text;
    if (mnemonic.isEmpty || mnemonic.length < 1) {
      Fluttertoast.showToast(msg: "助记词不能为空");
      return;
    }
  }

  void _verifyWalletName() {
    String name = _walletNameController.text;
    if (name.isEmpty || name.length < 1) {
      Fluttertoast.showToast(msg: "钱包名不能为空");
      return;
    }
  }

  void _verifyPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: "密码不能为空");
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
      Fluttertoast.showToast(msg: "有部分内容为空，请填写完整信息");
      return false;
    }
    if (pwd.toString().compareTo(confirmPwd.toString()) != 0) {
      Fluttertoast.showToast(msg: "两次输入密码不一致!!!");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_graduate.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(
            centerTitle: "导入钱包",
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(160),
            child: _buildImportWalletWidget(),
          )),
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
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  if (_verifyImportWallet()) {
                    print("begin to import wallet");
                    //todo
                    //NavigatorUtils.push(context, Routes.createWalletMnemonicPage);
                  }
                },
                child: Text(
                  "导入钱包",
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

  bool _verifyPwdSame() {
    //todo verify Pwd
    return true;
  }

  Widget _buildMnemonicWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "助记词",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
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
                      fontSize: 12,
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
                      hintText: "请输入助记词",
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
                    controller: _mneController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(30),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(3),
                    right: ScreenUtil().setWidth(3),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      Future<String> qrResult = QrScanUtil.qrscan();
                      qrResult.then((t) {
                        setState(() {
                          mneString = t.toString();
                        });
                      }).catchError((e) {
                        Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
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
              "钱包名称",
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
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请输入钱包名",
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
              "密码",
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
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "建议8-24位，英文数字混合",
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
              "确认密码",
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
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请再次输入密码",
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
            "选择创建链",
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
                  value: _EeeChainChoosed,
                  onChanged: (newValue) {
                    setState(
                      () {
                        print(" context._EeeChainChoosed=>" +
                            _EeeChainChoosed.toString());
                        _EeeChainChoosed = newValue;
                      },
                    );
                  },
                ),
                Text(
                  "EEE",
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
}
