import 'package:desktop_webview_window/desktop_webview_window.dart' as desktop_webview;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview_scry_controller.dart';

class ControllerDesktop extends WebviewScryController {
  desktop_webview.Webview? weview;

  @override
  Future<void> go({required Uri uri}) async {
    if (weview != null) {
      weview!.launch(uri.toString());
    }
  }

  @override
  Future<void> goBack() async {
    if (weview != null) {
      weview!.back();
    }
  }

  @override
  Future<void> goForward() {
    // TODO: implement goForward
    throw UnimplementedError();
  }

  @override
  Widget makeWebview() {
    if (!isInit) {
      isInit = true;
      () async {
        try {
          weview = await desktop_webview.WebviewWindow.create();
        } catch (e) {
          isInit = false;
        }
      }();
    }

    return const SizedBox.shrink();
  }

  @override
  Future<void> addJavaScriptChannel(
    String name, {
    required void Function(JavaScriptMessage) onMessageReceived,
  }) async {
    if (weview != null) {
      weview!.registerJavaScriptMessageHandler(name, (name, body) {
        onMessageReceived(JavaScriptMessage(message: body));
      });
    }
  }

  @override
  Future<void> removeJavaScriptChannel(String javaScriptChannelName) async {
    if (weview != null) {
      weview!.unregisterJavaScriptMessageHandler(javaScriptChannelName);
    }
  }

  @override
  Future<void> close() async {
    if (weview != null) {
      weview!.close();
    }
  }
}
