import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/app_info_util.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var appVersion = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    setState(() {
      this.appVersion = appVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('about_us_title'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildTxDetailWidget(),
        ),
      ),
    );
  }

  Widget _buildTxDetailWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(8),
          Container(
            child: Image.asset("assets/images/ic_logo.png"),
          ),
          Container(
            child: Image.asset("assets/images/ic_logotxt.png"),
          ),
          Container(
            child: Text(
              appVersion,
              style:
                  TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
            ),
          ),
          Gaps.scaleVGap(8),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(8),
              right: ScreenUtil().setWidth(8),
            ),
            child: Text(
              translate("wallet_explanation"),
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(3.2),
              ),
            ),
          ),
          Gaps.scaleVGap(5),
          GestureDetector(
            onTap: () {
              NavigatorUtils.push(context, Routes.privacyStatementPage);
            },
            child: ItemOfListWidget(
              leftText: translate('privacy_protocol_title'),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavigatorUtils.push(context, Routes.serviceAgreementPage);
            },
            child: ItemOfListWidget(
              leftText: translate('service_protocol_title'),
            ),
          ),
          GestureDetector(
            onTap: () async {
              bool isCanUpgrade = await AppInfoUtil.instance.checkAppUpgrade();
              if (!isCanUpgrade) {
                Fluttertoast.showToast(msg: translate('no_new_version_hint'));
              }
            },
            child: ItemOfListWidget(
              leftText: translate('version_update'),
            ),
          ),
        ],
      ),
    );
  }
}
