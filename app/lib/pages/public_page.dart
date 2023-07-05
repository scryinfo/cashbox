import 'dart:convert';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviews/webviews.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  WebviewScryController _controller = WebviewScryController.create();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    super.didChangeDependencies();
    for (var it in makeJsChannelsSet().entries) {
      _controller.addJavaScriptChannel(it.key, onMessageReceived: it.value);
    }
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
            onPressed: () {},
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
                return _controller.makeWebview();
              }
              return Text("");
            }));
  }

  Map<String, void Function(JavaScriptMessage message)> makeJsChannelsSet() {
    Map<String, void Function(JavaScriptMessage message)> jsChannelList = {};
    jsChannelList["NativeLocaleValue"] = (JavaScriptMessage message) async {
      Config config = await HandleConfig.instance.getConfig();
      var msg = Message.fromJson(jsonDecode(message.message));
      if (msg.data == null || msg.data.trim() == "") {
        msg.data = config.locale;
        this.callPromise(msg);
      }
    };
    return jsChannelList;
  }

  Future<String> callPromise(Message msg) async {
    String call = "${msg.callFun}(\'${jsonEncode(msg)}\')";
    var r = await _controller.runJavaScriptReturningResult(call);
    if (r == null) {
      return "";
    } else {
      return r.toString();
    }
  }
}

class Message {
  // message id
  String id = "";

  // message data, 自定义格式
  String data = "";

  // message 消息完成后调用的函数，此函数直接在window下面
  String callFun = "";

  // 出错误信息，没有出错时为零长度字符串
  String err = "";

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
