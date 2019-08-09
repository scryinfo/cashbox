import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'page/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'package:app/res/resources.dart';

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
          theme: ThemeData(
            primaryColor: Colours.app_main,
            scaffoldBackgroundColor: Colors.black26,
          ),
          home: SplashPage(),
        ),
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }
}
