import 'package:app/net/scryx_net_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EeeTransferConfirmPage extends StatefulWidget {
  @override
  _EeeTransferConfirmPageState createState() => _EeeTransferConfirmPageState();
}

class _EeeTransferConfirmPageState extends State<EeeTransferConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.topCenter,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('transaction_confirm'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildEeeTransferConfirmWidget(),
        ),
      ),
    );
  }

  Widget _buildEeeTransferConfirmWidget() {
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
            _buildTxConfirmHintWidget(),
            Gaps.scaleVGap(5),
            _buildTxFromAddressWidget(),
            Gaps.scaleVGap(5),
            _buildTxToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildTxValueWidget(),
            Gaps.scaleVGap(5),
            _buildTransferBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTxConfirmHintWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('tx_confirm_instruction_title'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: translate('tx_confirm_instruction_content'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.redAccent,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    )),
              ]),
            ),
          ),
        ],
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
                color: Color.fromRGBO(255, 255, 255, 0.8),
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
                color: Color.fromRGBO(255, 255, 255, 0.8),
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
                color: Color.fromRGBO(255, 255, 255, 0.8),
                fontSize: ScreenUtil().setSp(3.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferBtnWidget() {
    return GestureDetector(
      onTap: () async {
        ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
        Map submitMap = await scryXNetUtil.submitExtrinsic(Provider.of<TransactionProvide>(context).signInfo);
        if (submitMap == null || !submitMap.containsKey("result") || submitMap["result"] == null || submitMap["result"].toString().isEmpty) {
          Fluttertoast.showToast(msg: translate("tx_upload_failure"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
          NavigatorUtils.goBack(context);
          return;
        }
        String txHash = submitMap["result"];
        Fluttertoast.showToast(msg: translate("tx_upload_success"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
        NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().setWidth(41),
        height: ScreenUtil().setHeight(9),
        color: Color.fromRGBO(26, 141, 198, 0.20),
        child: FlatButton(
          child: Text(
            translate('click_to_up_chain'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
