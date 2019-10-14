import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FlutterWebViewPluginDemo extends StatefulWidget {
  @override
  _FlutterWebViewPluginDemo createState() => _FlutterWebViewPluginDemo();
}

class _FlutterWebViewPluginDemo extends State<FlutterWebViewPluginDemo> {
  String localHtmlFilPath = "";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initListen();
  }

  void initListen() {
    //  监听url地址改变事件
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("flutterWebviewPlugin url =========>" + url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("html demo")),
      body: Container(
        width: ScreenUtil.instance.setWidth(90),
        height: ScreenUtil.instance.setHeight(160),
        color: Colors.blueAccent,
        child: WebviewScaffold(   //说明：WebViewScaffold 没法跟js交互
          //url: "file:///android_asset/flutter_assets/assets/dist/index.html",
          url: "http://192.168.1.4:8080/",
          appBar: AppBar(
            title: const Text('Widget WebView'),
          ),
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(
            color: Colors.redAccent,
            child: const Center(
              child: Text('Waiting.....'),
            ),
          ),
        ),
      ),
    );
  }
}
