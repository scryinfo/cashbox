import 'package:app/global_config/global_config.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';

import 'net_util.dart';

Future<String> loadEthBalance(String address) async {
  var res = await request(assembleEthBalanceUrl("0xa4512ca7618d8d12a30C28979153aB09809ED7fD"));
  print("loadEthBalance res=====================>" + res.toString());
  if (res != null && (res as Map).containsKey("result")) {
    print("Eth_Balance res.result.=====================>" + res["result"].toString());
    return res["result"].toString();
  }
  return null;
}

Future<String> loadErc20Balance(String address) async {
  try {
    var res = await request(assembleErc20BalanceUrl("0xa4512ca7618d8d12a30C28979153aB09809ED7fD"));
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

Future<List<EthTransactionModel>> loadEthTxHistory(String address) async {
  List<EthTransactionModel> modelArray = [];
  try {
    var res = await request(assembleEthTxListUrl("0xa4512ca7618d8d12a30C28979153aB09809ED7fD"));
    print("Eth_Tx_List=====================>" + res.toString());
    if (res != null && (res as Map).containsKey("result")) {
      for (var i = 0; i < res["result"].length; i++) {
        var ethTxModel = new EthTransactionModel();
        ethTxModel
          ..blockNumber = (res["result"][i]["blockNumber"])
          ..blockNumber = res["result"][i]["blockNumber"]
          ..timeStamp = res["result"][i]["timeStamp"]
          ..hash = res["result"][i]["hash"]
          ..nonce = res["result"][i]["nonce"]
          ..blockHash = res["result"][i]["blockHash"]
          ..transactionIndex = res["result"][i]["transactionIndex"]
          ..from = res["result"][i]["from"]
          ..to = res["result"][i]["to"]
          ..value = res["result"][i]["value"]
          ..gas = res["result"][i]["gas"]
          ..gasPrice = res["result"][i]["gasPrice"]
          ..isError = res["result"][i]["isError"]
          ..txreceipt_status = res["result"][i]["txreceipt_status"]
          ..input = res["result"][i]["input"]
          ..contractAddress = res["result"][i]["contractAddress"]
          ..cumulativeGasUsed = res["result"][i]["cumulativeGasUsed"]
          ..gasUsed = res["result"][i]["gasUsed"]
          ..confirmations = res["result"][i]["confirmations"];
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
Future<List> loadErc20TxHistory(String address) async {
  var modelArray = [];
  try {
    var res = await request(assembleErc20TxListUrl("0xa4512ca7618d8d12a30C28979153aB09809ED7fD"));
    print("loadErc20TxHistory=====================>" + res.toString());
    return modelArray;
  } catch (e) {
    return modelArray;
  }
}
