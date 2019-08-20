import 'package:app/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 定制化不同  dialog  样式
class PwdDialog extends StatefulWidget {
  final String title;
  final String hintContent;
  final String hintInput;

  PwdDialog(this.title, this.hintContent, this.hintInput);

  @override
  State<StatefulWidget> createState() =>
      _PwdDialog(title, hintContent, hintInput);
}

class _PwdDialog extends State<PwdDialog> {
  final String title;
  final String hintContent;
  final String hintInput;

  _PwdDialog(this.title, this.hintContent, this.hintInput);

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
        fontSize: 16,
      ),
      content: Container(
        margin: EdgeInsets.only(left: 7, right: 6),
        padding: EdgeInsets.only(left: 3),
        height: ScreenUtil().setHeight(23),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                hintContent,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black45, fontSize: 11),
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
                  fillColor: Color.fromRGBO(101, 98, 98, 0.50),
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
                    fontSize: 12,
                  ),
                  focusColor: Colors.black45,
                ),
                autofocus: true,
              ),
            ),
          ],
        ),
      ),
      contentTextStyle: TextStyle(
        color: Colors.black45,
        fontSize: 11,
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('确定'),
          onPressed: () {
            Navigator.of(context).pop(); //关闭对话框
          },
        ),
        new FlatButton(
          child: new Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
