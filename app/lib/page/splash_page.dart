import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eee_page/eee_page.dart';
import 'package:app/page/create_wallet_page/create_wallet_name_page.dart';
import 'package:app/page/create_wallet_page/create_wallet_mnemonic_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var allWalletList = List();

  @override
  void initState() {
    super.initState();
    _initWallet();
  }

  void _initWallet() async {
    //var allWalletList = await WalletMgr.instance.loadAllWalletList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 90, height: 160)
      ..init(context); //初始化屏幕 宽高比 ，以 cashbox标注XXXHDPI@4x

    //todo 再区分链类型，加载 不同界面
    if (allWalletList.length == 0) {
      print("goEEEPage=>");
      return EeePage();
    } else {
      return Material(
        child: Text("this is splashpage"),
      );
    }
  }
}
