import 'package:flutter/material.dart';
import 'package:webviews/webviews.dart';

class WebViewScry extends StatelessWidget {
  final WebviewScryController controller;

  WebViewScry({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return controller.makeWebview();
  }
}
