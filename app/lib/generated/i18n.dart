import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get about_us_title => "关于我们";
  String get add_wallet => "添加钱包";
  String get advice_pwd_format => "建议大于8位，英文、数字混合";
  String get agree_service_prefix => "我已仔细阅读并同意";
  String get app_title => "App标题";
  String get backup_mnemonic => "备份助记词";
  String get backup_mnemonic_hint_info => "助记词用于恢复钱包或者重置钱包密码，将它准确抄到纸上，切记安全保存到你知道的安全地方。";
  String get backup_wallet => "备份钱包!";
  String get cancel => "取消";
  String get chain_address_info => "链地址信息";
  String get change_another_group => "换一组";
  String get choose_multi_chain => "选择创建链";
  String get click_to_copy_address => "点击复制地址!";
  String get click_to_transfer => "点击转账";
  String get confirm => "确定";
  String get create_test_wallet => "创建测试钱包";
  String get create_wallet => "创建钱包";
  String get currency_manage => "货币管理";
  String get dapp => "Dapp";
  String get delete_wallet => "删除钱包";
  String get delete_wallet_hint => "提示：请保存好您的助记词。钱包删除后，cashbox不会再私自记录该钱包的任何信息。";
  String get eee_chain_test => "EEE_TEST";
  String get ensure_pwd => "确认密码";
  String get ensure_to_change => "确定更改";
  String get fail_to_load_data_hint => "数据加载失败,请检查网络状况，可尝试下拉刷新";
  String get failure_create_test_wallet => "测试钱包创建失败，请检查你输入的数据是否正确";
  String get failure_reset_pwd_hint => "重置密码失败，详细信息";
  String get failure_to_change_wallet => "钱包切换失败，请重新打开钱包，尝试切换";
  String get failure_to_load_data_pls_retry => "数据加载出错了，请尝试重新加载!~";
  String get import_wallet => "导入钱包";
  String get input_format_hint => "建议8-24位，英文数字混合";
  String get judge_the_difference_between_two_wallet => "注意：此测试钱包里面能使用的,都是测试链上的代币。      请区分与正式链的差别。";
  String get language_choose => "语言选择";
  String get main_title => "主标题";
  String get make_sure_service_protocol => "请确认勾选 同意服务协议与隐私条款";
  String get message_tip => "message";
  String get mine => "我的";
  String get mne_pwd_not_allow_is_null => "助记词和密码不能为空";
  String get mnemonic => "助记词";
  String get mnemonic_backup_ok => "助记词已经记好";
  String get mnemonic_info_hint => "以下是钱包的助记词，请您务必认真抄写下来并导出至安全的地方存放。\n注意：一旦丢失，无法找回。";
  String get mnemonic_is_not_null => "助记词不能为空";
  String get mnemonic_order_wrong => "验证您输入助记词不一致，建议您重新生成新钱包";
  String get mnemonic_qr_info => "这是您助记词信息生成的二维码";
  String get new_pwd => "新密码";
  String get new_pwd_format_hint => "请输入新密码，建议大于8位，英文、数字混合";
  String get no_new_version_hint => "当前已是最新版本，暂无更新";
  String get no_tx_history => "暂时没有历史交易记录";
  String get old_pwd => "旧密码";
  String get pls_ensure_eee_chain => "请确认勾选创建EEE链";
  String get pls_ensure_pwd_is_same => "请确认两次输入密码一致";
  String get pls_input => "请输入";
  String get pls_input_mnemonic => "请输入助记词";
  String get pls_input_old_pwd => "请输入旧密码";
  String get pls_input_receive_address => "请输入收款地址";
  String get pls_input_transaction_amount => "请输入转账数额";
  String get pls_input_wallet_name => "请输入钱包名";
  String get pls_input_wallet_pwd => "请输入钱包密码";
  String get pls_pwd_again => "请再次输入密码";
  String get pls_set_wallet_pwd => "请设置钱包密码";
  String get privacy_protocol_tag => "《隐私条款》";
  String get privacy_protocol_title => "隐私条款";
  String get public => "公告";
  String get pwd => "密码";
  String get pwd_is_not_same => "确认密码不一致，请重新输入";
  String get pwd_not_null => "密码不能为空";
  String get qr_backup => "二维码备份";
  String get qr_scan_unknown_error => "扫描发生未知失败，请重新尝试";
  String get receive => "收款";
  String get receive_address => "对方收款地址";
  String get recover_wallet => "恢复钱包";
  String get recover_wallet_hint => "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。";
  String get reset_pwd => "重置密码";
  String get rewrite_new_pwd_format_hint => "再次输入新密码";
  String get scan => "扫一扫";
  String get service_protocol_tag => "《服务协议》";
  String get service_protocol_title => "服务协议";
  String get some_info_is_null => "有信息为空，请补全信息";
  String get success_create_test_wallet => "测试钱包创建完成，切记注意区分钱包类型";
  String get success_in_delete_wallet => "钱包删除成功";
  String get success_reset_pwd_hint => "重置密码成功，请您保存好你的密码，丢失无法找回";
  String get success_to_copy_info => "信息已经成功拷贝!~~~";
  String get test_wallet_and_mnemonic => "测试钱包 助记词:";
  String get test_wallet_title => "测试钱包";
  String get transaction_amount => "交易数额";
  String get transaction_detail => "交易详情";
  String get transaction_history => "交易记录";
  String get transaction_timestamp => "交易时间戳";
  String get transfer => "转账";
  String get transfer_from_address => "转出地址:";
  String get transfer_to_address => "转入地址:";
  String get tx_transferring => "交易发送中";
  String get unknown_error_in_create_wallet => "钱包创建过程，出现位置错误，请重新尝试创建";
  String get unknown_error_in_reset_pwd => "重置密码出现位置错误，请重新打开尝试";
  String get unknown_error_in_scan_qr_code => "扫描发生未知失败，请重新尝试";
  String get verify_backup_mnemonic => "验证备份助记词";
  String get verify_failure_to_mnemonic => "助记词验证失败，请重新检查你输入的信息";
  String get verify_mnemonic_info => "助记词确认验证";
  String get verify_mnemonic_order => "请输入验证你保存的助记词顺序。再次提醒，程序不会保留您的隐私信息,请您务必保存好助记词";
  String get verify_wallet => "验证钱包";
  String get version_update => "版本更新";
  String get wallet_list => "钱包列表";
  String get wallet_load_error => "钱包应用加载出错了，请尝试重新打开!~";
  String get wallet_name => "钱包名";
  String get wallet_name_not_null => "钱包名不能为空";
  String get wallet_pwd => "钱包密码";
  String get wallet_transfer => "钱包转账";
  String get write_down_mnemonic => "抄下你的钱包助记词!";
  String get wrong_pwd_failure_in_delete_wallet => "密码错误，钱包删除失败";
  String get wrong_pwd_failure_in_recover_wallet_hint => "密码错误，钱包恢复失败";
}

