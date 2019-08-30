import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/splash_page.dart';
import 'package:app/page/eee_page/eee_page.dart';
import '../page/public_page/public_page.dart';
import '../page/create_wallet_page/create_wallet_name_page.dart';
import '../page/create_wallet_page/create_wallet_mnemonic_page.dart';
import '../page/create_wallet_page/create_wallet_confirm_page.dart';
import '../page/address_page/address_page.dart';
import '../page/import_wallet_page/import_wallet_page.dart';
import '../page/transfer_eee_page/transfer_eee_page.dart';
import '../page/mine_page/mine_page.dart';
import '../page/wallet_manager_list_page/wallet_manager_list_page.dart';
import '../page/wallet_manager_page/wallet_manage_page.dart';
import '../page/reset_pwd_page/reset_pwd_page.dart';
import '../page/recover_wallet_page/recover_wallet_page.dart';
import '../page/transaction_history_page/transaction_history_page.dart';
import 'package:app/page/user_protocol/privacy_statements_zh.dart';
import 'package:app/page/user_protocol/service_agreement_zh.dart';
import 'package:app/page/transaction_detail_page/eee_transactin_detail_page.dart';
import '../page/about_us_page/about_us_page.dart';
import 'package:app/demo/dapp_webview_demo.dart';
import 'package:app/page/dapp_page/dapp_page.dart';
import 'package:app/page/create_test_wallet_page/create_test_wallet_page.dart';

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

Handler dappPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DappPage();
});

Handler dappDemoPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DAppWebViewDemo();
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
  print("router handler===>" +
      params['walletName']?.first +
      "||" +
      params['title']?.first +
      "||" +
      params['content']?.first);
  String name = params['walletName']?.first;
  String title = params['title']?.first;
  String content = params['content']?.first;

  return AddressPage(name, title, content);
});

Handler importWalletPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ImportWalletPage();
});

Handler transferEeePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TransferEeePage();
});

Handler minePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MinePage();
});

Handler walletManagerListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WalletManagerListPage();
});

Handler walletManagerPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WalletManagerPage();
});

Handler resetPwdPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ResetPwdPage();
});

Handler recoverWalletPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RecoverWalletPage();
});

Handler privacyStatementHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PrivacyStatementPage();
});

Handler serviceAgreementHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ServiceAgreementPage();
});

Handler transactionHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TransactionHistoryPage();
});

Handler transactionEeeDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeeTransactionDetailPage();
});

Handler aboutUsPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutUsPage();
});

Handler createTestWalletHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateTestWalletPage();
});
