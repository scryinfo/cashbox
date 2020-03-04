import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../res/resources.dart';

class ProgressDialog extends Dialog {
  ProgressDialog({Key key, this.hintText}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: ScreenUtil().setHeight(120),
          width: ScreenUtil().setWidth(75),
          decoration: ShapeDecoration(color: Color(0xFFD7E5E9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoActivityIndicator(radius: 14.0),
              Gaps.vGap8,
              Text(
                hintText,
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
