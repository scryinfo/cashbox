import 'package:app/control/wallets_control.dart';
import 'package:app/model/wallet.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../routers/fluro_navigator.dart';
import '../../routers/routers.dart';
import '../../widgets/app_bar.dart';
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  void initData() async {
    walletList = WalletsControl.getInstance().walletsAll();
    //After changing the wallet attributes, you need to refresh the synchronization data again, such as changing the wallet name.
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
          centerTitle: translate('wallet_list'),
          backgroundColor: Colors.transparent,
          onPressed: () {},
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
    List<Widget> walletListWidgetList = List.generate(walletList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            context.read<WalletManagerProvide>()
              ..setWalletName(walletList[index].walletName)
              ..setWalletId(walletList[index].walletId);
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
