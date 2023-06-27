import 'dart:convert';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    super.didChangeDependencies();
  }

  Future<String> loadTargetUrl() async {
    Config config = await HandleConfig.instance.getConfig();
    String targetUrl = config.privateConfig.publicIp;
    return targetUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(
            centerTitle: translate('public'),
            backgroundColor: Colors.black12,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
            ),
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
        child: FutureBuilder(
            future: loadTargetUrl(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("sorry,some error happen!");
              }
              if (snapshot.hasData) {
                return WebView(
                  initialUrl: snapshot.data.toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                  //JS execution mode Whether to allow JS execution
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  javascriptChannels: makeJsChannelsSet(),
                  onPageFinished: (String url) {},
                );
              }
              return Text("");
            }));
  }

  Set<JavascriptChannel> makeJsChannelsSet() {
    List<JavascriptChannel> jsChannelList = [];
    jsChannelList.add(JavascriptChannel(
        name: "NativeLocaleValue",
        onMessageReceived: (JavascriptMessage message) async {
          Config config = await HandleConfig.instance.getConfig();
          var msg = Message.fromJson(jsonDecode(message.message));
          if (msg.data == null || msg.data.trim() == "") {
            msg.data = config.locale;
            this.callPromise(msg);
          }
        }));
    return jsChannelList.toSet();
  }

  Future<String> callPromise(Message msg) {
    String call = "${msg.callFun}(\'${jsonEncode(msg)}\')";
    return _controller?.evaluateJavascript(call);
  }
}

class Message {
  // message id
  String id;

  // message data, 自定义格式
  String data;

  // message 消息完成后调用的函数，此函数直接在window下面
  String callFun;

  // 出错误信息，没有出错时为零长度字符串
  String err;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    callFun = json['callFun'];
    err = json['err'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['callFun'] = this.callFun;
    data['err'] = this.err;
    return data;
  }
}
