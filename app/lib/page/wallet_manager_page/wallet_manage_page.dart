import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';
import '../../widgets/list_item.dart';

class WalletManagerPage extends StatefulWidget {
  @override
  _WalletManagerPageState createState() => _WalletManagerPageState();
}

class _WalletManagerPageState extends State<WalletManagerPage> {
  List funcList = [
    //"编辑链",
    "重置密码",
    "备份钱包",
    "删除钱包",
  ];
  List funcRouter = [Routes.resetPwdPage, Routes.recoverWalletPage];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "钱包管理",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(12.5),
              child: Text(
                "walletName",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Wrap(
              children: _buildWalletFuncList(),
            ),
          ],
        )),
      ),
    );
  }

  List<Widget> _buildWalletFuncList() {
    List<Widget> walletFuncList = List.generate(funcList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            NavigatorUtils.push(context, funcRouter[index]);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Gaps.scaleVGap(5),
                Container(
                  child: ItemOfListWidget(
                    leftText: funcList[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return walletFuncList;
  }
}
