import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('mine'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildMineWidget(),
        ),
      ),
    );
  }

  Widget _buildMineWidget() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        Gaps.scaleVGap(5),
        //_buildMoneyUnitWidget(),
        _buildWalletListWidget(),
        _buildTestWalletWidget(),
        _buildLanguageChooseWidget(),
        //_buildClearCacheWidget(),
        _buildAboutUsWidget(),
      ]),
    );
  }

  //todo 2.0
  Widget _buildMoneyUnitWidget() {
    return GestureDetector(
      onTap: () {
        print("click 货币管理");
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
                translate('currency_manage'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setHeight(13.5),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(13.5)),
              child: Text("\$USD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start),
            ),
            Container(
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setHeight(13.5),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(7)),
              child: Image.asset("assets/images/ic_enter.png"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestWalletWidget() {
    return GestureDetector(
      onTap: () {
        print("click 测试钱包");
        NavigatorUtils.push(context, Routes.createTestWalletPage);
      },
      child: ItemOfListWidget(
        leftText: translate('test_wallet_title'),
      ),
    );
  }

  Widget _buildWalletListWidget() {
    return GestureDetector(
      onTap: () {
        print("click 钱包列表");
        NavigatorUtils.push(context, Routes.walletManagerListPage);
      },
      child: ItemOfListWidget(
        leftText: translate('wallet_list'),
      ),
    );
  }

  Widget _buildLanguageChooseWidget() {
    return GestureDetector(
      onTap: () {
        print("click 语言选择");
        NavigatorUtils.push(context, Routes.languageChoosePage);
      },
      child: ItemOfListWidget(
        leftText: translate('language_choose'),
      ),
    );
  }

  Widget _buildClearCacheWidget() {
    return GestureDetector(
      onTap: () {
        print("click 清除缓存");
        //todo 提示清除操作，执行清除操作
      },
      child: ItemOfListWidget(
        leftText: translate('clean_cache'),
      ),
    );
  }

  Widget _buildAboutUsWidget() {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, Routes.aboutUsPage);
      },
      child: ItemOfListWidget(
        leftText: translate('about_us_title'),
      ),
    );
  }
}
