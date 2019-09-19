import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      body: WebView(
        initialUrl: "",
        javascriptMode: JavascriptMode.unrestricted,
        //JS执行模式 是否允许JS执行
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets(_controller); //载入本地html文件
        },
        onPageFinished: (String url) {},
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  _loadHtmlFromAssets(WebViewController _controller) async {
    if (_controller == null) {
      return;
    }
    String fileText = await rootBundle.loadString('assets/html/demo.html');
    print("_loadHtmlFromAssets fileText========================>" + fileText.toString());
    _controller.loadUrl(Uri.dataFromString(
      fileText,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }
}
