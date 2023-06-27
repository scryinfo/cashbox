import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemOfListWidget extends StatefulWidget {
  final String leftText;

  ItemOfListWidget({Key key, @required this.leftText}) : super(key: key);

  @override
  _ItemOfListWidgetState createState() => _ItemOfListWidgetState(leftText: leftText);
}

class _ItemOfListWidgetState extends State<ItemOfListWidget> {
  String leftText;

  _ItemOfListWidgetState({
    @required this.leftText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(13.5),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
            child: Text(
              leftText,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(3.5),
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(7),
            ),
            child: Align(
              //color: Colors.blue,
              alignment: Alignment.centerRight,
              //margin: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
              child: Image.asset("assets/images/ic_enter.png"),
            ),
          ),
        ],
      ),
    );
  }
}
