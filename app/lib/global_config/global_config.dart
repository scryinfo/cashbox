class GlobalConfig {
  static Map<String, double> maxGasLimitMap = {"eth": 30000, "ddd": 300000};
  static Map<String, double> minGasLimitMap = {"eth": 21000, "ddd": 35000};
  static Map<String, double> defaultGasLimitMap = {"eth": 21000, "ddd": 70000};
  static Map<String, double> maxGasPriceMap = {"eth": 30, "ddd": 20};
  static Map<String, double> minGasPriceMap = {"eth": 2, "ddd": 2};
  static Map<String, double> defaultGasPriceMap = {"eth": 9, "ddd": 6};

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

const DddMainNetContractAddress = "0x9F5F3CFD7a32700C93F971637407ff17b91c7342";
const DddTestNetContractAddress = "0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e";

const RatePath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
const PublicPath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
const Infura_Rpc_Path = "https://mainnet.infura.io/shJbKSyfdvONq9czbypb";
const ETHERSCAN_API_KEY = "XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1";

const Parker_Infura_RPC = "https://mainnet.infura.io/v3/8d21395d2a73485096ca061252314e78";
const Parker_Infura_WSS = "wss://mainnet.infura.io/ws/v3/8d21395d2a73485096ca061252314e78";

//  https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0x5b73ed45b55bdd7b45eadc4dcd1536a9f5506561&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//  https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0x5b73ed45b55bdd7b45eadc4dcd1536a9f5506561&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//  https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0x5b73ed45b55bdd7b45eadc4dcd1536a9f5506561&page=1&offset=5&sort=desc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//  https://api.etherscan.io/api?module=account&action=txlist&address=0x5b73ed45b55bdd7b45eadc4dcd1536a9f5506561&startblock=0&endblock=99999999&page=1&offset=5&sort=desc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1

const httpHeaders = {
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json',
  'Cookie':
      '_ga=GA1.2.676402787.1548321037; GCID=9d149c5-11cb3b3-80ad198-04b551d; _gid=GA1.2.359074521.1550799897; _gat=1; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1550106367,1550115714,1550123110,1550799897; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1550799909|1550799898; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1550799907',
  'Host': 'time.geekbang.org',
  'Origin': 'https://time.geekbang.org',
  'Referer': 'https://time.geekbang.org/',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36'
};
