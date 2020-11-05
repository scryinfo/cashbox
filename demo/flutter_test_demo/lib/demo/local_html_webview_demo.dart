import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LocalHtmlWebViewDemo extends StatefulWidget {
  @override
  _LocalHtmlWebViewDemoState createState() => _LocalHtmlWebViewDemoState();
}

class _LocalHtmlWebViewDemoState extends State<LocalHtmlWebViewDemo> {
  String localHtmlFilPath = "";
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("html demo")),
      body: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        color: Colors.blueAccent,
        child: WebView(
          initialUrl: "http://192.168.1.4:8080",
          //initialUrl: "file:///android_asset/flutter_assets/assets/dist/index.html",
          javascriptMode: JavascriptMode.unrestricted,

          //JS execution mode Whether to allow JS execution
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
              name: "NativePwdDialog",
              onMessageReceived: (JavascriptMessage message) {
                print("从webview传回来的参数======>： ${message.message}");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    /*return PwdDialog(
                      title: "钱包密码",
                      hintContent: "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。",
                      hintInput: "请输入钱包密码",
                      onPressed: (value) {
                        //method 1 method callback ok
                        _controller?.evaluateJavascript('callJs("$value")')?.then((result) {});
                        //method 2 field callback ok
                        //_controller?.evaluateJavascript('window.qrresult=" $value "')?.then((result) {});
                      },
                    );*/
                  },
                );
              },
            ),
            JavascriptChannel(
                name: "NativeQrScan",
                onMessageReceived: (JavascriptMessage message) async {
                  var status = await Permission.camera.status;
                  if (status.isGranted) {
                    _scanQrContent();
                  } else {
                    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
                    if (statuses[Permission.camera] == PermissionStatus.granted) {
                      _scanQrContent();
                    } else {
                      // Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
                    }
                  }
                }),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            print("navigationDelegate ===============================>:  $request");
            print("navigationDelegate url===============================>:  $request.url");
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading================================>: $url');
          },
        ),
      ),
    );
  }

  void _scanQrContent() {
    /*Future<String> qrResult = QrScanUtil.instance.qrscan();
    qrResult.then((t) {
      Fluttertoast.showToast(msg: "扫描结果是======> $t");
      _controller?.evaluateJavascript('nativeScanResult("$t")')?.then((result) {});
    }).catchError((e) {
      Fluttertoast.showToast(msg: "扫描已取消，或出现未知失败");
    });*/
  }
}
