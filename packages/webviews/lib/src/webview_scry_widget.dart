import 'package:flutter/material.dart';
import 'package:webviews/webviews.dart';

class WebviewScry extends StatelessWidget {
  final WebviewScryController controller;

  WebviewScry({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return controller.makeWebview();
  }
}
