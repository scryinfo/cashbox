import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'net_util.dart';

const etherscanApiKey = VendorConfig.ETHERSCAN_API_KEY; //todo change it Replace yourself with the apikey applied in etherscan

const Eth_Tx_Account = "http://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=";
const Eth_TestNet_Tx_Account = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=";

String assembleTxAccount(String address, ChainType chainType, {String apiKey = etherscanApiKey}) {
  if (chainType == ChainType.ETH) {
    return Eth_Tx_Account + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Eth_TestNet_Tx_Account + address + "&tag=latest&apikey=" + apiKey;
  }
}

//nonce === txAccount currently uses infura||etherscan
Future<String> loadTxAccount(String address, ChainType chainType) async {
  try {
    var res = await request(assembleTxAccount(address, chainType));
    if (res != null && (res as Map).containsKey("result")) {
      //Note that due to infura||etherscan, the interface currently returns a format like 0x085f. Need to deal with the beginning 0x. Back to Hexadecimal to Decimal
      if (res["result"] != null && (res["result"].toString().startsWith("0x") || res["result"].toString().startsWith("0X"))) {
        return Utils.hexToInt(res["result"].toString().substring("0x".length)).toString();
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

const Eth_MainNet_Balance = "https://api-cn.etherscan.com/api?module=account&action=balance&address=";
const Eth_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=balance&address=";

String assembleEthBalanceUrl(String address, {ChainType chainType = ChainType.ETH, String apiKey = etherscanApiKey}) {
  if (chainType == ChainType.ETH_TEST) {
    return Eth_TestNet_Balance + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Eth_MainNet_Balance + address + "&tag=latest&apikey=" + apiKey;
  }
}

//According to return  1. Eth_Unit magnitude, converted format
//                     2. balance only keeps 4 decimal places
Future<String> loadEthBalance(String address, ChainType chainType) async {
  try {
    var res = await request(assembleEthBalanceUrl(address, chainType: chainType));
    if (res != null && (res as Map).containsKey("result")) {
      return (int.parse(res["result"]) / Eth_Unit).toStringAsFixed(4);
    }
  } catch (e) {
    return null;
  }
  return null;
}

const Erc20_Balance = "https://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=";
const Erc20_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=";

String assembleErc20BalanceUrl(String address, String contractAddress, ChainType chainType, {String apiKey = etherscanApiKey}) {
  if (chainType == ChainType.ETH_TEST) {
    return Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + apiKey;
  }
}

//According to return 1. Utils.mathPow(10, decimal) order of magnitude, converted format
//                    2. balance only keeps 4 decimal places
Future<String> loadErc20Balance(String ethAddress, String contractAddress, ChainType chainType, {int decimal = 18}) async {
  try {
    var res = await request(assembleErc20BalanceUrl(ethAddress, contractAddress, chainType));
    if (res != null && (res as Map).containsKey("result")) {
      String balance = ((BigInt.parse(res["result"])) / Utils.mathPow(10, decimal)).toStringAsFixed(4);
      return balance;
    }
  } catch (e) {
    return null;
  }
  return null;
}

const Eth_Tx_List = "https://api-cn.etherscan.com/api?module=account&action=txlist&address=";
const Eth_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=";

String assembleEthTxListUrl(String address,
    {String contractAddress,
    ChainType chainType = ChainType.ETH,
    String startBlock = "0",
    String endBlock = "99999999",
    String page = "1",
    String offset = "20",
    String apiKey = etherscanApiKey}) {
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
        apiKey;
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
        apiKey;
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

String assembleErc20TxListUrl(String address,
    {ChainType chainType, String contractAddress, String page = "1", String offset = "20", String apiKey = etherscanApiKey}) {
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
        apiKey;
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
        apiKey;
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

String assembleSendRawTx(ChainType chainType, String hexRawTx, {String apiKey = etherscanApiKey}) {
  if (chainType == ChainType.ETH_TEST) {
    return Eth_TestNet_Send_RawTx + hexRawTx + "&apikey=" + apiKey.toString();
  } else {
    return Eth_Send_RawTx + hexRawTx + "&apikey=" + apiKey.toString();
  }
}

Future<String> sendRawTx(ChainType chainType, String rawTx) async {
  try {
    var res = await request(assembleSendRawTx(chainType, rawTx));
    if (res != null && (res as Map).containsKey("result")) {
      return res["result"];
    }
    return "";
  } catch (e) {
    return "";
  }
}
