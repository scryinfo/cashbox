import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eee_page/eee_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var allWalletList = List();
  bool _agreeServiceProtocol = true;

  @override
  void initState() {
    super.initState();
    _initWallet();
  }

  void _initWallet() async {
    //todo test JNI
    //var allWalletList = await Wallets.instance.loadAllWalletList();

    //await Wallets.instance.createMnemonic(12);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 90, height: 160)
      ..init(context); //初始化屏幕 宽高比 ，以 cashbox标注XXXHDPI@4x

    //todo 2.0  区分链类型，加载对应链界面
    if (allWalletList.length == 0) {
      return EeePage();
    } else {
      return _buildLoadingWidget();
    }
  }

  Widget _buildLoadingWidget() {
    return Material(
      child: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_loading.png"),
              fit: BoxFit.fill),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(30),
              Container(
                //width: ScreenUtil().setWidth(13),
                //height: ScreenUtil().setHeight(13),
                child: Image.asset("assets/images/ic_logo.png"),
              ),
              //Gaps.scaleVGap(2.5),
              Container(
                //width: ScreenUtil().setWidth(48),
                //height: ScreenUtil().setHeight(15),
                child: Image.asset("assets/images/ic_logotxt.png"),
              ),
              Gaps.scaleVGap(26.5),
              Container(
                child: GestureDetector(
                  onTap: () {
                    if (!_agreeServiceProtocol) {
                      Fluttertoast.showToast(msg: "请确认勾选 同意服务协议与隐私条款");
                      return;
                    }
                    NavigatorUtils.push(context, Routes.createWalletNamePage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset("assets/images/ic_add.png"),
                      ),
                      Gaps.scaleHGap(2.5),
                      Text(
                        "添加钱包",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.blue,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.scaleVGap(6.5),
              Container(
                child: GestureDetector(
                  onTap: () {
                    if (!_agreeServiceProtocol) {
                      Fluttertoast.showToast(msg: "请确认勾选 同意服务协议与隐私条款");
                      return;
                    }
                    NavigatorUtils.push(context, Routes.importWalletPage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset("assets/images/ic_import.png"),
                      ),
                      Gaps.scaleHGap(2.5),
                      Text(
                        "导入钱包",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.blue,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.scaleVGap(10),
              Container(
                child: Container(
                  width: ScreenUtil().setWidth(85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: _agreeServiceProtocol,
                        onChanged: (newValue) {
                          setState(
                            () {
                              _agreeServiceProtocol = newValue;
                            },
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: ScreenUtil().setHeight(14),
                        width: ScreenUtil().setWidth(70),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "我已仔细阅读并同意",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontStyle: FontStyle.normal),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigatorUtils.push(
                                    context, Routes.serviceAgreementPage);
                              },
                              child: Text(
                                "《服务协议》",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              "、",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontStyle: FontStyle.normal),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigatorUtils.push(
                                    context, Routes.privacyStatementPage);
                              },
                              child: Text(
                                "《隐私条款》",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
