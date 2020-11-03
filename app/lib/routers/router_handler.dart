import 'package:app/demo/flutter_webview_plugin_demo.dart';
import 'package:app/demo/local_html_webview_demo.dart';
import 'package:app/pages/ddd2eee_page/ddd2eee_confirm_page.dart';
import 'package:app/pages/ddd2eee_page/ddd2eee_page.dart';
import 'package:app/pages/digit_list_page/digit_list_page.dart';
import 'package:app/pages/digits_manage_page/digits_manage_page.dart';
import 'package:app/pages/digits_manage_page/search_digit_page.dart';
import 'package:app/pages/eee_page/eee_page.dart';
import 'package:app/pages/language_choose_page/language_choose_page.dart';
import 'package:app/pages/sign_tx_page/sign_tx_page.dart';
import 'package:app/pages/transaction_detail_page/eee_transaction_detail_page.dart';
import 'package:app/pages/transaction_detail_page/eth_transaction_detail_page.dart';
import 'package:app/pages/transfer_btc_page/transfer_btc_page.dart';
import 'package:app/pages/transfer_confirm_page/eee_transfer_confirm_page.dart';
import 'package:app/pages/transfer_eee_page/transfer_eee_page.dart';
import 'package:app/pages/tx_list_history_page/eee_chain_txs_history_page.dart';
import 'package:app/pages/tx_list_history_page/eth_chain_txs_history_page.dart';
import 'package:app/pages/user_protocol/privacy_statements_page.dart';
import 'package:app/pages/user_protocol/service_agreement_page.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/entry_page.dart';
import 'package:app/pages/eth_page/eth_page.dart';
import '../pages/public_page/public_page.dart';
import '../pages/create_wallet_page/create_wallet_name_page.dart';
import '../pages/create_wallet_page/create_wallet_mnemonic_page.dart';
import '../pages/create_wallet_page/create_wallet_confirm_page.dart';
import '../pages/qr_info_page/qr_info_page.dart';
import '../pages/import_wallet_page/import_wallet_page.dart';
import '../pages/transfer_eth_page/transfer_eth_page.dart';
import '../pages/mine_page/mine_page.dart';
import '../pages/wallet_manager_list_page/wallet_manager_list_page.dart';
import '../pages/wallet_manager_page/wallet_manage_page.dart';
import '../pages/reset_pwd_page/reset_pwd_page.dart';
import '../pages/recover_wallet_page/recover_wallet_page.dart';
import '../pages/about_us_page/about_us_page.dart';
import 'package:app/pages/dapp_page/dapp_page.dart';
import 'package:app/pages/create_test_wallet_page/create_test_wallet_page.dart';

Handler entryPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EntryPage();
});

Handler ethPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool isForceLoadFromJni = false;
  if (params['isForceLoadFromJni'] == null || params['isForceLoadFromJni'].first == null) {
    isForceLoadFromJni = false;
  } else {
    isForceLoadFromJni = params['isForceLoadFromJni'].first == 'true';
  }
  return EthPage(isForceLoadFromJni: isForceLoadFromJni);
});

Handler eeePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeePage();
});

Handler publicPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PublicPage();
});

Handler dappPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DappPage();
});

Handler createWalletPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletNamePage();
});

Handler digitListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DigitListPage();
});

Handler digitManageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool isReloadDigitList = false;
  if (params['isReloadDigitList'] == null || params['isReloadDigitList'].first == null) {
    isReloadDigitList = false;
  } else {
    isReloadDigitList = params['isReloadDigitList'].first == 'true';
  }
  return DigitsManagePage(isReloadDigitList: isReloadDigitList);
});

Handler searchDigitPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchDigitPage();
});

Handler createWalletMnemonicPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletMnemonicPage();
});

Handler createWalletConfirmPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateWalletConfirmPage();
});

Handler qrInfoPageHandler = Handler(handlerFunc: (context, params) {
  return QrInfoPage();
});

Handler importWalletPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ImportWalletPage();
});

Handler transferEthPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TransferEthPage();
});

Handler transferEeePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TransferEeePage();
});

Handler transferEeeConfirmPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeeTransferConfirmPage();
});




Handler transferBtcPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TransferBtcPage();
});

Handler minePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MinePage();
});

Handler ddd2eeePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Ddd2EeePage();
});

Handler ddd2eeeConfirmPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Ddd2EeeConfirmPage();
});

Handler walletManagerListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WalletManagerListPage();
});

Handler languageChoosePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LanguageChoosePage();
});

Handler walletManagerPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WalletManagerPage();
});

Handler resetPwdPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ResetPwdPage();
});

Handler recoverWalletPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RecoverWalletPage();
});

Handler privacyStatementHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PrivacyStatementPage();
});

Handler serviceAgreementHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ServiceAgreementPage();
});

Handler ethChainTxHistoryHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EthChainTxsHistoryPage();
});

Handler eeeChainTxHistoryHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeeChainTxsHistoryPage();
});

Handler ethTransactionDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EthTransactionDetailPage();
});

Handler eeeTransactionDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeeTransactionDetailPage();
});

Handler aboutUsPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutUsPage();
});

Handler createTestWalletHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateTestWalletPage();
});
Handler signTxPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignTxPage();
});

Handler flutterWebViewPluginHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FlutterWebViewPluginDemo();
});
