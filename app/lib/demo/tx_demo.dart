import 'dart:typed_data';

import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:flutter/material.dart';

class TransactionDemo extends StatefulWidget {
  @override
  _TransactionDemoState createState() => _TransactionDemoState();
}

class _TransactionDemoState extends State<TransactionDemo> {
  @override
  void initState() {
    super.initState();
    testFormTxAndSign();
  }

  void testFormTxAndSign() async {
    String form = "0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4";
    String to = "0xc0c4824527ffb27a51034cea1e37840ed69a5f1e";
    String nonce = await loadTxAccount(form, ChainType.ETH_TEST);
    print("nonce ===>" + nonce);
    if (nonce == null) {
      print("loadTxAccount nonce is null");
      return;
    }
    await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true);
    Map map = await Wallets.instance.ethTxSign(
        "a0b74f42-d119-421e-be2b-d28cae52d458",
        //walletid
        4,
        //eth_test
        form,
        //from
        to,
        //to
        "0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e",
        //contractaddress
        "666999",
        //value
        "this is add msg",
        //back
        Uint8List.fromList("q".codeUnits),
        "6",
        //gasPrice
        "70000",
        //gasLimit
        nonce,
        decimal: 18);
    print("result===>" + map.toString());
    print("result===>" + map["status"].toString());
    print("result===>" + map["signedInfo"]);
    testBroadcastTxToChain(map["signedInfo"]);
  }

  testBroadcastTxToChain(String signedInfo) async {
    String txHash = await sendRawTx(ChainType.ETH_TEST, signedInfo);
    print("after broadcast txHash is===>" + txHash);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("tx_demo page"),
    );
  }
}
