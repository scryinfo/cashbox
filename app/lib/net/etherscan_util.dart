import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'net_util.dart';

const Eth_Tx_Account = "http://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=";
const Eth_TestNet_Tx_Account = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=";
//http://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=0x2910543af39aba0cd09dbb2d50200b3e800a63d2&tag=latest&apikey=
//https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=
String assembleTxAccount(String address, ChainType chainType) {
  if (chainType == ChainType.ETH) {
    print("assembleTxAccount url===>" + Eth_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    print("assembleTxAccount url===>" + Eth_TestNet_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_TestNet_Tx_Account + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

//nonce === txAccount
Future<String> loadTxAccount(String address, ChainType chainType) async {
  try {
    var res = await request(assembleTxAccount(address, chainType));
    print("loadNonce res=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      //说明由于 infura||etherscan 目前接口返回的是 如:0x085f这种格式。需处理掉开头0x。 后转十六进制 成 十进制
      if (res["result"] != null && (res["result"].toString().startsWith("0x") || res["result"].toString().startsWith("0X"))) {
        return Utils.hexToInt(res["result"].toString().substring("0x".length)).toString();
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print("loadTxAccount error is ===>" + e.toString());
    return null;
  }
}

const Eth_MainNet_Balance = "https://api-cn.etherscan.com/api?module=account&action=balance&address=";
const Eth_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=balance&address=";
//http://api-cn.etherscan.com/api?module=account&action=balance&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&tag=latest&apikey=
//https://api-ropsten.etherscan.io/api?module=account&action=balance&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=
String assembleEthBalanceUrl(String address, {ChainType chainType = ChainType.ETH}) {
  if (chainType == ChainType.ETH_TEST) {
    print("===================>" + Eth_TestNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_TestNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    print("===================>" + Eth_MainNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Eth_MainNet_Balance + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

//返回根据 1、Eth_Unit数量级，转换后的格式
//        2、balance只保留小数点后4位
Future<String> loadEthBalance(String address, ChainType chainType) async {
  try {
    var res = await request(assembleEthBalanceUrl(address, chainType: chainType));
    print("loadEthBalance res=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      print("Eth_Balance res.result.=====================>" + (int.parse(res["result"]) / Eth_Unit).toString());
      return (int.parse(res["result"]) / Eth_Unit).toStringAsFixed(4);
    }
  } catch (e) {
    print("loadEthBalance error================>" + e.toString());
    return null;
  }
  return null;
}

const Erc20_Balance = "https://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=";
const Erc20_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0xe04f27eb70e025b78871a2ad7eabe85e61212761&tag=latest&apikey=
//https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&tag=latest&apikey=
//https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e&address=0xc0c4824527ffb27a51034cea1e37840ed69a5f1e&tag=latest&apikey=
String assembleErc20BalanceUrl(String address, String contractAddress, ChainType chainType) {
  if (chainType == ChainType.ETH_TEST) {
    print("===================>" + Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  } else {
    print("===================>" + Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY);
    return Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + ETHERSCAN_API_KEY;
  }
}

//返回根据 1、Utils.mathPow(10, decimal)数量级，转换后的格式
//        2、balance只保留小数点后 4位
Future<String> loadErc20Balance(String ethAddress, String contractAddress, ChainType chainType, {int decimal = 18}) async {
  try {
    var res = await request(assembleErc20BalanceUrl(ethAddress, contractAddress, chainType));
    print("Erc20_Balance=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      print("Erc20_Balance res.result=====================>" + res["result"].toString());
      String balance = ((BigInt.parse(res["result"])) / Utils.mathPow(10, decimal)).toStringAsFixed(4);
      return balance;
    }
  } catch (e) {
    print("loadErc20Balance error================>" + e.toString());
    return null;
  }
  return null;
}

const Eth_Tx_List = "https://api-cn.etherscan.com/api?module=account&action=txlist&address=";
const Eth_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=";
//http://api-cn.etherscan.com/api?module=account&action=txlist&address=0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=
//https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=
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

Future<List<EthTransactionModel>> loadEthTxHistory(BuildContext context, String address, ChainType chainType, {String offset}) async {
  List<EthTransactionModel> modelArray = [];
  try {
    var res = await request(assembleEthTxListUrl(address, offset: offset, chainType: chainType));
    print("loadEthTxHistory=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      for (var i = 0; i < res["result"].length; i++) {
        var ethTxModel = new EthTransactionModel();
        ethTxModel
          ..blockNumber = res["result"][i]["blockNumber"]
          ..hash = res["result"][i]["hash"]
          ..nonce = res["result"][i]["nonce"]
          ..blockHash = res["result"][i]["blockHash"]
          ..transactionIndex = res["result"][i]["transactionIndex"]
          ..from = res["result"][i]["from"]
          ..to = res["result"][i]["to"]
          ..gas = res["result"][i]["gas"]
          ..gasPrice = res["result"][i]["gasPrice"]
          ..isError = res["result"][i]["isError"]
          ..txreceipt_status = res["result"][i]["txreceipt_status"]
          ..contractAddress = res["result"][i]["contractAddress"]
          ..cumulativeGasUsed = res["result"][i]["cumulativeGasUsed"]
          ..gasUsed = res["result"][i]["gasUsed"]
          ..confirmations = res["result"][i]["confirmations"];
        try {
          Map map = await Wallets.instance.decodeAdditionData(res["result"][i]["input"].toString());
          if (map != null && (map["status"] == 200)) {
            ethTxModel.input = map["inputInfo"].toString();
          }
        } catch (e) {
          ethTxModel.input = "";
          print("etherScanUtil happen error===>" + e.toString());
        }
        ethTxModel.timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(res["result"][i]["timeStamp"]) * 1000).toString();
        if (res["result"][i]["from"].trim().toLowerCase() == address.trim().toLowerCase()) {
          ethTxModel.value = "-" + (int.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        } else {
          ethTxModel.value = "+" + (int.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        }
        if (res["result"][i]["isError"] == "0") {
          ethTxModel.isError = translate('tx_success').toString();
        } else {
          ethTxModel.isError = translate('tx_failure').toString();
        }
        modelArray.add(ethTxModel);
      }
      return modelArray;
    } else {
      return [];
    }
  } catch (e) {
    print("error is ====>" + e);
    return [];
  }
}

const Erc20_Tx_List = "http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=";
const Erc20_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=tokentx&contractaddress=";
//http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=0x9F5F3CFD7a32700C93F971637407ff17b91c7342&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&page=1&offset=100&sort=asc&apikey=
//https://api-ropsten.etherscan.io/api?module=account&action=tokentx&contractaddress=0xaa638fcA332190b63Be1605bAeFDE1df0b3b031e&address=0x412cf1c28a02ea8136c691e498ff97ca4ab43ae4&page=1&offset=100&sort=asc&apikey=
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

Future<List<EthTransactionModel>> loadErc20TxHistory(BuildContext context, String address, String contractAddress, ChainType chainType,
    {String offset}) async {
  List<EthTransactionModel> modelArray = [];
  try {
    var res = await request(assembleErc20TxListUrl(address, contractAddress: contractAddress, chainType: chainType, offset: offset));
    if (res != null && (res as Map).containsKey("result")) {
      for (var i = 0; i < res["result"].length; i++) {
        var ethTxModel = new EthTransactionModel();
        ethTxModel
          ..blockNumber = res["result"][i]["blockNumber"]
          ..hash = res["result"][i]["hash"]
          ..nonce = res["result"][i]["nonce"]
          ..blockHash = res["result"][i]["blockHash"]
          ..transactionIndex = res["result"][i]["transactionIndex"]
          ..from = res["result"][i]["from"]
          ..to = res["result"][i]["to"]
          ..gas = res["result"][i]["gas"]
          ..gasPrice = res["result"][i]["gasPrice"]
          ..txreceipt_status = res["result"][i]["txreceipt_status"]
          ..input = res["result"][i]["input"]
          ..contractAddress = res["result"][i]["contractAddress"]
          ..cumulativeGasUsed = res["result"][i]["cumulativeGasUsed"]
          ..gasUsed = res["result"][i]["gasUsed"]
          ..confirmations = res["result"][i]["confirmations"];
        ethTxModel.timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(res["result"][i]["timeStamp"]) * 1000).toString();
        if (res["result"][i]["from"].trim().toLowerCase() == address.trim().toLowerCase()) {
          ethTxModel.value = "-" + (double.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        } else {
          ethTxModel.value = "+" + (double.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        }
        // ..isError = res["result"][i]["isError"]
        // 当前接口，erc20代币拿到的都会是交易成功的记录
        ethTxModel.isError = translate('tx_success').toString();
        modelArray.add(ethTxModel);
      }
    }
    return modelArray;
  } catch (e) {
    print("error is ====>" + e);
    return [];
  }
}

const Eth_Send_RawTx = "https://api.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";
const Eth_TestNet_Send_RawTx = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";
//https://api-cn.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex???=&apikey=
//https://api-ropsten.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=???&apikey=
String assembleSendRawTx(ChainType chainType, String hexRawTx, {String apiKey = ETHERSCAN_API_KEY}) {
  if (chainType == ChainType.ETH_TEST) {
    print("url===>" + Eth_TestNet_Send_RawTx + hexRawTx);
    return Eth_TestNet_Send_RawTx + hexRawTx + "&apikey=" + ETHERSCAN_API_KEY.toString();
  } else {
    print("url===>" + Eth_Send_RawTx + hexRawTx);
    return Eth_Send_RawTx + hexRawTx + "&apikey=" + ETHERSCAN_API_KEY.toString();
  }
}

Future<String> sendRawTx(ChainType chainType, String rawTx) async {
  try {
    var res = await request(assembleSendRawTx(chainType, rawTx));
    print("sendRawTx res==>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      return res["result"];
    }
    return "";
  } catch (e) {
    print("sendRawTx error is ====>" + e);
    return "";
  }
}
