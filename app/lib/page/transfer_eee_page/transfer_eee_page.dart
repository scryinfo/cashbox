import 'package:app/model/wallets.dart';
import 'package:flutter/cupertino.dart';

class TransferEeePage extends StatefulWidget {
  @override
  _TransferEeePageState createState() => _TransferEeePageState();
}

class _TransferEeePageState extends State<TransferEeePage> {
  var chainAddress = "";
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    print("initData=======>");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("transfer eee"),
    );
  }
}
