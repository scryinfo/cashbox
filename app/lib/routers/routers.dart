import 'package:app/util/log_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../routers/router_handler.dart';

class Routes {
  static String eeePage = '/eeepage';
  static String entryPage = '/entrypage';
  static String publicPage = '/publicpage';
  static String dappPage = '/dapppage';
  static String dappDemoPage = '/dappdemopage';
  static String createWalletNamePage = '/createwalletnamepage';
  static String createWalletMnemonicPage = '/createwalletmnemonicpage';
  static String createWalletConfirmPage = '/createwalletconfirmpage';
  static String qrInfoPage = '/qrinfopage';
  static String importWalletPage = '/importwalletpage';
  static String transferEeePage = '/transfereeepage';

  static String minePage = '/minepage';
  static String walletManagerListPage = '/walletmanagerlistpage';
  static String walletManagerPage = '/walletmanagerpage';
  static String resetPwdPage = '/resetpwdpage';
  static String recoverWalletPage = '/recoverwalletpage';
  static String privacyStatementPage = '/privacystatementpage';
  static String serviceAgreementPage = '/serviceagreementpage';
  static String transactionHistoryPage = '/transactionhistorypage';
  static String transactionEeeDetailPage = '/transactioneeedetailpage';
  static String aboutUsPage = '/aboutuspage';
  static String createTestWalletPage = '/createtestwalletpage';
  static String signTxPage = '/signtxpage';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
      LogUtil.e("Routers error is=>", "noFoundHandler");
    });

    router.define(eeePage, handler: eeePageHandler);
    router.define(entryPage, handler: entryPageHandler);
    router.define(publicPage, handler: publicPageHandler);
    router.define(dappPage, handler: dappPageHandler);
    router.define(dappDemoPage, handler: dappDemoPageHandler);
    router.define(createWalletNamePage, handler: createWalletPageHandler);

    router.define(createWalletMnemonicPage, handler: createWalletMnemonicPageHandler);
    router.define(createWalletConfirmPage, handler: createWalletConfirmPageHandler);
    router.define(qrInfoPage, handler: qrInfoPageHandler);
    router.define(aboutUsPage, handler: aboutUsPageHandler);
    router.define(importWalletPage, handler: importWalletPageHandler);
    router.define(transferEeePage, handler: transferEeePageHandler);
    router.define(minePage, handler: minePageHandler);
    router.define(walletManagerListPage, handler: walletManagerListPageHandler);
    router.define(walletManagerPage, handler: walletManagerPageHandler);
    router.define(resetPwdPage, handler: resetPwdPageHandler);
    router.define(recoverWalletPage, handler: recoverWalletPageHandler);
    router.define(privacyStatementPage, handler: privacyStatementHandler);
    router.define(serviceAgreementPage, handler: serviceAgreementHandler);
    router.define(transactionHistoryPage, handler: transactionHistoryHandler);
    router.define(transactionEeeDetailPage, handler: transactionEeeDetailHandler);
    router.define(createTestWalletPage, handler: createTestWalletHandler);
    router.define(signTxPage, handler: signTxPageHandler);
  }
}
