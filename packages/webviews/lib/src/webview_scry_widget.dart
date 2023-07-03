import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart' as webview_desktop_lib;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;

import 'webview_scry_controller.dart' as webview_controller;

class WebViewScry extends StatelessWidget {
  final webview_controller.WebViewScryController controller;
  webview_desktop_lib.Webview? webView_desktop = null;

  WebViewScry({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.is_init) {
      return const SizedBox.shrink();
    }
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return Visibility(
        visible: controller.is_init,
        replacement: const SizedBox.shrink(),
        child: webview_flutter.WebViewWidget(
          controller: controller.webview_mobile_controller,
        ),
      );
    } else {
      return Visibility(
        visible: controller.is_init,
        replacement: const SizedBox.shrink(),
        child: const Text(""),
        // child: webview_desktop_lib.WebviewWindow.create(),
      );
    }
  }
}
