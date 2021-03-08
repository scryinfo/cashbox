import 'dart:typed_data';

import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';

class SignTxPage extends StatefulWidget {
  @override
  _SignTxPageState createState() => _SignTxPageState();
}

class _SignTxPageState extends State<SignTxPage> {
  String _waitToSignInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _waitToSignInfo = Provider.of<SignInfoProvide>(context).waitToSignInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        centerTitle: translate('info_sign'),
        backgroundColor: Colors.transparent,
      ),
      body: _buildWaitToSignLayout(),
    );
  }

  Widget _buildWaitToSignLayout() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(5),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              translate('wait_to_sign_info'),
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(3)),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(45),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.06),
              border: Border.all(
                width: 0.5,
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(_waitToSignInfo ?? "", style: TextStyle(color: Colors.white70, fontSize: ScreenUtil().setSp(3))),
          ),
          Gaps.scaleVGap(10),
          Container(
            width: ScreenUtil().setWidth(41),
            height: ScreenUtil().setHeight(9),
            child: RaisedButton(
              onPressed: () {
                _showPwdDialog();
              },
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: Text(
                translate('click_to_sign'),
                style: TextStyle(
                  color: Colors.blue,
                  letterSpacing: 0.03,
                  fontSize: ScreenUtil().setSp(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPwdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('pwd_verify'),
          hintContent: translate('info_sign_hint'),
          hintInput: translate('pls_input_wallet_pwd'),
          onPressed: (value) async {
            String walletId = await Wallets.instance.getNowWalletId();
            var pwdFormat = value.codeUnits;
            var separateIndex = _waitToSignInfo.indexOf(";");
            var param2 = _waitToSignInfo.substring(separateIndex + 1, _waitToSignInfo.length);
            var keyValueIndex = param2.indexOf("=");
            var waitToSignInfo = param2.substring(keyValueIndex + 1, param2.length);
            Map map = await Wallets.instance.eeeSign(walletId, Uint8List.fromList(pwdFormat), waitToSignInfo.toString());
            if (map.containsKey("status")) {
              int status = map["status"];
              if (status == null || status != 200) {
                Fluttertoast.showToast(msg: "交易签名 失败" + map["message"]);
                NavigatorUtils.goBack(context);
                return null;
              } else {
                String walletId = await Wallets.instance.getNowWalletId();
                Wallet wallet = await Wallets.instance.getWalletByWalletId(walletId);
                String chainEEEAddress = wallet.getChainByChainType(ChainType.EEE).chainAddress;
                var content =
                    _waitToSignInfo.replaceFirst(waitToSignInfo, map["signedInfo"]) + ";addr=" + chainEEEAddress; //**// Signature result data
                context.read<QrInfoProvide>()
                  ..setTitle("签名结果")
                  ..setContent(content)
                  ..setHintInfo("签名成功，如下是签名结果信息");
                NavigatorUtils.goBack(context);
                NavigatorUtils.push(context, Routes.qrInfoPage);
              }
            } else {
              Fluttertoast.showToast(msg: "签名失败，请重新检查您的签名信息和密码");
            }
          },
        );
      },
    );
  }
}
