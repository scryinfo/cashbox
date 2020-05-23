import 'package:app/generated/i18n.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scry_webview/scry_webview.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  WebViewController _controller;

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
            backgroundColor: Colors.transparent,
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
      child: WebView(
        initialUrl: "https://cashbox.scry.info/public",
        javascriptMode: JavascriptMode.unrestricted, //JS执行模式 是否允许JS执行
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        javascriptChannels: <JavascriptChannel>[].toSet(),
      ),
    );
  }
}
