import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/splash_page.dart';
import 'package:app/page/eee_page/eee_page.dart';
import '../page/public_page/public_page.dart';
import '../page/create_wallet_page/create_wallet_name_page.dart';
import '../page/create_wallet_page/create_wallet_mnemonic_page.dart';
import '../page/create_wallet_page/create_wallet_confirm_page.dart';
import '../page/address_page/address_page.dart';

Handler splashPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

Handler eeePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeePage();
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

Handler createWalletConfirmPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletConfirmPage();
});

Handler addressPageHandler = Handler(handlerFunc: (context, params) {
  String name = params['walletName']?.first;
  String title = params['title']?.first;
  String content = params['content']?.first;
  print("router handler===>" +
      params['walletName']?.first +
      "||" +
      params['title']?.first +
      "||" +
      params['content']?.first);
  return AddressPage(name, title, content);
});