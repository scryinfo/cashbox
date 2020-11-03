import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';

class RecoverWalletPage extends StatefulWidget {
  @override
  _RecoverWalletPageState createState() => _RecoverWalletPageState();
}

class _RecoverWalletPageState extends State<RecoverWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('backup_wallet'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(78.5),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(5.5), right: ScreenUtil().setWidth(5.5)),
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              _buildMnemonicLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMnemonicLayout() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              translate('write_down_mnemonic'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 14,
              ),
            ),
          ),
          Gaps.scaleVGap(3),
          Container(
            child: Text(
              translate('backup_mnemonic_hint_info'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: 11,
              ),
            ),
          ),
          Gaps.scaleVGap(5),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(6.75)),
            width: ScreenUtil().setWidth(78.75),
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
              color: Color.fromRGBO(101, 98, 98, 0.50),
              border: Border.all(
                width: 0.5,
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                String.fromCharCodes(Provider.of<CreateWalletProcessProvide>(context).mnemonic) ?? "",
                style: TextStyle(
                  color: Colors.white,
                  wordSpacing: 5,
                ),
                maxLines: 4,
              ),
            ),
          ),
          Gaps.scaleVGap(8),
          Container(
            child: QrImage(
              data: String.fromCharCodes(Provider.of<CreateWalletProcessProvide>(context).mnemonic),
              size: ScreenUtil().setWidth(38),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
