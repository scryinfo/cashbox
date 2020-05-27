/*
*     1 ETH = 1e9gwei (10的九次方) = 1e18 wei
* */

import 'dart:ui';

import 'package:app/model/chain.dart';

class GlobalConfig {
  static const EthGasLimitKey = "eth";
  static const Erc20GasLimitKey = "eth";
  static const EthGasPriceKey = "eth";
  static const Erc20GasPriceKey = "eth";
  static Map<String, double> maxGasLimitMap = {EthGasLimitKey: 30000, Erc20GasLimitKey: 300000}; //unit: gwei
  static Map<String, double> minGasLimitMap = {EthGasLimitKey: 21000, Erc20GasLimitKey: 35000};
  static Map<String, double> defaultGasLimitMap = {EthGasLimitKey: 21000, Erc20GasLimitKey: 70000};
  static Map<String, double> maxGasPriceMap = {EthGasPriceKey: 30, Erc20GasPriceKey: 20};
  static Map<String, double> minGasPriceMap = {EthGasPriceKey: 2, Erc20GasPriceKey: 2};
  static Map<String, double> defaultGasPriceMap = {EthGasPriceKey: 9, Erc20GasPriceKey: 6};

  static String savedLocaleKey = "savedLocaleKey"; //默认语言中文；
  static String defaultLocaleValue = "zh"; //默认语言中文；
  static String zhLocale = "zh"; //
  static String enLocale = "en_US"; //
  static List<String> globalLanguageList = [zhLocale, enLocale];
  static Map<String, String> globalLanguageMap = {GlobalConfig.zhLocale: "中文", GlobalConfig.enLocale: "English"};

  //static String ipAddress = "ws://47.108.146.67:9933";
  static String ipAddress = "ws://40.73.75.224:9933";
  static String serveVersionIp = "ws://40.73.75.224:9933"; //todo 待定

  static String isInitAppConfig = "is_init_app_config_key";
  static String rateDigitIpKey = "rate_digit_ip_key";
  static String rateDigitIpDefaultValue = "http://40.73.35.55:8080/inner_api/market/pricerate";
  static String authDigitsVersionKey = "auth_digit_list_version_key";
  static String authDigitsIpKey = "auth_digit_list_key";
  static String authDigitsIpDefaultValue = "http://40.73.35.55:8080/inner_api/token/erc20/authlist";
  static String defaultDigitsKey = "default_digit_list_key";
  static String defaultDigitsDefaultValue = "http://40.73.35.55:8080/inner_api/token/erc20/defaultlist";
  static String scryXIpKey = "scry_x_key";
  static String scryXIpDefaultValue = "ws://40.73.75.224:9933";
  static String cashboxVersionKey = "cashbox_version_key";
  static String cashboxVersionDefaultValue = "1.0.0";
  static String cashboxDownloadIpKey = "cashbox_download_ip_key";
  static String cashboxDownloadIpDefaultValue = ""; //todo
  static String publicIpKey = "public__ip_key";
  static String publicIpDefaultValue = "https://cashbox.scry.info/public";

  static Locale loadLocale(String locale) {
    switch (locale) {
      case 'zh':
        return Locale('zh', '');
      case 'en':
        return Locale('en', '');
      default:
        return Locale('zh', '');
    }
  }

  //保存dapp 合约地址信息
  static String diamondCaFileName = "contract_address.txt";

  static double getMaxGasLimit(String digitName) {
    return maxGasLimitMap[digitName];
  }

  static double getMinGasLimit(String digitName) {
    return minGasLimitMap[digitName];
  }

  static double getDefaultGasLimit(String digitName) {
    return defaultGasLimitMap[digitName];
  }

  static double getMaxGasPrice(String digitName) {
    return maxGasPriceMap[digitName];
  }

  static double getMinGasPrice(String digitName) {
    return minGasPriceMap[digitName];
  }

  static double getDefaultGasPrice(String digitName) {
    return defaultGasPriceMap[digitName];
  }
}

const Eth_Unit = 1000000000000000000; // 18位
const DddMainNetContractAddress = "0x9F5F3CFD7a32700C93F971637407ff17b91c7342";
const DddTestNetContractAddress = "0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e";

const RatePath = "http://40.73.35.55:8080/inner_api/market/pricerate";
const PublicPath = "https://cashbox.scry.info/public";
const ETHERSCAN_API_KEY = "XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1";

const Infura_Rpc_Path = "https://mainnet.infura.io/shJbKSyfdvONq9czbypb";
const Parker_Infura_RPC = "https://mainnet.infura.io/v3/8d21395d2a73485096ca061252314e78";
const Parker_Infura_WSS = "wss://mainnet.infura.io/ws/v3/8d21395d2a73485096ca061252314e78";

const httpHeaders = {
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json',
  'Cookie': '',
  'Host': '',
  'Origin': '',
  'Referer': '',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36'
};
