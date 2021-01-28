import 'package:log_util/log_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../routers/router_handler.dart';

class Routes {
  static String homePage = '/homepage';
  static String entrancePage = '/entrancepage';
  static String publicPage = '/publicpage';
  static String dappPage = '/dapppage';
  static String webViewPluginPage = '/webviewpluginpage';
  static String createWalletNamePage = '/createwalletnamepage';
  static String createWalletMnemonicPage = '/createwalletmnemonicpage';
  static String createWalletConfirmPage = '/createwalletconfirmpage';
  static String qrInfoPage = '/qrinfopage';
  static String importWalletPage = '/importwalletpage';
  static String transferEthPage = '/transferethpage';
  static String transferEeePage = '/transfereeepage';
  static String transferEeeConfirmPage = '/transfereeeconfirmpage';
  static String transferBtcPage = '/transferbtcpage';
  static String digitListPage = '/digitlistpage';
  static String digitManagePage = '/digitmanagepage';
  static String searchDigitPage = '/searchdigitpage';

  static String minePage = '/minepage';
  static String ddd2eeePage = '/ddd2eeepage';
  static String ddd2eeeConfirmPage = '/ddd2eeeconfirmpage';
  static String walletManagerListPage = '/walletmanagerlistpage';
  static String languageChoosePage = '/languagechoosepage';
  static String walletManagerPage = '/walletmanagerpage';
  static String resetPwdPage = '/resetpwdpage';
  static String recoverWalletPage = '/recoverwalletpage';
  static String privacyStatementPage = '/privacystatementpage';
  static String serviceAgreementPage = '/serviceagreementpage';
  static String ethChainTxHistoryPage = '/ethchaintxhistorypage';
  static String eeeChainTxHistoryPage = '/eeechaintxhistorypage';
  static String eeeTransactionDetailPage = '/transactioneeedetailpage';
  static String ethTransactionDetailPage = '/transactionethdetailpage';
  static String aboutUsPage = '/aboutuspage';
  static String createTestWalletPage = '/createtestwalletpage';
  static String signTxPage = '/signtxpage';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
      LogUtil.instance().e("Routers error is=>", "noFoundHandler");
    });

    router.define(homePage, handler: homePageHandler);
    router.define(entrancePage, handler: entrancePageHandler);
    router.define(publicPage, handler: publicPageHandler);
    router.define(dappPage, handler: dappPageHandler);
    router.define(createWalletNamePage, handler: createWalletPageHandler);
    router.define(digitListPage, handler: digitListPageHandler);
    router.define(digitManagePage, handler: digitManageHandler);
    router.define(searchDigitPage, handler: searchDigitPageHandler);

    router.define(createWalletMnemonicPage, handler: createWalletMnemonicPageHandler);
    router.define(createWalletConfirmPage, handler: createWalletConfirmPageHandler);
    router.define(qrInfoPage, handler: qrInfoPageHandler);
    router.define(aboutUsPage, handler: aboutUsPageHandler);
    router.define(importWalletPage, handler: importWalletPageHandler);
    router.define(transferEthPage, handler: transferEthPageHandler);
    router.define(transferEeePage, handler: transferEeePageHandler);
    router.define(transferEeeConfirmPage, handler: transferEeeConfirmPageHandler);
    router.define(transferBtcPage, handler: transferBtcPageHandler);
    router.define(minePage, handler: minePageHandler);
    router.define(ddd2eeePage, handler: ddd2eeePageHandler);
    router.define(ddd2eeeConfirmPage, handler: ddd2eeeConfirmPageHandler);
    router.define(walletManagerListPage, handler: walletManagerListPageHandler);
    router.define(languageChoosePage, handler: languageChoosePageHandler);
    router.define(walletManagerPage, handler: walletManagerPageHandler);
    router.define(resetPwdPage, handler: resetPwdPageHandler);
    router.define(recoverWalletPage, handler: recoverWalletPageHandler);
    router.define(privacyStatementPage, handler: privacyStatementHandler);
    router.define(serviceAgreementPage, handler: serviceAgreementHandler);
    router.define(ethChainTxHistoryPage, handler: ethChainTxHistoryHandler);
    router.define(eeeChainTxHistoryPage, handler: eeeChainTxHistoryHandler);
    router.define(eeeTransactionDetailPage, handler: eeeTransactionDetailHandler);
    router.define(ethTransactionDetailPage, handler: ethTransactionDetailHandler);
    router.define(createTestWalletPage, handler: createTestWalletHandler);
    router.define(signTxPage, handler: signTxPageHandler);
  }
}
