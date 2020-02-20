class GlobalConfig {
  static const EthGasLimitKey="eth";
  static const Erc20GasLimitKey="eth";
  static const EthGasPriceKey="eth";
  static const Erc20GasPriceKey="eth";
  static Map<String, double> maxGasLimitMap = {EthGasLimitKey: 30000, Erc20GasLimitKey: 300000};
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
}

const Eth_Unit = 1000000000000000000; // 18位
const DddMainNetContractAddress = "0x9F5F3CFD7a32700C93F971637407ff17b91c7342";
const DddTestNetContractAddress = "0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e";

const RatePath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
const PublicPath = "https://cashbox.scry.info/cashbox/api/market/pricerate";
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
  'Cookie':
      '_ga=GA1.2.676402787.1548321037; GCID=9d149c5-11cb3b3-80ad198-04b551d; _gid=GA1.2.359074521.1550799897; _gat=1; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1550106367,1550115714,1550123110,1550799897; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1550799909|1550799898; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1550799907',
  'Host': 'time.geekbang.org',
  'Origin': 'https://time.geekbang.org',
  'Referer': 'https://time.geekbang.org/',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36'
};

const Eth_Balance = "http://api-cn.etherscan.com/api?module=account&action=balance&address=";
//http://api-cn.etherscan.com/api?module=account&action=balance&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&tag=latest&apikey=YourApiKeyTokens
String assembleEthBalanceUrl(String address) {
  return Eth_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
}

const Erc20_Balance = "http://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=0x57d90b64a1a57749b0f932f1a3395792e12e7055&address=0xe04f27eb70e025b78871a2ad7eabe85e61212761&tag=latest&apikey=YourApiKeyToken
String assembleErc20BalanceUrl(String address,{String contractAddress=DddMainNetContractAddress}) {
  return Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
}

const Eth_Tx_List = "http://api-cn.etherscan.com/api?module=account&action=txlist&address=";
//http://api-cn.etherscan.com/api?module=account&action=txlist&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=YourApiKeyToken
String assembleEthTxListUrl(String address) {
  return Eth_Tx_List + address + "&startblock=0&endblock=99999999&page=1&offset=20&sort=asc&apikey=" + ETHERSCAN_API_KEY;
}

const Erc20_Tx_List = "http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=0x9f8f72aa9304c8b593d555f12ef6589cc3a579a2&address=0x4e83362442b8d1bec281594cea3050c8eb01311c&page=1&offset=100&sort=asc&apikey=YourApiKeyToken
String assembleErc20TxListUrl(String address,{String contractAddress=DddMainNetContractAddress}) {
  //http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0xa4512ca7618d8d12a30C28979153aB09809ED7fD&page=1&offset=100&sort=asc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
  return Erc20_Tx_List + contractAddress + "&address=" + address + "&page=1&offset=100&sort=asc&apikey=" + ETHERSCAN_API_KEY;
}
