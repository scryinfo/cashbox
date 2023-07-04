import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'controller_desktop.dart';
import 'controller_mobile.dart';

abstract class WebviewScryController {
  static WebviewScryController create() {
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return new ControllerMobile();
    } else {
      return new ControllerDesktop();
    }
  }

  bool isInit = false;

  Widget makeWebview();

  Future<void> goBack() async {}

  Future<void> goForward() async {}

  Future<void> go({required Uri uri}) async {}
}
