import 'dart:convert';

import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class EeeTxDetailPage extends StatefulWidget {
  @override
  _EeeTxDetailPageState createState() => _EeeTxDetailPageState();
}

class _EeeTxDetailPageState extends State<EeeTxDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('transaction_detail'),
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
            _buildBlockHashWidget(),
            Gaps.scaleVGap(5),
            _buildBackupInfoWidget(),
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
              translate('transfer_from_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              Provider.of<TransactionProvide>(context).fromAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
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
              translate('transfer_to_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              Provider.of<TransactionProvide>(context).toAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
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
              translate('transaction_amount'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              Provider.of<TransactionProvide>(context).txValue,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockHashWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('block_hash'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              Provider.of<TransactionProvide>(context).hash,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupInfoWidget() {
    var backupInfo = "";
    try {
      backupInfo = Utf8Decoder().convert(Utils.hexStrToUnitList(Provider.of<TransactionProvide>(context).backup)) ?? "";
    } catch (e) {
      backupInfo = "";
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('extend_msg'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              backupInfo ?? "",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
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
              translate('transaction_timestamp'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(1),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              DateTime.fromMillisecondsSinceEpoch(int.parse(Provider.of<TransactionProvide>(context).timeStamp)).toString() ?? "",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
