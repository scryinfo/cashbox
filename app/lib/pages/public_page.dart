import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/util/sharedpreference_util.dart';
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
  String targetUrl = "";
  Future targetUrlFuture;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    super.didChangeDependencies();
    targetUrlFuture = loadTargetUrl();
  }

  loadTargetUrl() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var publicValue = spUtil.getString(VendorConfig.publicIpKey);
    targetUrl = publicValue ?? VendorConfig.publicIpDefaultValue;
    print("targetUrl===>" + targetUrl);
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
            future: targetUrlFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("sorry,some error happen!");
              }
              if (snapshot.hasData) {
                return WebView(
                  initialUrl: targetUrl,
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
          _controller?.evaluateJavascript('nativeLocale("$config.locale")')?.then((result) {});
        }));
    return jsChannelList.toSet();
  }
}
