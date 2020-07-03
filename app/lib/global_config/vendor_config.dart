/*
  Configuration file
  Developers can add or delete interface data for each function according to their needs.
  For example: the corresponding back-end legal currency interface can be added
**/
class VendorConfig {

  static const versionCheckIp = ""; //Version check interface；
  static const latestVersionIp = ""; //The latest version app download interface；

  static const rateDigitIpKey = ""; //The fiat currency key corresponding to the token
  static const rateDigitIpDefaultValue = ""; //The legal currency interface ip corresponding to the token；

  static const authDigitsVersionKey = ""; //Trusted token version number key
  static const authDigitsVersionValue = ""; //Trusted token version number value

  static const authDigitsIpKey = ""; //List of trusted erc tokens
  static const authDigitsIpDefaultValue = ""; //List of trusted erc tokens；

  static const defaultDigitsKey = ""; //The default token ip corresponds to the key；
  static const defaultDigitsDefaultValue = ""; //The value corresponding to the default token ip；

  static const scryXIpKey = ""; //Default language Chinese；
  static const scryXIpDefaultValue = "";

  static const cashboxDownloadIpKey = ""; //
  static const cashboxDownloadIpDefaultValue = ""; //

  static const publicIpKey = "";
  static const publicIpDefaultValue = "";

  static const ETHERSCAN_API_KEY = "";
}

const DddMainNetContractAddress = "";
const DddTestNetContractAddress = "";