class $ko extends S {
  const $ko();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get app_title => "App标题 ko";
  @override
  String get message_tip => "message ko";
  @override
  String get main_title => "主标题 ko";
}

class $jp extends S {
  const $jp();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get app_title => "App标题 jp";
  @override
  String get message_tip => "message jp";
  @override
  String get main_title => "主标题 jp";
}

class $en extends S {
  const $en();
}

class $zh extends S {
  const $zh();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get import_wallet => "导入钱包";
  @override
  String get cancel => "取消";
  @override
  String get judge_the_difference_between_two_wallet => "注意：此测试钱包里面能使用的,都是测试链上的代币。      请区分与正式链的差别。";
  @override
  String get failure_reset_pwd_hint => "重置密码失败，详细信息";
  @override
  String get unknown_error_in_reset_pwd => "重置密码出现位置错误，请重新打开尝试";
  @override
  String get pls_set_wallet_pwd => "请设置钱包密码";
  @override
  String get choose_multi_chain => "选择创建链";
  @override
  String get currency_manage => "货币管理";
  @override
  String get qr_scan_unknown_error => "扫描发生未知失败，请重新尝试";
  @override
  String get pls_input_transaction_amount => "请输入转账数额";
  @override
  String get qr_backup => "二维码备份";
  @override
  String get verify_backup_mnemonic => "验证备份助记词";
  @override
  String get wallet_transfer => "钱包转账";
  @override
  String get wallet_list => "钱包列表";
  @override
  String get dapp => "Dapp";
  @override
  String get success_create_test_wallet => "测试钱包创建完成，切记注意区分钱包类型";
  @override
  String get delete_wallet_hint => "提示：请保存好您的助记词。钱包删除后，cashbox不会再私自记录该钱包的任何信息。";
  @override
  String get success_in_delete_wallet => "钱包删除成功";
  @override
  String get click_to_transfer => "点击转账";
  @override
  String get new_pwd => "新密码";
  @override
  String get privacy_protocol_title => "隐私条款";
  @override
  String get verify_failure_to_mnemonic => "助记词验证失败，请重新检查你输入的信息";
  @override
  String get create_wallet => "创建钱包";
  @override
  String get service_protocol_tag => "《服务协议》";
  @override
  String get pls_input_mnemonic => "请输入助记词";
  @override
  String get wallet_name => "钱包名";
  @override
  String get pwd_not_null => "密码不能为空";
  @override
  String get advice_pwd_format => "建议大于8位，英文、数字混合";
  @override
  String get input_format_hint => "建议8-24位，英文数字混合";
  @override
  String get click_to_copy_address => "点击复制地址!";
  @override
  String get tx_transferring => "交易发送中";
  @override
  String get test_wallet_title => "测试钱包";
  @override
  String get mnemonic_qr_info => "这是您助记词信息生成的二维码";
  @override
  String get pwd => "密码";
  @override
  String get wallet_load_error => "钱包应用加载出错了，请尝试重新打开!~";
  @override
  String get mnemonic_info_hint => "以下是钱包的助记词，请您务必认真抄写下来并导出至安全的地方存放。\n注意：一旦丢失，无法找回。";
  @override
  String get transaction_amount => "交易数额";
  @override
  String get recover_wallet => "恢复钱包";
  @override
  String get scan => "扫一扫";
  @override
  String get eee_chain_test => "EEE_TEST";
  @override
  String get no_tx_history => "暂时没有历史交易记录";
  @override
  String get failure_to_load_data_pls_retry => "数据加载出错了，请尝试重新加载!~";
  @override
  String get agree_service_prefix => "我已仔细阅读并同意";
  @override
  String get verify_wallet => "验证钱包";
  @override
  String get failure_create_test_wallet => "测试钱包创建失败，请检查你输入的数据是否正确";
  @override
  String get receive_address => "对方收款地址";
  @override
  String get mine => "我的";
  @override
  String get receive => "收款";
  @override
  String get backup_mnemonic_hint_info => "助记词用于恢复钱包或者重置钱包密码，将它准确抄到纸上，切记安全保存到你知道的安全地方。";
  @override
  String get app_title => "App标题";
  @override
  String get backup_wallet => "备份钱包!";
  @override
  String get pls_input_wallet_pwd => "请输入钱包密码";
  @override
  String get pls_ensure_pwd_is_same => "请确认两次输入密码一致";
  @override
  String get confirm => "确定";
  @override
  String get wallet_name_not_null => "钱包名不能为空";
  @override
  String get verify_mnemonic_order => "请输入验证你保存的助记词顺序。再次提醒，程序不会保留您的隐私信息,请您务必保存好助记词";
  @override
  String get main_title => "主标题";
  @override
  String get failure_to_change_wallet => "钱包切换失败，请重新打开钱包，尝试切换";
  @override
  String get some_info_is_null => "有信息为空，请补全信息";
  @override
  String get wrong_pwd_failure_in_delete_wallet => "密码错误，钱包删除失败";
  @override
  String get wrong_pwd_failure_in_recover_wallet_hint => "密码错误，钱包恢复失败";
  @override
  String get chain_address_info => "链地址信息";
  @override
  String get delete_wallet => "删除钱包";
  @override
  String get mnemonic_order_wrong => "验证您输入助记词不一致，建议您重新生成新钱包";
  @override
  String get about_us_title => "关于我们";
  @override
  String get message_tip => "message";
  @override
  String get mnemonic => "助记词";
  @override
  String get fail_to_load_data_hint => "数据加载失败,请检查网络状况，可尝试下拉刷新";
  @override
  String get test_wallet_and_mnemonic => "测试钱包 助记词:";
  @override
  String get success_to_copy_info => "信息已经成功拷贝!~~~";
  @override
  String get pwd_is_not_same => "确认密码不一致，请重新输入";
  @override
  String get transaction_detail => "交易详情";
  @override
  String get pls_input_old_pwd => "请输入旧密码";
  @override
  String get verify_mnemonic_info => "助记词确认验证";
  @override
  String get transfer => "转账";
  @override
  String get rewrite_new_pwd_format_hint => "再次输入新密码";
  @override
  String get language_choose => "语言选择";
  @override
  String get ensure_pwd => "确认密码";
  @override
  String get pls_input_wallet_name => "请输入钱包名";
  @override
  String get create_test_wallet => "创建测试钱包";
  @override
  String get backup_mnemonic => "备份助记词";
  @override
  String get unknown_error_in_create_wallet => "钱包创建过程，出现位置错误，请重新尝试创建";
  @override
  String get change_another_group => "换一组";
  @override
  String get recover_wallet_hint => "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。";
  @override
  String get privacy_protocol_tag => "《隐私条款》";
  @override
  String get pls_input_receive_address => "请输入收款地址";
  @override
  String get version_update => "版本更新";
  @override
  String get public => "公告";
  @override
  String get pls_ensure_eee_chain => "请确认勾选创建EEE链";
  @override
  String get new_pwd_format_hint => "请输入新密码，建议大于8位，英文、数字混合";
  @override
  String get mnemonic_is_not_null => "助记词不能为空";
  @override
  String get add_wallet => "添加钱包";
  @override
  String get mnemonic_backup_ok => "助记词已经记好";
  @override
  String get no_new_version_hint => "当前已是最新版本，暂无更新";
  @override
  String get mne_pwd_not_allow_is_null => "助记词和密码不能为空";
  @override
  String get transaction_history => "交易记录";
  @override
  String get pls_pwd_again => "请再次输入密码";
  @override
  String get reset_pwd => "重置密码";
  @override
  String get old_pwd => "旧密码";
  @override
  String get ensure_to_change => "确定更改";
  @override
  String get service_protocol_title => "服务协议";
  @override
  String get transaction_timestamp => "交易时间戳";
  @override
  String get wallet_pwd => "钱包密码";
  @override
  String get transfer_to_address => "转入地址:";
  @override
  String get make_sure_service_protocol => "请确认勾选 同意服务协议与隐私条款";
  @override
  String get transfer_from_address => "转出地址:";
  @override
  String get pls_input => "请输入";
  @override
  String get success_reset_pwd_hint => "重置密码成功，请您保存好你的密码，丢失无法找回";
  @override
  String get unknown_error_in_scan_qr_code => "扫描发生未知失败，请重新尝试";
  @override
  String get write_down_mnemonic => "抄下你的钱包助记词!";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("ko", ""),
      Locale("jp", ""),
      Locale("en", ""),
      Locale("zh", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "ko":
          S.current = const $ko();
          return SynchronousFuture<S>(S.current);
        case "jp":
          S.current = const $jp();
          return SynchronousFuture<S>(S.current);
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh":
          S.current = const $zh();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
