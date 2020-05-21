import 'dart:io';

import 'package:app/generated/i18n.dart';
import 'package:app/provide/create_wallet_process_provide.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/sign_info_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/provide/server_config_provide.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'global_config/global_config.dart';
import 'page/entry_page.dart';
import 'package:fluro/fluro.dart';
import 'provide/transaction_provide.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //确保WidgetsFlutterBinding被初始化 把widget跟flutter绑定在一起。
  //  debugPaintLayerBordersEnabled=true; //测试样式边界用
  //  debugPaintBaselinesEnabled=true;
  ///强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
  if (Platform.isAndroid) {
    /*以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，
    覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。*/
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var savedLocale = GlobalConfig.defaultLocaleKey;

  _MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  initData() async {
    var spUtil = await SharedPreferenceUtil.instance;
    savedLocale = spUtil.getString(GlobalConfig.savedLocaleKey) ?? GlobalConfig.defaultLocaleKey;
    setState(() {
      this.savedLocale = savedLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// 注册数据状态管理
        ChangeNotifierProvider(
          builder: (_) => CreateWalletProcessProvide(),
        ),
        ChangeNotifierProvider(
          builder: (_) => WalletManagerProvide(),
        ),
        ChangeNotifierProvider(
          builder: (_) => QrInfoProvide(),
        ),
        ChangeNotifierProvider(
          builder: (_) => SignInfoProvide(),
        ),
        ChangeNotifierProvider(
          builder: (_) => TransactionProvide(),
        ),
        ChangeNotifierProvider(
          builder: (_) => ServerConfigProvide(),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/bg_graduate.png"),
          ),
        ),
        child: RestartWidget(
          childWidget: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: Builder(
              builder: (BuildContext context) {
                var tempLocale = Provider.of<WalletManagerProvide>(context).locale;
                return Localizations.override(
                  context: context,
                  locale: (tempLocale == "" || tempLocale == null) ? Locale(savedLocale, '') : GlobalConfig.loadLocale(tempLocale),
                  child: EntryPage(),
                );
              },
            ),
            onGenerateRoute: Application.router.generator,
          ),
        ),
      ),
    );
  }
}
