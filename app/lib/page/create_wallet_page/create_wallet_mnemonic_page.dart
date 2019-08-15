import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bar.dart';
import '../../routers/application.dart';

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
        body: _buildCreateWalletMnemonic(),
      ),
    );
  }

  _buildCreateWalletMnemonic() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(78.75),
        height: ScreenUtil().setWidth(160),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(10.75),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "备份助记词",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(1.75),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Text(
                "以下是钱包的助记词，抄写下来并导出至安全的地方存放。一旦丢失，无法找回。",
                textAlign: TextAlign.left,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.03,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5.5),
            ),
            Container(
              width: ScreenUtil().setWidth(78.75),
              height: ScreenUtil().setHeight(40),
              color: Color.fromRGBO(255, 255, 255, 0.06),
              child: Column(
                //todo 更改助记词个数为动态，动态加载个数。
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "666",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                              ),
                            ),
                            onPressed: () {
                              print("clicked btn text");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(6.2),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset("assets/images/ic_refresh.png"),
                        ),
                        Container(
                          child: Text(
                            "换一组",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(42),
                  ),
                  Container(
                    child: Text(
                      "二维码备份",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(38.5),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  print("clicked the add wallet btn");
                  Application.router
                      .navigateTo(context, "createwalletconfirmpage");
                },
                child: Text(
                  "助记词已经记好",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
