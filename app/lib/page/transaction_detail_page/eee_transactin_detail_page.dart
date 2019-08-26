import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/resources.dart';

class EeeTransactionDetailPage extends StatefulWidget {
  @override
  _EeeTransactionDetailPageState createState() =>
      _EeeTransactionDetailPageState();
}

class _EeeTransactionDetailPageState extends State<EeeTransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "交易详情",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildTxDetailWidget(),
        ),
      ),
    );
  }

  Widget _buildTxDetailWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      //width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(160),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(5),
            _buildTxFromAddressWidget(),
            Gaps.scaleVGap(5),
            _buildTxToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildTxValueWidget(),
            Gaps.scaleVGap(5),
            _buildTimeStampWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTxFromAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "转出地址:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "asdafasddddddddddddfsadf",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTxToAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "转入地址:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "asdafasddddddddddddfsadf",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTxValueWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "交易数额:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "666666.6546",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeStampWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "交易时间戳:",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "20190909-08:50:50",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
