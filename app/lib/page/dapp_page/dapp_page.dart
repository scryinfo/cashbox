import 'dart:typed_data';

import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scry_webview/scry_webview.dart';

class DappPage extends StatefulWidget {
  @override
  _DappPageState createState() => _DappPageState();
}

class _DappPageState extends State<DappPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil.instance.setWidth(90),
        height: ScreenUtil.instance.setHeight(160),
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil.instance.setHeight(4.5)),
          child: WebView(
            initialUrl: "file:///android_asset/flutter_assets/assets/dist/index.html",
            //initialUrl: "file:///android_asset/flutter_assets/assets/dist-one/dist-one-index.html",
            //initialUrl: "http://192.168.1.4:8080/",
            javascriptMode: JavascriptMode.unrestricted,
            userAgent:
                "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
            //JS执行模式 是否允许JS执行
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              //_loadHtmlFromAssets(_controller); //载入本地html文件
            },
            javascriptChannels: makeJsChannelsSet(),
            navigationDelegate: (NavigationRequest request) {
              print("navigationDelegate ===============================>:  $request");
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) async {
              Wallet wallet = await Wallets.instance.getNowWalletModel();
              String chainEEEAddress = wallet.getChainByChainType(ChainType.EEE).chainAddress;
              _controller?.evaluateJavascript('nativeChainAddressToJsResult("$chainEEEAddress")')?.then((result) {}); //传钱包EEE链地址给DApp记录保存
              print('Page finished loading================================>: $url');
            },
          ),
        ),
      ),
    );
  }

  Set<JavascriptChannel> makeJsChannelsSet() {
    List<JavascriptChannel> jsChannelList = [];
    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanToJs",
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((t) {
            _controller?.evaluateJavascript('nativeQrScanToJsResult("$t")')?.then((result) {});
          }).catchError((e) {
            Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
          });
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanAndPwdAndSignToQR", //备注。在此执行scan,在sign_tx_page执行pwdAndSign，后toQR
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((qrInfo) {
            Map paramsMap = QrScanUtil.instance.checkQrInfoByDiamondSignAndQr(qrInfo, context);
            if (paramsMap == null) {
              Fluttertoast.showToast(msg: "扫描内容结果不符合diamond Dapp规则");
              NavigatorUtils.goBack(context);
              return;
            }
            var waitToSignInfo = "dtt=" + paramsMap["dtt"] + ";" + "v=" + paramsMap["v"]; //待签名交易信息
            Provider.of<SignInfoProvide>(context).setWaitToSignInfo(waitToSignInfo);
            NavigatorUtils.push(context, Routes.signTxPage);
          }).catchError((e) {
            Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
          });
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeSignMsgToJs",
        onMessageReceived: (JavascriptMessage message) {
          print("NativeSignMsg 从Webview传回来的参数======>： ${message.message}");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                title: "钱包密码",
                hintContent: "提示：请输入您的密码，对交易信息进行签名。 ",
                hintInput: "请输入钱包密码",
                onPressed: (pwd) async {
                  var pwdFormat = pwd.codeUnits;
                  String walletId = await Wallets.instance.getNowWalletId();
                  Map map = await Wallets.instance.eeeTxSign(walletId, Uint8List.fromList(pwdFormat), message.message);
                  if (map.containsKey("status")) {
                    int status = map["status"];
                    if (status == null || status != 200) {
                      Fluttertoast.showToast(msg: "交易签名 失败" + map["message"]);
                      NavigatorUtils.goBack(context);
                      return null;
                    } else {
                      var signResult = map["signedInfo"];
                      Fluttertoast.showToast(msg: "交易签名 成功");
                      _controller?.evaluateJavascript('nativeSignMsgToJsResult("$signResult")')?.then((result) {
                        NavigatorUtils.goBack(context); //签名完成，关了密码弹框
                      });
                    }
                  } else {
                    Fluttertoast.showToast(msg: "交易签名 失败");
                    NavigatorUtils.goBack(context);
                  }
                },
              );
            },
          );
        }));

    jsChannelList.add(JavascriptChannel(
        name: "NativeGoBack",
        onMessageReceived: (JavascriptMessage message) {
          print("NativeSignMsg 从NativeGoBack传回来的参数======>： ${message.message}");
          NavigatorUtils.push(context, Routes.ethPage);
        }));

    return jsChannelList.toSet();
  }
}
