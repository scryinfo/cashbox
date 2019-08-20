import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';
import '../../widgets/list_item.dart';

class RecoverWalletPage extends StatefulWidget {
  @override
  _RecoverWalletPageState createState() => _RecoverWalletPageState();
}

class _RecoverWalletPageState extends State<RecoverWalletPage> {
  List mnemonicList = [
    "october",
    "shallow",
    "october",
    "shallow",
    "october",
    "shallow",
    "october",
    "shallow",
    "october",
    "shallow",
    "october",
    "shallow",
    "october",
    "shallow",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "备份钱包",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(78.5),
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(5.5),
              right: ScreenUtil().setWidth(5.5)),
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              _buildMnemonicLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMnemonicLayout() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "抄下你的钱包助记词",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(3),
          Container(
            child: Text(
              "助记词用于恢复钱包或者重置钱包密码，将它准确抄到纸上，切记安全保存到你知道的安全地方。",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: 11,
              ),
            ),
          ),
          Gaps.scaleVGap(5),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(6.75)),
            width: ScreenUtil().setWidth(78.75),
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
              color: Color.fromRGBO(101, 98, 98, 0.50),
              border: Border.all(
                width: 0.5,
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              mnemonicList.join(" "),
              style: TextStyle(
                color: Colors.white,
                wordSpacing: 5,
              ),
              maxLines: 4,
            ),
          ),
          Gaps.scaleVGap(8),
          Container(
            child: QrImage(
              data: "666 666 666 666 666",
              size: ScreenUtil().setWidth(38),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
