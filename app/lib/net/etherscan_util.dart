import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/util/utils.dart';
import 'dart:convert';
import 'net_util.dart';

//nonce === txAccount
Future<String> loadTxAccount(String address, ChainType chainType) async {
  try {
    var res = await request(assembleTxAccount(address, chainType));
    print("loadNonce res=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      //说明由于infura目前接口返回的是如 0x085f这种格式。需处理掉开头0x。 后转十六进制 成 十进制
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

Future<String> loadEthBalance(String address, ChainType chainType) async {
  try {
    var res = await request(assembleEthBalanceUrl(address, chainType: chainType));
    print("loadEthBalance res=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      print("Eth_Balance res.result.=====================>" + (int.parse(res["result"]) / Eth_Unit).toString());
      return (int.parse(res["result"]) / Eth_Unit).toString();
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<String> loadErc20Balance(String ethAddress, String contractAddress, ChainType chainType) async {
  try {
    var res = await request(assembleErc20BalanceUrl(ethAddress, contractAddress: contractAddress, chainType: chainType));
    print("Erc20_Balance=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      print("Erc20_Balance res.result.=====================>" + res["result"].toString());
      return res["result"].toString();
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<List<EthTransactionModel>> loadEthTxHistory(String address, ChainType chainType, {String offset}) async {
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
          ..input = res["result"][i]["input"]
          ..contractAddress = res["result"][i]["contractAddress"]
          ..cumulativeGasUsed = res["result"][i]["cumulativeGasUsed"]
          ..gasUsed = res["result"][i]["gasUsed"]
          ..confirmations = res["result"][i]["confirmations"];
        ethTxModel.timeStamp = DateTime.fromMillisecondsSinceEpoch(int.parse(res["result"][i]["timeStamp"]) * 1000).toString();

        if (res["result"][i]["from"].trim().toLowerCase() == address.trim().toLowerCase()) {
          ethTxModel.value = "-" + (int.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        } else {
          ethTxModel.value = "+" + (int.parse(res["result"][i]["value"]) / Eth_Unit).toString();
        }
        if (res["result"][i]["isError"] == "0") {
          ethTxModel.isError = "交易成功";
        } else {
          ethTxModel.isError = "交易失败";
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

Future<List<EthTransactionModel>> loadErc20TxHistory(String address, String contractAddress, ChainType chainType, {String offset}) async {
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
          ..isError = res["result"][i]["isError"]
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
        ethTxModel.isError = "交易成功"; //erc拿到的都会是交易成功的记录
        modelArray.add(ethTxModel);
      }
    }
    return modelArray;
  } catch (e) {
    print("error is ====>" + e);
    return [];
  }
}
