import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';

class LeftDrawerCard extends StatefulWidget {
  @override
  _LeftDrawerCardState createState() => _LeftDrawerCardState();
}

class _LeftDrawerCardState extends State<LeftDrawerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(160),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            LeftDrawer._drawerAction(context),
            LeftDrawer._drawWalletList(context),
          ],
        ));
  }
}

class LeftDrawer {
  static Widget _drawerAction(context) {
    return Container(
      height: ScreenUtil().setHeight(53.75),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_mine.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '我的',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  print("it is mine");
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_public.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '公告',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  print("it is ic_nav_public");
                  Application.router.navigateTo(context, "publicpage");
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_add.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '添加钱包',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(context, "createwalletpage");
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_import.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '导入钱包',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => {}),
          ),
        ],
      ),
    );
  }

  static Widget _drawWalletList(context) {
    return Container(
      height: ScreenUtil().setHeight(105),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(6)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(7),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(7),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(7),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(7),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(7),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "Greate Wallet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(12.5)),
                      child: Text(
                        "≈63.0",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(4.5)),
                      child: Image.asset("assets/images/ic_nav_enter.png"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(7.5),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "ETH",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(7)),
                      child: Text(
                        "BTC",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
