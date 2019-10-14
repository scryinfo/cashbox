import 'dart:typed_data';

import 'package:app/model/wallets.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
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
        color: Colors.blueAccent,
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
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
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
            ),
            JavascriptChannel(
                name: "NativeQrScan",
                onMessageReceived: (JavascriptMessage message) {
                  Future<String> qrResult = QrScanUtil.instance.qrscan();
                  qrResult.then((t) {
                    Fluttertoast.showToast(msg: "扫描j结果是======> $t");
                    _controller?.evaluateJavascript('nativeScanResult("$t")')?.then((result) {});
                  }).catchError((e) {
                    Fluttertoast.showToast(msg: "扫描发生未知失败，请重新尝试");
                  });
                }),
            JavascriptChannel(
                name: "NativeSignMsg",
                onMessageReceived: (JavascriptMessage message) {
                  print("NativeSignMsg 从ebview传回来的参数======>： ${message.message}");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PwdDialog(
                        title: "钱包密码",
                        hintContent: "提示：请输入您的密码，对交易信息进行签名。 ",
                        hintInput: "请输入钱包密码",
                        onPressed: (pwd) {
                          Map map = Wallets.instance.eeeTxSign(Provider.of<WalletManagerProvide>(context).walletId, Uint8List.fromList(pwd.codeUints),
                              message.message.toString()); //todo check params is right  1010 parker
                          if (map == null) {
                            Fluttertoast.showToast(msg: "交易签名出现未知错误");
                            return;
                          }
                          if (map["status"] == 200) {
                            Fluttertoast.showToast(msg: "交易签名 成功");
                            return;
                          } else {
                            Fluttertoast.showToast(msg: "交易签名 失败" + map["message"]);
                            LogUtil.e("NativeSignMsg=>", "tx sign failure,message is===>" + map["message"]);
                            return;
                          }
                        },
                      );
                    },
                  );
                }),
            JavascriptChannel(
                name: "NativeGoBack",
                onMessageReceived: (JavascriptMessage message) {
                  print("NativeSignMsg 从NativeGoBack传回来的参数======>： ${message.message}");
                  NavigatorUtils.goBack(context);
                }),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            print("navigationDelegate ===============================>:  $request");
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading================================>: $url');
          },
        ),
      ),
    );
  }
}
