import 'dart:typed_data';

import 'package:app/model/wallets.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:logger/logger.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/list_item.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        _buildClearCacheWidget(),
        _buildAboutUsWidget(),
      ]),
    );
  }

  //todo 2.0
  Widget _buildMoneyUnitWidget() {
    return GestureDetector(
      onTap: () {},
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
        _showClearHintDialog(context);
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

  void _showClearHintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('clean_cache_data'),
          hintContent: translate('clean_cache_data_hint'),
          hintInput: translate('pls_input_wallet_pwd'),
          onPressed: (value) async {
            Map cleanMap = await Wallets.instance.cleanWalletsDownloadData();
            int status = cleanMap["status"];
            bool isCleanWalletsData = cleanMap["isCleanWalletsData"];
            if (status == 200 && isCleanWalletsData) {
              Fluttertoast.showToast(msg: translate('success_clear_data'));
              NavigatorUtils.push(context, Routes.entrancePage, clearStack: true);
            } else {
              Logger().e("_showClearHintDialog=>", "status is=>" + status.toString() + "message=>" + cleanMap["message"]);
              Fluttertoast.showToast(msg: translate('fail_delete_data'));
            }
          },
        );
      },
    );
  }
}
