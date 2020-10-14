/*
  Configuration file
  Developers can add or delete interface data for each function according to their needs.
  For example: the corresponding back-end legal currency interface can be added
**/
class VendorConfig {
  ///server config IP
  static const appServerConfigIpKey = ""; //
  static const appServerConfigIpValue = ""; //

  ///
  static const appConfigVersionKey = "";
  static const appConfigVersionValue = "";

  ///
  static const serverApkVersionKey = "";
  static const serverApkVersionValue = "";

  ///The latest version app download interface；
  static const downloadLatestVersionIpKey = "";
  static const downloadLatestVersionIpValue = "";

  ///The fiat currency key corresponding to the token
  static const rateDigitIpKey = "";
  static const rateDigitIpDefaultValue = ""; //The legal currency interface ip corresponding to the token；

  ///Trusted token version number
  static const authDigitsVersionKey = ""; //Trusted token version number key
  static const authDigitsVersionValue = ""; //Trusted token version number value

  ///List of trusted erc tokens
  static const authDigitsIpKey = ""; //List of trusted erc tokens
  static const authDigitsIpDefaultValue = ""; //List of trusted erc tokens；

  /// default token version
  static const defaultDigitsVersionKey = "";
  static const defaultDigitsVersionValue = "";

  ///The default token ip
  static const defaultDigitsIpKey = "";
  static const defaultDigitsIpDefaultValue = "";

  /// default token content
  static const defaultDigitsContentKey = "";
  static const defaultDigitsContentDefaultValue = '';

  static const scryXIpKey = "";
  static const scryXIpDefaultValue = "";

  static const publicIpKey = "";
  static const publicIpDefaultValue = "";

  /// last change time of check config
  static const lastTimeCheckConfigKey = "";
  static const lastTimeCheckConfigValue = "";

  /// init database statement
  static const initDatabaseStateKey = "";
  static const initDatabaseStateValue = false;

  static const nowDbVersionKey = "new_db_version_key";
  static const nowDbVersionValue = "1.1.0";

  static const ETHERSCAN_API_KEY = "";
  static const MAIN_NET_DDD2EEE_RECEIVE_ETH_ADDRESS = "";
  static const TEST_NET_DDD2EEE_RECEIVE_ETH_ADDRESS = "";

  static const dappOpenUrlKey = "dappOpenUrl";
  static String dappOpenUrValue = "";
}

const DddMainNetContractAddress = "";
const DddTestNetContractAddress = "";
