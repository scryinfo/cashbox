/*
*     1 ETH = 1e9gwei (10的九次方) = 1e18 wei
* */

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

const Eth_MainNet_Balance = "https://api-cn.etherscan.com/api?module=account&action=balance&address=";
const Eth_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=balance&address=";
//http://api-cn.etherscan.com/api?module=account&action=balance&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=account&action=balance&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleEthBalanceUrl(String address, {ChainType chainType = ChainType.ETH}) {
  if (chainType == ChainType.ETH_TEST) {
    print("===================>" + Eth_MainNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_MainNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    print("===================>" + Eth_TestNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_TestNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

const Erc20_Balance = "https://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=";
const Erc20_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0xe04f27eb70e025b78871a2ad7eabe85e61212761&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleErc20BalanceUrl(String address, {String contractAddress, ChainType chainType = ChainType.ETH}) {
  if (chainType == ChainType.ETH_TEST) {
    print("===================>" + Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    print("===================>" + Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

const Eth_Tx_List = "https://api-cn.etherscan.com/api?module=account&action=txlist&address=";
const Eth_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=";
//http://api-cn.etherscan.com/api?module=account&action=txlist&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleEthTxListUrl(String address,
    {String contractAddress,
    ChainType chainType = ChainType.ETH,
    String startBlock = "0",
    String endBlock = "99999999",
    String page = "1",
    String offset = "20"}) {
  if (chainType == ChainType.ETH_TEST) {
    return Eth_TestNet_Tx_List +
        address +
        "&startblock=" +
        startBlock +
        "&endblock=" +
        endBlock +
        "&page=" +
        page +
        "&offset=" +
        offset.toString() +
        "&sort=desc&apikey=" +
        ETHERSCAN_API_KEY;
  } else {
    return Eth_Tx_List +
        address +
        "&startblock=" +
        startBlock +
        "&endblock=" +
        endBlock +
        "&page=" +
        page.toString() +
        "&offset=" +
        offset.toString() +
        "&sort=desc&apikey=" +
        ETHERSCAN_API_KEY;
  }
}

const Erc20_Tx_List = "http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=";
const Erc20_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=tokentx&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&page=1&offset=100&sort=asc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=account&action=tokentx&contractaddress=0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&page=1&offset=100&sort=asc&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleErc20TxListUrl(String address, {ChainType chainType, String contractAddress, String page = "1", String offset = "20"}) {
  if (chainType.toString() == ChainType.ETH_TEST.toString()) {
    return Erc20_TestNet_Tx_List +
        contractAddress +
        "&address=" +
        address +
        "&page=" +
        page.toString() +
        "&offset=" +
        offset.toString() +
        "&sort=desc&apikey=" +
        ETHERSCAN_API_KEY.toString();
  } else {
    return Erc20_Tx_List +
        contractAddress +
        "&address=" +
        address +
        "&page=" +
        page.toString() +
        "&offset=" +
        offset.toString() +
        "&sort=desc&apikey=" +
        ETHERSCAN_API_KEY;
  }
}

const Eth_Tx_Account = "http://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=";
const Eth_TestNet_Tx_Account = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=";
//http://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=0x2910543af39aba0cd09dbb2d50200b3e800a63d2&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleTxAccount(String address, ChainType chainType) {
  if (chainType == ChainType.ETH) {
    return Eth_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    return Eth_TestNet_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

const Eth_Send_RawTx = "https://api.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";
const Eth_TestNet_Send_RawTx = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";
//https://api-cn.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex???=&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
//https://api-ropsten.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=???&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1
String assembleSendRawTx(ChainType chainType, String hexRawTx, {String apiKey = ETHERSCAN_API_KEY}) {
  if (chainType == ChainType.ETH_TEST) {
    return Eth_Send_RawTx + hexRawTx + "&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1";
  } else {
    return Eth_TestNet_Send_RawTx + hexRawTx + "&apikey=XGB9RHEF6XKHIB37G5S33CWFK89XQJ5EU1";
  }
}
//0xf8b940850165a0bc008301117094aa638fca332190b63be1605baefde1df0b3b031e80b853a9059cbb000000000000000000000000c0c4824527ffb27a51034cea1e37840ed69a5f1e000000000000000000000000000000000000000000008d3e16970bd7637c00007468697320697320616464206d73672aa0daa7efa85dedd64fb1a5a244524cf9a90f1004da24a319b7b34edea44b2f560fa011d391a96f65ce811627e01298bb81543490857ce1fe453ed0424111f1046f3c
//{
//jsonrpc: "2.0",
//result: "0x1019fff289b9880fc6ef65a65658f43fa3200613e360c209757f4cb2afedf77f",
//id: 1
//}