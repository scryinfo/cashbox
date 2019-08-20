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

class WalletManagerListPage extends StatefulWidget {
  @override
  _WalletManagerListPageState createState() => _WalletManagerListPageState();
}

class _WalletManagerListPageState extends State<WalletManagerListPage> {
  List walletList = [
    "walletName1",
    "walletName2",
    "walletName3",
    "walletName4",
    "walletName5",
    "walletName6",
    "walletName7",
    "walletName8",
    "walletName9",
    "walletName10",
    "walletName11",
    "walletName12",
    "walletName13",
    "walletName14",
    "walletName15",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "钱包列表",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Wrap(
              children: _buildWalletList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWalletList() {
    List<Widget> walletListWidgetList =
        List.generate(walletList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            NavigatorUtils.push(context, Routes.walletManagerPage);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Gaps.scaleVGap(5),
                Container(
                  child: ItemOfListWidget(
                    leftText: walletList[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return walletListWidgetList;
  }
}
