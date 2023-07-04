import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviews/src/webview_scry_controller.dart';

class ControllerMobile extends WebviewScryController {
  late WebViewController _webViewController;

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
    if (isInit) {
      return const SizedBox.shrink();
    }
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
