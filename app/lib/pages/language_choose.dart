import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LanguageChoosePage extends StatefulWidget {
  @override
  _LanguageChoosePageState createState() => _LanguageChoosePageState();
}

class _LanguageChoosePageState extends State<LanguageChoosePage> {
  List<Language> languagesList = [];

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

  Future<bool> _loadLanguage() async {
    Config config = await HandleConfig.instance.getConfig();
    languagesList = config.languages;
    return true;
  }

  Widget _buildLanguageListWidget(context) {
    return Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _loadLanguage(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("something error happen");
              } else if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Gaps.scaleVGap(5),
                  _buildEnglishWidget(context),
                ]);
              } else {
                return Text("no data,please reentry this page");
              }
            }));
  }

  _buildEnglishWidget(context) {
    List<Widget> languageWidgetList = List.generate(languagesList.length, (index) {
      bool isSelectedLanguage = false;
      Locale myLocale = Localizations.localeOf(context);
      if (myLocale.toString() == languagesList[index].localeKey.toString()) {
        isSelectedLanguage = true;
      }
      return Container(
        child: GestureDetector(
          onTap: () async {
            {
              changeLocale(context, languagesList[index].localeKey);
              Config config = await HandleConfig.instance.getConfig();
              config.locale = languagesList[index].localeKey;
              HandleConfig.instance.saveConfig(config);
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
                    languagesList[index].localeValue ?? "",
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
