import 'package:app/global_config/global_config.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';

import 'net_util.dart';

//nonce === txAccount
Future<String> loadTxAccount(String address) async {
  try {
    var res = await request(assembleTxAccount(address));
    print("loadNonce res=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      print("Erc20_Balance res.result.=====================>" + res["result"].toString());
      return res["result"].toString();
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<String> loadEthBalance(String address) async {
  try {
    var res = await request(assembleEthBalanceUrl(address));
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

Future<String> loadErc20Balance(String ethAddress, String contractAddress) async {
  try {
    var res = await request(assembleErc20BalanceUrl(ethAddress, contractAddress: contractAddress));
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

Future<List<EthTransactionModel>> loadEthTxHistory(String address, {String offset}) async {
  List<EthTransactionModel> modelArray = [];
  try {
    var res = await request(assembleEthTxListUrl(address, offset: offset));
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

//todo
Future<List> loadErc20TxHistory(String address, String contractAddress, {String offset}) async {
  var modelArray = [];
  try {
    var res = await request(assembleErc20TxListUrl(address, contractAddress: contractAddress, offset: offset));
    print("loadErc20TxHistory=====================>" + res.toString());
    //todo 解析成 erc20的格式
    return modelArray;
  } catch (e) {
    print("error is ====>" + e);
    return [];
  }
}
