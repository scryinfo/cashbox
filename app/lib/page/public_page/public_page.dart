import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
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
            centerTitle: "公告",
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
        initialUrl: "https://cashbox.scry.info/public",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
