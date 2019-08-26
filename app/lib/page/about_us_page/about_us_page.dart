import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/resources.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "关于我们",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildTxDetailWidget(),
        ),
      ),
    );
  }

  Widget _buildTxDetailWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(5),
          Container(
            child: Image.asset("assets/images/ic_logo.png"),
          ),
          Container(
            child: Image.asset("assets/images/ic_logotxt.png"),
          ),
          Gaps.scaleVGap(5),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(8),
              right: ScreenUtil().setWidth(8),
            ),
            child: Text(
              """Scry Cashbox
    是一款由 Scry Info Private Ltd. 运营的钱包，致力于为 Scry Dapps 提供支持 Scry Token 的安全钱包。Scry Cashbox 钱包本身不收取任何费用，一切费用来自公链系统
    gas。Scry Cashbox
    将会不断完善，正式版本还将提供支持以太系统的 ERC20 token，BTC 底层系统的系列 token 等，旨在为每一位用户提供安全、简单的钱包。""",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Gaps.scaleVGap(5),
          GestureDetector(
            onTap: () {
              NavigatorUtils.push(context, Routes.privacyStatementPage);
            },
            child: ItemOfListWidget(
              leftText: "隐私条款",
            ),
          ),
          GestureDetector(
            onTap: () {
              NavigatorUtils.push(context, Routes.serviceAgreementPage);
            },
            child: ItemOfListWidget(
              leftText: "服务协议",
            ),
          ),
        ],
      ),
    );
  }
}
