import 'package:app/util/log_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'application.dart';

/// Fluro routing jump tool class
class NavigatorUtils {
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      // The page returns result is null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      LogUtil.instance.e("FluroNavigator error is ===>", "$error");
      print("$error");
    });
  }

  /// return
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// Return with parameters
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  /// todo Jump to WebView page
  static goWebViewPage(BuildContext context, String title, String url) {
    //fluro does not support Chinese transmission, conversion is required
    //push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }
}
