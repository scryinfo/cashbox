import 'dart:io';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/pages/entrance.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/provide/wc_info_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'provide/transaction_provide.dart';
import 'routers/application.dart';
import 'routers/routers.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Make sure that WidgetsFlutterBinding is initialized. Bind the widget with flutter.
  //  debugPaintLayerBordersEnabled=true; //For testing style boundaries
  //  debugPaintBaselinesEnabled=true;
  ///Force portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Config config = await HandleConfig.instance.getConfig();
  if (config == null) {
    exit(0);
  }
  List<String> languagesKeyList = [];
  config.languages.forEach((element) {
    languagesKeyList.add(element.localeKey);
  });

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: config.locale,
    supportedLocales: languagesKeyList,
  );

  runApp(LocalizedApp(delegate, MyApp()));

  if (Platform.isAndroid) {
    /*The following two lines set the android status bar to transparent immersion. It is written after the component is rendered, in order to perform set assignment after rendering,
     Override the status bar. The MaterialApp component overwrites this value before rendering.*/
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  _MyApp() {
    Routes.configureRoutes(Application.router);
  }

  @override
  void initState() {
    super.initState();
    initLocale();
  }

  initLocale() async {
    Config config = await HandleConfig.instance.getConfig();
    changeLocale(context, config.locale);
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return MultiProvider(
      providers: [
        /// Registration data status management, similar to vuex implementation
        ChangeNotifierProvider(
          create: (_) => CreateWalletProcessProvide(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletManagerProvide(),
        ),
        ChangeNotifierProvider(
          create: (_) => QrInfoProvide(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInfoProvide(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvide(),
        ),
        ChangeNotifierProvider(
          create: (_) => WcInfoProvide(),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/bg_graduate.png"),
          ),
        ),
        child: LocalizationProvider(
          state: LocalizationProvider.of(context).state,
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,

            ///Page entry
            home: EntrancePage(),
            onGenerateRoute: Application.router.generator,
          ),
        ),
      ),
    );
  }
}
