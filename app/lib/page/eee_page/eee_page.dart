import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/page/eee_page/chain_card.dart';
import 'package:app/page/eee_page/middle_func_card.dart';
import 'package:app/page/eee_page/digit_list_card.dart';
import '../../res/resources.dart';
import '../eee_page/left_drawer_card.dart';

class EeePage extends StatefulWidget {
  @override
  _EeePageState createState() => _EeePageState();
}

class _EeePageState extends State<EeePage> {
  List<Wallet> walletList;
  Wallet nowWallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    walletList = await Wallets().loadAllWalletList();
    print("initData walletlist.length===>" + walletList.length.toString());
    walletList.forEach((wallet) {
      print("wallet is " + wallet.isNowWallet.toString());
    });
    setState(() {
      this.walletList = walletList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text("这钱包名"),
      ),
      drawer: LeftDrawerCard(),
      body: Container(
          alignment: Alignment.centerLeft,
          child: Stack(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  ChainCard(),
                  MiddleFuncCard(),
                  DigitListCard(),
                ],
              ),
            ],
          )),
    );
  }
}
