import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/splash_page.dart';
import 'package:app/page/eee_page/eee_page.dart';
import '../page/public_page/public_page.dart';
import '../page/create_wallet_page/create_walletname_page.dart';
import '../page/create_wallet_page/create_wallet_mnemonic_page.dart';

Handler splashPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

Handler homePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

Handler publicPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PublicPage();
});
Handler createWalletPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletNamePage();
});

Handler createWalletMnemonicPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletMnemonicPage();
});
