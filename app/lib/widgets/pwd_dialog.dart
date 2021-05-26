import 'package:app/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Customize different dialog styles

class PwdDialog extends StatelessWidget {
  final String title;
  final String hintContent;
  final String hintInput;
  final Function onPressed;

  PwdDialog({this.title, this.hintContent, this.hintInput, this.onPressed});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      contentPadding: EdgeInsets.all(10.0),
      title: Container(
        alignment: Alignment.center,
        child: Text(
          title,
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(4),
      ),
      content: Container(
        margin: EdgeInsets.only(left: 7, right: 6),
        padding: EdgeInsets.only(left: 3),
        height: ScreenUtil().setHeight(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(1),
              Container(
                alignment: Alignment.centerLeft,
                height: ScreenUtil().setHeight(8),
                child: Text(
                  hintContent,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    fontSize: ScreenUtil().setSp(2.5),
                  ),
                ),
              ),
              Gaps.scaleVGap(1),
              Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(101, 98, 98, 0.7),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(1.0),
                      ),
                    ),
                    hintText: hintInput,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: ScreenUtil().setSp(3),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(2),
                      top: ScreenUtil().setHeight(2),
                      bottom: ScreenUtil().setHeight(2),
                    ),
                    focusColor: Colors.black45,
                  ),
                  controller: _controller,
                  autofocus: true,
                ),
              ),
            ],
          ),
        ),
      ),
      contentTextStyle: TextStyle(
        color: Colors.black45,
        fontSize: ScreenUtil().setSp(3),
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text(translate('confirm')),
          onPressed: () {
            if (_controller.text.isEmpty) {
              Fluttertoast.showToast(msg: translate('pls_input') + "${title}");
              return;
            }
            onPressed(_controller.text);
          },
        ),
        new TextButton(
          child: new Text(translate('cancel')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
