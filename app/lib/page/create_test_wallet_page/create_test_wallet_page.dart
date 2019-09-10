import 'dart:typed_data';

import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String mnemonicString = "";
  bool _eeeChainChoose = true;
  final testWalletName = "测试钱包";
  final walletNameTitle = "钱包名";
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          centerTitle: "创建测试钱包",
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
                """测试钱包 助记词:""",
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
                """注意：此测试钱包里面能使用的,都是测试链上的代币。      请区分与正式链的差别。""",
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
              child: Text(
                mnemonicString,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3),
                  wordSpacing: 5,
                ),
                maxLines: 3,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  Future<String> qrResult = QrScanUtil.qrscan();
                  qrResult.then((t) {
                    setState(() {
                      this.mnemonicString = t.toString();
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
                "换一组",
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
        width: ScreenUtil().setWidth(80),
        child: Row(
          children: <Widget>[
            Text(
              walletNameTitle + ":",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil.instance.setSp(3.5),
              ),
            ),
            Gaps.scaleHGap(0.5),
            Text(
              testWalletName,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil.instance.setSp(3.5),
              ),
            ),
          ],
        ));
  }

  Widget _buildPwdWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "钱包密码",
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
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请设置钱包密码",
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
              "选择创建链",
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
                            "EEE_TEST",
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
          "添加钱包",
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
      mnemonicString = String.fromCharCodes(mnemonic);
    });
  }

  bool _verifyPwdAndMnemonic() {
    //助记词密码不为空
    if (_pwdController.text.isEmpty || _pwdController.text.length <= 0 || mnemonicString.isEmpty || mnemonicString.length <= 0) {
      return false;
    } else {
      return true;
    }
  }

  _createTestWallet() async {
    bool isOk = _verifyPwdAndMnemonic();
    if (!isOk) {
      Fluttertoast.showToast(msg: "助记词和密码不能为空");
      return;
    }
    var isSuccess = await Wallets.instance.saveWallet(
        testWalletName, Uint8List.fromList(_pwdController.text.codeUnits), Uint8List.fromList(mnemonicString.codeUnits), WalletType.TEST_WALLET);
    if (isSuccess) {
      Fluttertoast.showToast(msg: "测试钱包创建完成，切记注意区分钱包类型");
      NavigatorUtils.push(context, Routes.entryPage, clearStack: true);
    } else {
      Fluttertoast.showToast(msg: "测试钱包创建失败，请检查你输入的数据是否正确");
    }
  }
}
