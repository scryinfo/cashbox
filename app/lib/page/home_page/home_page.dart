import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/page/home_page/chain_card.dart';
import 'package:app/page/home_page/middle_func_card.dart';
import 'package:app/page/home_page/digit_list_card.dart';
import '../../res/resources.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/bg_graduate.png")),
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("placeholder"),
        ),
        body: Container(
            alignment: Alignment.centerLeft,
            child: new Column(
              children: <Widget>[
                ChainCard(),
                MiddleFuncCard(),
                DigitListCard(),
              ],
            )),
      ),
    );
  }
}
