import 'dart:async';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DAppWebViewDemo extends StatefulWidget {
  @override
  _DAppWebViewDemoState createState() => _DAppWebViewDemoState();
}

class _DAppWebViewDemoState extends State<DAppWebViewDemo> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_graduate.png"),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(
            centerTitle: "DApp",
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.transparent,
            child: _buildWebViewWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewWidget() {
    return Container(
      color: Colors.transparent,
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: WebView(
        initialUrl: "http://192.168.1.4:8080/",
        javascriptMode: JavascriptMode.unrestricted,
        //JS执行模式 是否允许JS执行
        onWebViewCreated: (webViewController) {
          _controller = webViewController;
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
            name: "NativePwdDialog",
            onMessageReceived: (JavascriptMessage message) {
              print("从webview传回来的参数======>： ${message.message}");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PwdDialog(
                    title: "钱包密码",
                    hintContent:
                        "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。",
                    hintInput: "请输入钱包密码",
                    onPressed: (value) {
                      //method 1 方法回调ok
                      _controller
                          ?.evaluateJavascript('callJs("$value")')
                          ?.then((result) {});
                      //method 2 字段回调ok
                      //_controller?.evaluateJavascript('window.qrresult=" $value "')?.then((result) {});
                    },
                  );
                },
              );
            },
          ),
          JavascriptChannel(
              name: "NativeQrScan",
              onMessageReceived: (JavascriptMessage message) {
                Future<String> qrResult = QrScanUtil.instance.qrscan();
                qrResult.then((t) {
                  _controller
                      ?.evaluateJavascript('callJs("$t")')
                      ?.then((result) {});
                }).catchError((e) {
                  Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
                });
              }),
        ].toSet(),
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
