import 'package:app/provide/transaction_provide.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';

class EthTxDetailPage extends StatefulWidget {
  @override
  _EthTxDetailPageState createState() => _EthTxDetailPageState();
}

class _EthTxDetailPageState extends State<EthTxDetailPage> {
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
            _buildTxHashWidget(),
            Gaps.scaleVGap(5),
            _buildTimeStampWidget(),
            Gaps.scaleVGap(5),
            _buildGasUsedWidget(),
            Gaps.scaleVGap(5),
            _buildGasPriceWidget(),
            Gaps.scaleVGap(5),
            _buildInputMsgWidget(),
            Gaps.scaleVGap(5),
            _buildNonceMsgWidget(),
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

  Widget _buildTxHashWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('tx_hash'),
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
              Provider.of<TransactionProvide>(context).timeStamp,
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

  Widget _buildGasUsedWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('gas_used'),
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
              Provider.of<TransactionProvide>(context).gasUsed,
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

  Widget _buildGasPriceWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('gas_price'),
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
              Provider.of<TransactionProvide>(context).gasPrice,
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

  Widget _buildInputMsgWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('tx_backup'),
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
              Provider.of<TransactionProvide>(context).backup ?? "",
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

  Widget _buildNonceMsgWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('nonce_value'),
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
              Provider.of<TransactionProvide>(context).nonce,
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
