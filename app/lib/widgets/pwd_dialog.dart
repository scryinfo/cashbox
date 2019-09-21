import 'package:app/generated/i18n.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// 定制化不同  dialog  样式

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
        fontSize: ScreenUtil.instance.setSp(4),
      ),
      content: Container(
        margin: EdgeInsets.only(left: 7, right: 6),
        padding: EdgeInsets.only(left: 3),
        height: ScreenUtil().setHeight(23),
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(1),
            Container(
              child: Text(
                hintContent,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: ScreenUtil.instance.setSp(2.5),
                ),
              ),
            ),
            Gaps.scaleVGap(3),
            Container(
              padding: EdgeInsets.all(0),
              //height: ScreenUtil().setHeight(15),
              //color: Colors.red,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(101, 98, 98, 0.7),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(1.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(3),
                    bottom: ScreenUtil().setHeight(3),
                  ),
                  hintText: hintInput,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: ScreenUtil.instance.setSp(3),
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
      contentTextStyle: TextStyle(
        color: Colors.black45,
        fontSize: ScreenUtil.instance.setSp(3),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text(S.of(context).confirm),
          onPressed: () {
            if (_controller.text.isEmpty) {
              Fluttertoast.showToast(msg: S.of(context).pls_input + "${title}");
              return;
            }
            onPressed(_controller.text);
          },
        ),
        new FlatButton(
          child: new Text(S.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
