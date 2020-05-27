import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LanguageChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('language_choose'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildLanguageListWidget(context),
        ),
      ),
    );
  }

  Widget _buildLanguageListWidget(context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        Gaps.scaleVGap(5),
        _buildEnglishWidget(context),
      ]),
    );
  }

  _buildEnglishWidget(context) {
    return GestureDetector(
      onTap: () {
        print("click 切换语言");
        changeLocale(context, "en_US");
      },
      child: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(13.5),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
              child: Text(
                "中文",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3.5),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(7),
              ),
              child: Align(
                //color: Colors.blue,
                alignment: Alignment.centerRight,
                //margin: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                child: Image.asset("assets/images/ic_enter.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
