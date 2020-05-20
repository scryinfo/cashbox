import 'package:flutter/material.dart';
import 'dart:convert';
import 'net_util.dart';
import 'package:flutter/services.dart';

class ScryXNetUtil {
  Future<String> loadScryXNetUrl(context) async {
    String loadString = await DefaultAssetBundle.of(context).loadString("assets/config/local_config.json");
    print("ScryXNetUtil loadString===>" + loadString);
    var jsonObject = json.decode(loadString);
    print("ScryXNetUtil jsonObject===>" + jsonObject.toString());
    return jsonObject["rateDigitIp"].toString();
  }

  doSomething(context) async {
    var paramObj = {
      "method": "state_getStorage",
      "params": [
        "0x26aa394eea5630e07c48ae0c9558cef7b99d880ec681799c0cf30e8886371da9de1e86a9a8c739864cf3cc5ec2bea59fd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d"
      ],
      "id": 1,
      "jsonrpc": "2.0"
    };
    String netUrl = await loadScryXNetUrl(context);
    if (netUrl == null || netUrl.isEmpty) {
      return;
    }
    var resultInfo = await request(netUrl, formData: paramObj);
    return resultInfo;
  }

  loadRuntimeVersion() {}

  loadGenesisHash() {}
}
