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
  String mnemonicString =
      "memonic ,memonic ,memonic ,memonic ,memonic ,memonic ,memonic ,memonic ,memonic";
  bool _eeeChainChoose = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "测试钱包",
          backgroundColor: Colors.transparent,
        ),
        body: _buildTestWalletWidget(),
      ),
    );
  }

  Widget _buildTestWalletWidget() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(160),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(2),
          Container(
            width: ScreenUtil().setWidth(80),
            child: Text(
              """测试钱包 助记词:""",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
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
                fontSize: 10,
              ),
              maxLines: 2,
            ),
          ),
          Gaps.scaleVGap(2.5),
          _buildVerifyInputMnemonic(),
          Gaps.scaleVGap(2),
          _buildChangeMnemonicWidget(),
          Gaps.scaleVGap(5),
          _buildWalletNameWidget(),
          Gaps.scaleVGap(5),
          _buildChainChooseLayout(),
          Gaps.scaleVGap(5),
          _buildCreateBtn(),
        ],
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
                  fontSize: 13,
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
          print("click to change mnemonic");
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
              "钱包名: ",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            Text(
              "测试钱包",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 14,
              ),
            ),
          ],
        ));
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
                              fontSize: 13,
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
        onPressed: () {
          //todo create TestWallet
          print("clicked to create test wallet");
        },
        child: Text(
          "添加钱包",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 0.03,
          ),
        ),
      ),
    );
  }
}
