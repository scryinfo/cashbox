import 'package:app/global_config/global_config.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/sharedpreference_util.dart';
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
    List<String> valuesList = GlobalConfig.globalLanguageMap.values.toList();
    List<String> keysList = GlobalConfig.globalLanguageMap.keys.toList();
    List<Widget> languageWidgetList = List.generate(valuesList.length, (index) {
      bool isSelectedLanguage = false;
      Locale myLocale = Localizations.localeOf(context);
      if (myLocale.toString() == keysList[index].toString()) {
        isSelectedLanguage = true;
      }
      return Container(
        child: GestureDetector(
          onTap: () async {
            print("click 切换语言");
            {
              changeLocale(context, keysList[index]);
              var spUtil = await SharedPreferenceUtil.instance;
              spUtil.setString(GlobalConfig.savedLocaleKey, keysList[index]);
            }
            NavigatorUtils.push(context, '${Routes.homePage}?isForceLoadFromJni=false', clearStack: true);
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
                    valuesList[index] ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(3.5),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                !isSelectedLanguage
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(7),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset("assets/images/ic_checked.png"),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });

    return Column(
      children: languageWidgetList,
    );
  }
}
