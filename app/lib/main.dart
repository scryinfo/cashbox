import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'package:app/res/resources.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    /*以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，
    覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。*/
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/bg_graduate.png"),
        ),
      ),
      child: MaterialApp(
        home: SplashPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
