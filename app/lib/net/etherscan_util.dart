import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:logger/logger.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:wallets/enums.dart';
import 'net_util.dart';

Future<String> loadEtherApiKey() async {
  Config config = await HandleConfig.instance.getConfig();
  return config.privateConfig.etherscanKey;
}

const Eth_Gas_Oracle = "https://api-cn.etherscan.com/api?module=gastracker&action=gasoracle&apikey=";
const Eth_TestNet_Gas_Oracle = "https://api-ropsten.etherscan.io/api?module=gastracker&action=gasoracle&apikey=";

Future<String> assembleGasOracle(ChainType chainType) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.ETH) {
    return Eth_Gas_Oracle + apiKey;
  } else {
    return Eth_TestNet_Gas_Oracle + apiKey;
  }
}

//GasOracle
Future<Map> loadGasOracle(ChainType chainType) async {
  try {
    var res = await request(await assembleTxAccount(chainType));
    if (res != null && (res as Map).containsKey("result")) {
      return res["result"];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

const Eth_Tx_Account = "https://api-cn.etherscan.com/api?module=proxy&action=eth_getTransactionCount&address=";
const Eth_TestNet_Tx_Account = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_getTransactionCount&address=";

Future<String> assembleTxAccount(String address, ChainType chainType) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.ETH) {
    return Eth_Tx_Account + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Eth_TestNet_Tx_Account + address + "&tag=latest&apikey=" + apiKey;
  }
}

//nonce === txAccount currently uses infura||etherscan
Future<String> loadTxAccount(String address, ChainType chainType) async {
  try {
    var res = await request(await assembleTxAccount(address, chainType));
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

Future<String> assembleEthBalanceUrl(String address, {ChainType chainType = ChainType.ETH}) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.EthTest) {
    return Eth_TestNet_Balance + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Eth_MainNet_Balance + address + "&tag=latest&apikey=" + apiKey;
  }
}

//According to return  1. Eth_Unit magnitude, converted format
//                     2. balance only keeps 4 decimal places
Future<String> loadEthBalance(String address, ChainType chainType) async {
  Config config = await HandleConfig.instance.getConfig();
  try {
    var res = await request(await assembleEthBalanceUrl(address, chainType: chainType));
    if (res != null && (res as Map).containsKey("result")) {
      return (BigInt.from(num.parse(res["result"])) / config.ethUnit).toStringAsFixed(4);
    }
  } catch (e) {
    Logger().e("loadEthBalance  error ", e.toString());
    return null;
  }
  return null;
}

const Erc20_Balance = "https://api-cn.etherscan.com/api?module=account&action=tokenbalance&contractaddress=";
const Erc20_TestNet_Balance = "https://api-ropsten.etherscan.io/api?module=account&action=tokenbalance&contractaddress=";

Future<String> assembleErc20BalanceUrl(String address, String contractAddress, ChainType chainType) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.EthTest) {
    return Erc20_TestNet_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + apiKey;
  } else {
    return Erc20_Balance + contractAddress + "&address=" + address + "&tag=latest&apikey=" + apiKey;
  }
}

//According to return 1. Utils.mathPow(10, decimal) order of magnitude, converted format
//                    2. balance only keeps 4 decimal places
Future<String> loadErc20Balance(String ethAddress, String contractAddress, ChainType chainType, {int decimal = 18}) async {
  try {
    var res = await request(await assembleErc20BalanceUrl(ethAddress, contractAddress, chainType));
    if (res != null && (res as Map).containsKey("result")) {
      String balance = ((BigInt.parse(res["result"])) / Utils.mathPow(10, decimal)).toStringAsFixed(4);
      return balance;
    }
  } catch (e) {
    Logger().e("loadErc20Balance  error ", e.toString());
    return null;
  }
  return null;
}

const Eth_Tx_List = "https://api-cn.etherscan.com/api?module=account&action=txlist&address=";
const Eth_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=txlist&address=";

