import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bar.dart';

class CreateWalletMnemonicPage extends StatefulWidget {
  @override
  _CreateWalletMnemonicPageState createState() =>
      _CreateWalletMnemonicPageState();
}

class _CreateWalletMnemonicPageState extends State<CreateWalletMnemonicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_graduate.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "添加钱包",
          backgroundColor: Colors.transparent,
        ),
        body: Text(""),
      ),
    );
  }
}
