import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UniSwapPage extends StatefulWidget {
  const UniSwapPage() : super();

  @override
  _UniSwapPageState createState() => _UniSwapPageState();
}

class _UniSwapPageState extends State<UniSwapPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(90, 160), allowFontScaling: false);
    return Scaffold(
      body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: FutureBuilder(
              future: _loadDappUrl(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("sorry,some error happen!");
                }
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(4.5)),
                    child: WebView(
                      initialUrl: snapshot.data.toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                      debuggingEnabled: true,
                      userAgent:
                          "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
                      //JS execution mode Whether to allow JS execution
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller = webViewController;
                        //_loadHtmlFromAssets(_controller); //Load local html file
                      },
                      javascriptChannels: makeJsChannelsSet(),
                      navigationDelegate: (NavigationRequest request) {
                        print("navigationDelegate ===============================>:  $request");
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (String url) async {
                        print('Page finished loading================================>: $url');
                      },
                    ),
                  );
                } else {
                  return Text("no data yet,please to refresh page");
                }
              })),
    );
  }

  Future<String> _loadDappUrl() async {
    return "https://uniswap.token.im/?locale=zh-CN&utm_source=imtoken#/";
  }

  Set<JavascriptChannel> makeJsChannelsSet() {
    List<JavascriptChannel> jsChannelList = [];
    return jsChannelList.toSet();
  }
}
