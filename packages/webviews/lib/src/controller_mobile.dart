import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviews/src/webview_scry_controller.dart';

class ControllerMobile extends WebviewScryController {
  webview_flutter.WebViewController? _webViewController;

  @override
  Future<void> loadRequest(Uri uri) async {
    if (_webViewController != null) {
      return _webViewController!.loadRequest(uri);
    }
  }

  @override
  Future<void> go({required Uri uri}) async {
    if (_webViewController != null) {
      _webViewController!.loadRequest(uri);
    }
  }

  @override
  Future<void> goBack() async {
    if (_webViewController != null) {
      _webViewController!.goBack();
    }
  }

  @override
  Future<void> goForward() async {
    if (_webViewController != null) {
      _webViewController!.goForward();
    }
  }

  @override
  Widget makeWebview() {
    _webViewController ??= webview_flutter.WebViewController();
    return webview_flutter.WebViewWidget(controller: _webViewController!);
  }

  @override
  Future<void> setNavigationDelegate(NavigationDelegate delegate) async {
    if (_webViewController != null) {
      _webViewController!.setNavigationDelegate(delegate);
    }
  }

  @override
  Future<void> addJavaScriptChannel(
    String name, {
    required void Function(JavaScriptMessage) onMessageReceived,
  }) async {
    if (_webViewController != null) {
      _webViewController!.addJavaScriptChannel(name, onMessageReceived: onMessageReceived);
    }
  }

  @override
  Future<void> removeJavaScriptChannel(String javaScriptChannelName) async {
    if (_webViewController != null) {
      _webViewController!.removeJavaScriptChannel(javaScriptChannelName);
    }
  }

  @override
  Future<void> runJavaScript(String javaScript) async {
    if (_webViewController != null) {
      _webViewController!.runJavaScript(javaScript);
    }
  }

  @override
  Future<Object> runJavaScriptReturningResult(String javaScript) async {
    if (_webViewController != null) {
      return _webViewController!.runJavaScriptReturningResult(javaScript);
    }
    return Object();
  }

  @override
  Future<String> getTitle() async {
    String title = "";
    if (_webViewController != null) {
      var t = await _webViewController!.getTitle();
      if (t != null) {
        title = t!;
      }
    }
    return title;
  }
}
