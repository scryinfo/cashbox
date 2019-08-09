import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/splash_page.dart';
import '../page/home_page.dart';

Handler splashPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

Handler homePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});
