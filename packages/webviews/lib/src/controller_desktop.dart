import 'package:desktop_webview_window/desktop_webview_window.dart' as desktop_webview;
import 'package:flutter/material.dart';

import 'webview_scry_controller.dart';

class ControllerDesktop extends WebviewScryController {
  desktop_webview.Webview? weview;

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
}
