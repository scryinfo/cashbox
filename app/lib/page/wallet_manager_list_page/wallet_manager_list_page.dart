import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
  List<Wallet> walletList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    walletList = await Wallets.instance.loadAllWalletList();
    setState(() {
      this.walletList = walletList;
    });
  }

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
            Provider.of<WalletManagerProvide>(context)
                .setWalletName(walletList[index].walletName);
            Provider.of<WalletManagerProvide>(context)
                .setWalletId(walletList[index].walletId);
            NavigatorUtils.push(context, Routes.walletManagerPage);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Gaps.scaleVGap(5),
                Container(
                  child: ItemOfListWidget(
                    leftText: walletList[index].walletName,
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