Future<String> assembleEthTxListUrl(String address,
    {String contractAddress,
    ChainType chainType = ChainType.ETH,
    String startBlock = "0",
    String endBlock = "99999999",
    String page = "1",
    String offset = "20"}) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.EthTest) {
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
  Config config = await HandleConfig.instance.getConfig();
  try {
    var res = await request(await assembleEthTxListUrl(address, offset: offset, chainType: chainType));
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
          String inputInfo = EthChainControl.getInstance().decodeAdditionData(res["result"][i]["input"].toString());
          ethTxModel.input = inputInfo ?? "";
        } catch (e) {
          ethTxModel.input = "";
          Logger().e("etherScanUtil  error ", e.toString());
        }
        ethTxModel.timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(res["result"][i]["timeStamp"]) * 1000).toString();
        if (res["result"][i]["from"].trim().toLowerCase() == address.trim().toLowerCase()) {
          ethTxModel.value = "-" + (double.parse(res["result"][i]["value"]) / config.ethUnit.toDouble()).toString();
        } else {
          ethTxModel.value = "+" + (double.parse(res["result"][i]["value"]) / config.ethUnit.toDouble()).toString();
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
    Logger().e("loadEthTxHistory===> ", e.toString());
    return [];
  }
}

const Erc20_Tx_List = "http://api-cn.etherscan.com/api?module=account&action=tokentx&contractaddress=";
const Erc20_TestNet_Tx_List = "https://api-ropsten.etherscan.io/api?module=account&action=tokentx&contractaddress=";

Future<String> assembleErc20TxListUrl(String address, {ChainType chainType, String contractAddress, String page = "1", String offset = "20"}) async {
  String apiKey = await loadEtherApiKey();
  if (chainType.toString() == ChainType.EthTest.toString()) {
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
  Config config = await HandleConfig.instance.getConfig();
  try {
    var res = await request(await assembleErc20TxListUrl(address, contractAddress: contractAddress, chainType: chainType, offset: offset));
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
          ethTxModel.value = "-" + (double.parse(res["result"][i]["value"]) / config.ethUnit.toDouble()).toString();
        } else {
          ethTxModel.value = "+" + (double.parse(res["result"][i]["value"]) / config.ethUnit.toDouble()).toString();
        }
        ethTxModel.isError = translate('tx_success').toString();
        modelArray.add(ethTxModel);
      }
    }
    return modelArray;
  } catch (e) {
    Logger().e("loadErc20TxHistory===> ", e.toString());
    return [];
  }
}

const Eth_Send_RawTx = "https://api.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";
const Eth_TestNet_Send_RawTx = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_sendRawTransaction&hex=";

Future<String> assembleSendRawTx(ChainType chainType, String hexRawTx) async {
  String apiKey = await loadEtherApiKey();
  if (chainType == ChainType.EthTest) {
    return Eth_TestNet_Send_RawTx + hexRawTx + "&apikey=" + apiKey.toString();
  } else {
    return Eth_Send_RawTx + hexRawTx + "&apikey=" + apiKey.toString();
  }
}

Future<String> sendRawTx(ChainType chainType, String rawTx) async {
  try {
    var res = await request(await assembleSendRawTx(chainType, rawTx));
    if (res != null && (res as Map).containsKey("result")) {
      return res["result"];
    }
    Logger.getInstance().d("sendRawTx", "tx sendRawTx error is " + res.toString());
    return "";
  } catch (e) {
    Logger.getInstance().e("sendRawTx", "tx sendRawTx error is " + e.toString());
    return "";
  }
}

const Eth_Call = "https://api-cn.etherscan.com/api?module=proxy&action=eth_call";
const Eth_TestNet_Call = "https://api-ropsten.etherscan.io/api?module=proxy&action=eth_call";

Future<String> ethCall(ChainType chainType, String to, String data) async {
  String apiKey = await loadEtherApiKey();
  try {
    String url = "";
    if (chainType == ChainType.EthTest) {
      url = "${Eth_TestNet_Call}&to=${to}&data=${data}&tag=latest&apikey=${apiKey.toString()}";
    } else {
      url = "$Eth_Call&to=$to&data=$data&tag=latest&apikey=${apiKey.toString()}";
    }
    var res = await request(url);
    if (res != null && (res as Map).containsKey("result")) {
      return res["result"];
    }
    return "";
  } catch (e) {
    return "";
  }
}
