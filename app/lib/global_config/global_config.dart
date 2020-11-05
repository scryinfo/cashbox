/*
*     1 ETH = 1e9gwei (10 to the ninth power) = 1e18 wei
* */

import 'package:package_info/package_info.dart';

class GlobalConfig {
  ///Application language configuration
  static const savedLocaleKey = "savedLocaleKey"; //Default language Chinese；
  static const defaultLocaleValue = "zh"; //Default language Chinese；
  static Map<String, String> globalLanguageMap = {"zh": "Chinese", "en": "English"};

  ///The following configuration information, in the form of key-value, uses a local file to do persistent storage of information
  static const isInitAppConfig = "is_init_app_config_key"; //Whether the app configuration information is initialized

  static const currencyKey = "currency_key"; //Selected fiat currency usd || cny etc.
  static String currencyDefaultValue = "USD";

  ///dapp saves contract address information
  static const dappCaKey1 = "dapp_ca_key_1";

  ///eth related gas fee configuration
  static const EthGasLimitKey = "eth";
  static const Erc20GasLimitKey = "erc20";
  static const EthGasPriceKey = "eth";
  static const Erc20GasPriceKey = "erc20";
  static Map<String, double> maxGasLimitMap = {EthGasLimitKey: 30000, Erc20GasLimitKey: 300000}; //unit: gwei
  static Map<String, double> minGasLimitMap = {EthGasLimitKey: 21000, Erc20GasLimitKey: 35000};
  static Map<String, double> defaultGasLimitMap = {EthGasLimitKey: 21000, Erc20GasLimitKey: 70000};
  static Map<String, double> maxGasPriceMap = {EthGasPriceKey: 30, Erc20GasPriceKey: 20};
  static Map<String, double> minGasPriceMap = {EthGasPriceKey: 2, Erc20GasPriceKey: 2};
  static Map<String, double> defaultGasPriceMap = {EthGasPriceKey: 9, Erc20GasPriceKey: 6};

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

  static String dbVersion1_0_0 = "1.0.0"; //db version 1.0.0
  static String dbVersion1_1_0 = "1.1.0"; //db version 1.1.0

  static Map<String, String> appVersion2DbVersionMap = {
    "2.0.0": dbVersion1_0_0,
    "2.1.0": dbVersion1_0_0,
    "2.1.1": dbVersion1_0_0,
    "2.2.0": dbVersion1_1_0,
  };

  static int versionValueNumberCount = 3; //eg : the count of efficient number
}

const Eth_Unit = 1000000000000000000; // 18 digits
const Eee_Unit = 1000000000000000; // 15 digits

const SystemSymbol = "System";
const AccountSymbol = "Account";

const TokenXSymbol = "Tokenx";
const BalanceSymbol = "Balances";

const EeeSymbol = "Eee";

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
