import 'dart:typed_data';

import 'package:app/model/wallets.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/native_file_system_util.dart';
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
            //initialUrl: "file:///android_asset/flutter_assets/assets/dist/index.html",
            //initialUrl: "file:///android_asset/flutter_assets/assets/dist-one/dist-one-index.html",
            initialUrl: "http://192.168.1.4:8080/",
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
            onPageFinished: (String url) {
              _controller?.evaluateJavascript('nativeChainAddressToJsResult("666666777")')?.then((result) {}); //传钱包EEE链地址给DApp记录保存
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
      name: "NativePwdDialog",
      onMessageReceived: (JavascriptMessage message) {
        print("NativePwdDialog 从webview传回来的参数======>： ${message.message}");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PwdDialog(
              title: "钱包密码",
              hintContent: "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。",
              hintInput: "请输入钱包密码",
              onPressed: (value) {
                //method 1 方法回调ok
                _controller?.evaluateJavascript('callJs("$value")')?.then((result) {}); //todo change callback func name
                //method 2 字段回调ok
                //_controller?.evaluateJavascript('window.qrresult=" $value "')?.then((result) {});
              },
            );
          },
        );
      },
    ));
    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanToJs",
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((t) {
            Fluttertoast.showToast(msg: "扫描j结果是======> $t");
            _controller?.evaluateJavascript('nativeQrScanToJsResult("$t")')?.then((result) {});
          }).catchError((e) {
            Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
          });
        }));
    jsChannelList.add(JavascriptChannel(
        name: "NativeQrScanAndPwdAndSignToQR",
        onMessageReceived: (JavascriptMessage message) {
          Future<String> qrResult = QrScanUtil.instance.qrscan();
          qrResult.then((qrInfo) {
            Map paramsMap = QrScanUtil.instance.checkQrInfoByDiamondSignAndQr(qrInfo, context);
            if (paramsMap == null) {
              Fluttertoast.showToast(msg: "扫描内容结果不符合diamond Dapp规则");
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
          /*先将字符串转成json*/
          //Map<String, dynamic> jsonMap = jsonDecode(message.message);
          /*将Json转成实体类*/
          //TransactionModel txModel=TransactionModel.fromJson(jsonMap);
          /*取值*/
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                title: "钱包密码",
                hintContent: "提示：请输入您的密码，对交易信息进行签名。 ",
                hintInput: "请输入钱包密码",
                onPressed: (pwd) {
                  //传递签名参数， 钱包id + 密码 + 待签名操作
                  //Map map = Wallets.instance.eeeTxSign(Provider.of<WalletManagerProvide>(context).walletId, Uint8List.fromList(pwd.codeUints),message.message),

                  //todo : mock data,直接返回签名后假数据
                  _controller?.evaluateJavascript('nativeSignMsgToJsResult("直接返回mock假数据  签名证书上链功能部分")')?.then((result) {});
                  NavigatorUtils.goBack(context);
                  //todo parker 10/28
                  //Map map = Wallets.instance.eeeTxSign(Provider.of<WalletManagerProvide>(context).walletId, Uint8List.fromList(pwd.codeUints),
                  //    message.message.toString()); //todo check params is right  1010 parker
                  //if (map == null) {
                  //  Fluttertoast.showToast(msg: "交易签名出现未知错误");
                  //  return;
                  //}
                  //if (map["status"] == 200) {
                  //  Fluttertoast.showToast(msg: "交易签名 成功");
                  //  var result = " mock result ";
                  //  //todo 签名完成后的结果，传回给 webveiw。 webview负责处理是否上链广播交易
                  //  _controller?.evaluateJavascript('nativeSignMsgToJsResult("$result")')?.then((result) {});
                  //  return;
                  //} else {
                  //  Fluttertoast.showToast(msg: "交易签名 失败" + map["message"]);
                  //  LogUtil.e("NativeSignMsg=>", "tx sign failure,message is===>" + map["message"]);
                  //  return;
                  //}
                },
              );
            },
          );
        }));
    jsChannelList.add(JavascriptChannel(
        name: "NativeGoBack",
        onMessageReceived: (JavascriptMessage message) {
          print("NativeSignMsg 从NativeGoBack传回来的参数======>： ${message.message}");
          NavigatorUtils.goBack(context);
        }));
    return jsChannelList.toSet();
  }
}
