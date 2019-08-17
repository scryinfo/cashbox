import 'package:app/routers/fluro_navigator.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/routers/application.dart';
import '../../routers/routers.dart';

class MiddleFuncCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MiddleFuncCard();
}

class _MiddleFuncCard extends State<MiddleFuncCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(15),
      width: ScreenUtil().setWidth(90),
      margin: EdgeInsets.only(top: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(10),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(
                        right: ScreenUtil().setWidth(3.5),
                      ),
                      child: Image.asset("assets/images/ic_transfer.png"),
                    ),
                    Text(
                      "转账",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )
                  ],
                ),
                onTap: () {
                  print("onTap is~~转账~");
                  NavigatorUtils.push(context, Routes.transferEeePage);
                },
              )),
          Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(10),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  new Padding(
                      padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(3.5)),
                      child: Image.asset("assets/images/ic_receive.png")),
                  Padding(
                      padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(3.5)),
                      child: Text(
                        "收款",
                        style: TextStyle(color: Colors.lightBlueAccent),
                      )),
                ],
              ),
              onTap: () {
                String walletName = "mockWalletName";
                String target = "addresspage?walletName=$walletName" +
                    "&title=" +
                    "testTitle" +
                    "&content=" +
                    "titleAddrress565216546465432651564654";
                NavigatorUtils.push(
                  context,
                  target,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
