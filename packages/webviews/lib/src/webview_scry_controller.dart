import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'controller_desktop.dart';
import 'controller_mobile.dart';
import 'webview_scry_widget.dart';

abstract class WebviewScryController {
  static WebviewScryController create() {
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return new ControllerMobile();
    } else {
      return new ControllerDesktop();
    }
  }

  bool isInit = false;

  @override
  Widget makeWebview() {
    return WebviewScry(
      controller: this,
    );
  }

  Future<void> loadRequest(Uri uri) async {}

  Future<void> goBack() async {}

  Future<void> goForward() async {}

  Future<void> go({required Uri uri}) async {}

  Future<void> setNavigationDelegate(NavigationDelegate delegate) async {}

  Future<void> addJavaScriptChannel(
    String name, {
    required void Function(JavaScriptMessage) onMessageReceived,
  }) async {}

  Future<void> removeJavaScriptChannel(String javaScriptChannelName) async {}

  Future<void> runJavaScript(String javaScript) async {}

  Future<Object> runJavaScriptReturningResult(String javaScript) async {
    return Object();
  }

  Future<String> getTitle() async {
    return "";
  }

  Future<void> close() async {}
}
