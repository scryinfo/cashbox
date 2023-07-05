import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;
import 'package:webviews/src/webview_scry_controller.dart';

class ControllerMobile extends WebviewScryController {
  webview_flutter.WebViewController? _webViewController;

  @override
  Future<void> go({required Uri uri}) {
    // TODO: implement go
    throw UnimplementedError();
  }

  @override
  Future<void> goBack() {
    // TODO: implement goBack
    throw UnimplementedError();
  }

  @override
  Future<void> goForward() {
    // TODO: implement goForward
    throw UnimplementedError();
  }

  @override
  Widget makeWebview() {
    _webViewController ??= webview_flutter.WebViewController();
    return webview_flutter.WebViewWidget(controller: _webViewController!);
  }
}
