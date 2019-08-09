import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'page/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      title: "cashbox",
      home: SplashPage(),
    ));
  }
}
