import 'package:app/provide/qr_info_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrInfoPage extends StatefulWidget {
  @override
  _QrInfoPageState createState() => _QrInfoPageState();
}

class _QrInfoPageState extends State<QrInfoPage> {
  String title = "";
  String hintInfo = "";
  String content = "";
  String btnContent = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    title = Provider.of<QrInfoProvide>(context).title;
    hintInfo = Provider.of<QrInfoProvide>(context).hintInfo;
    content = Provider.of<QrInfoProvide>(context).content;
    btnContent = Provider.of<QrInfoProvide>(context).btnContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: title ?? "",
          backgroundColor: Colors.transparent,
          onPressed: () {},
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(3),
              Container(
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
                          hintInfo ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(3.5),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(3.75),
                        ),
                        child: QrImageView(data: content ?? " ", size: ScreenUtil().setWidth(52.25)),
                        // child: QrImage(
                        //   data: content ?? " ",
                        //   size: ScreenUtil().setWidth(52.25),
                        // ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(6.25),
                        ),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onLongPress: () async {
                            Utils.copyMsg(content);
                            Fluttertoast.showToast(msg: translate('success_to_copy_info'));
                          },
                          child: Text(
                            content ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(3),
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.scaleVGap(10),
              Container(
                alignment: Alignment.bottomCenter,
                width: ScreenUtil().setWidth(41),
                height: ScreenUtil().setHeight(9),
                color: Color.fromRGBO(26, 141, 198, 0.20),
                child: TextButton(
                  onPressed: () {
                    Utils.copyMsg(content);
                    Fluttertoast.showToast(msg: translate('success_to_copy_info'));
                  },
                  child: Text(
                    translate('click_to_copy_address'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 0.03,
                      fontSize: ScreenUtil().setSp(3.5),
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
