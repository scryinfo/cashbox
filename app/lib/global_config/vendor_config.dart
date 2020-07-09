/*
  Configuration file
  Developers can add or delete interface data for each function according to their needs.
  For example: the corresponding back-end legal currency interface can be added
**/
class VendorConfig {
  ///Version check interface；
  static const versionCheckIpKey = "";
  static const versionCheckIpValue = "";

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

  /// app server config ip
  static const appServerConfigKey = "";
  static const appServerConfigValue = " ";

  static const ETHERSCAN_API_KEY = "";
}

const DddMainNetContractAddress = "";
const DddTestNetContractAddress = "";
