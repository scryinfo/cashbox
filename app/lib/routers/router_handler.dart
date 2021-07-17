import 'package:app/pages/about_us.dart';
import 'package:app/pages/create_wallet/create_test_wallet/create_test_wallet.dart';
import 'package:app/pages/create_wallet/create_wallet_confirm.dart';
import 'package:app/pages/create_wallet/create_wallet_mnemonic.dart';
import 'package:app/pages/create_wallet/create_wallet_name.dart';
import 'package:app/pages/create_wallet/import_wallet.dart';
import 'package:app/pages/dapp_page.dart';
import 'package:app/pages/ddd2eee/ddd2eee.dart';
import 'package:app/pages/ddd2eee/ddd2eee_confirm.dart';
import 'package:app/pages/digitlist_manage/digit_list.dart';
import 'package:app/pages/digitlist_manage/digits_manage.dart';
import 'package:app/pages/digitlist_manage/search_digit.dart';
import 'package:app/pages/eee_page.dart';
import 'package:app/pages/entrance.dart';
import 'package:app/pages/eth_page.dart';
import 'package:app/pages/language_choose.dart';
import 'package:app/pages/change_nettype.dart';
import 'package:app/pages/mine.dart';
import 'package:app/pages/privacy_statements.dart';
import 'package:app/pages/public_page.dart';
import 'package:app/pages/qr_info.dart';
import 'package:app/pages/service_agreement.dart';
import 'package:app/pages/transfer_tx/eee_tx_detail.dart';
import 'package:app/pages/transfer_tx/eee_transfer_confirm.dart';
import 'package:app/pages/transfer_tx/eth_tx_detail.dart';
import 'package:app/pages/transfer_tx/sign_tx.dart';
import 'package:app/pages/transfer_tx/transfer_btc.dart';
import 'package:app/pages/transfer_tx/transfer_eee.dart';
import 'package:app/pages/transfer_tx/transfer_eth.dart';
import 'package:app/pages/tx_list_history/eee_chain_txs_history.dart';
import 'package:app/pages/tx_list_history/eth_chain_txs_history.dart';
import 'package:app/pages/wallet_manager/recover_wallet.dart';
import 'package:app/pages/wallet_manager/reset_pwd.dart';
import 'package:app/pages/wallet_manager/wallet_manage.dart';
import 'package:app/pages/wallet_manager/wallet_manager_list.dart';
import 'package:app/pages/wc_protocol/session_apply_page.dart';
import 'package:app/pages/wc_protocol/wc_connected_page.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

Handler entrancePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EntrancePage();
});

Handler ethHomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool isForceLoadFromJni = false;
  if (params['isForceLoadFromJni'] == null || params['isForceLoadFromJni'].first == null) {
    isForceLoadFromJni = false;
  } else {
    isForceLoadFromJni = params['isForceLoadFromJni'].first == 'true';
  }
  return EthPage(isForceLoadFromJni: isForceLoadFromJni);
});

Handler wcConnectedPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WcConnectedPage();
});

Handler eeeHomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool isForceLoadFromJni = false;
  if (params['isForceLoadFromJni'] == null || params['isForceLoadFromJni'].first == null) {
    isForceLoadFromJni = false;
  } else {
    isForceLoadFromJni = params['isForceLoadFromJni'].first == 'true';
  }
  return EeePage(isForceLoadFromJni: isForceLoadFromJni);
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

Handler wcApprovePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SessionApplyPage();
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

Handler changeNetTypePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ChangeNetTypePage();
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
  return EthTxDetailPage();
});

Handler eeeTransactionDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EeeTxDetailPage();
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
