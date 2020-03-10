import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'net_util.dart';

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
          ethTxModel.isError = S.of(context).tx_success.toString();
        } else {
          ethTxModel.isError = S.of(context).tx_failure.toString();
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
        ethTxModel.isError = S.of(context).tx_success.toString();
        modelArray.add(ethTxModel);
      }
    }
    return modelArray;
  } catch (e) {
    print("error is ====>" + e);
    return [];
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
