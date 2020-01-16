class GlobalConfig {
  static Map<String, double> maxGasLimitMap = {"eth": 30000, "ddd": 300000};
  static Map<String, double> minGasLimitMap = {"eth": 21000, "ddd": 35000};
  static Map<String, double> defaultGasLimitMap = {"eth": 21000, "ddd": 70000};
  static Map<String, double> maxGasPriceMap = {"eth": 30, "ddd": 20};
  static Map<String, double> minGasPriceMap = {"eth": 2, "ddd": 2};
  static Map<String, double> defaultGasPriceMap = {"eth": 9, "ddd": 6};

  static const DddMainNetContractAddress = "0x9F5F3CFD7a32700C93F971637407ff17b91c7342";
  static const DddTestNetContractAddress = "0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e";

  static const RatePath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
  static const PublicPath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
  static const Infura_Rpc_Path = "https://mainnet.infura.io/shJbKSyfdvONq9czbypb";



  static double getMaxGasLimit(String digitName) {
    return maxGasLimitMap[digitName.toLowerCase()];
  }

  static double getMinGasLimit(String digitName) {
    return minGasLimitMap[digitName.toLowerCase()];
  }

  static double getDefaultGasLimit(String digitName) {
    return defaultGasLimitMap[digitName.toLowerCase()];
  }

  static double getMaxGasPrice(String digitName) {
    return maxGasPriceMap[digitName.toLowerCase()];
  }

  static double getMinGasPrice(String digitName) {
    return minGasPriceMap[digitName.toLowerCase()];
  }

  static double getDefaultGasPrice(String digitName) {
    return defaultGasPriceMap[digitName.toLowerCase()];
  }
}
