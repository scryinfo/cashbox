import 'package:app/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bar.dart';
import '../../res/styles.dart';
import '../../routers/routers.dart';

class CreateWalletMnemonicPage extends StatefulWidget {
  @override
  _CreateWalletMnemonicPageState createState() =>
      _CreateWalletMnemonicPageState();
}

class _CreateWalletMnemonicPageState extends State<CreateWalletMnemonicPage> {
  //todo mock data
  List<String> mnemonicList = [
    "victory",
    "october",
    "off",
    "drink ",
    "shallow",
    "actual",
    "stone",
    "decade",
    "victory",
    "october",
    "off",
    "drink "
  ];
  String walletName = "mockWalletName";

  @override
  void initState() {
    // init JNI
    super.initState();
  }

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
            Gaps.scaleVGap(10.75),
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
            Gaps.scaleVGap(1.75),
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
            Gaps.scaleVGap(5.5),
            Container(
              width: ScreenUtil().setWidth(78.75),
              height: ScreenUtil().setHeight(40),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.06),
                border: Border.all(
                  width: 0.5,
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Wrap(
                children: _buildRandomMnemonicBtn(),
              ),
            ),
            Gaps.scaleVGap(6.2),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _changeMnemonic();
                    },
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
                  Gaps.scaleHGap(42),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _showAddressInQR(context);
                      },
                      child: Text(
                        "二维码备份",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.scaleVGap(38),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  print("clicked the add wallet btn");
                  NavigatorUtils.push(context, Routes.createWalletConfirmPage);
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

  List<Widget> _buildRandomMnemonicBtn() {
    List<Widget> randomWidgetList = List.generate(mnemonicList.length, (index) {
      return Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(18.75),
        child: FlatButton(
          child: Text(
            mnemonicList[index].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              fontSize: 12,
            ),
          ),
          onPressed: () {},
        ),
      );
    });
    return randomWidgetList;
  }

  _changeMnemonic() {
    //todo  JNI
    setState(() {
      this.mnemonicList = [
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
        "666666",
      ];
    });
  }

  _showAddressInQR(context) {
    String target = "addresspage?walletName=$walletName" +
        "&title=" +
        mnemonicList.join(",").trim().toString() +
        "&content=" +
        mnemonicList.join(" ");
    NavigatorUtils.push(
      context,
      target,
    );
  }
}
