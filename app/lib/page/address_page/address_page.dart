import 'package:app/res/resources.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddressPage extends StatelessWidget {
  final String walletName;
  final String title;
  final String content;

  const AddressPage(
    this.walletName,
    this.title,
    @required this.content,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: walletName?? "",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 7.25),
                width: ScreenUtil().setWidth(78.75),
                height: ScreenUtil().setWidth(94.25),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.06),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.black87,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(13.25),
                  right: ScreenUtil().setWidth(13.25),
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(7.5),
                        ),
                        height: ScreenUtil().setHeight(6.25),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(3.75),
                        ),
                        child: QrImage(
                          data: content,
                          size: ScreenUtil().setWidth(52.25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(6.25),
                        ),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onLongPress: () async {
                            Utils.copyMsg(content);
                            Fluttertoast.showToast(msg: "地址已经成功拷贝!~~~");
                          },
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.scaleVGap(5),
              Container(
                alignment: Alignment.bottomCenter,
                width: ScreenUtil().setWidth(41),
                height: ScreenUtil().setHeight(9),
                color: Color.fromRGBO(26, 141, 198, 0.20),
                child: FlatButton(
                  onPressed: () {
                    Utils.copyMsg(content);
                    Fluttertoast.showToast(msg: "地址已经成功拷贝!~~~");
                  },
                  child: Text(
                    "点击复制地址",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
