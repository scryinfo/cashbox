import 'package:app/global_config/global_config.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'net_util.dart';
import 'package:flutter/services.dart';

class ScryXNetUtil {
  loadScryXStorage(address) async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(GlobalConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [address],
      "id": 1,
      "jsonrpc": "2.0"
    };
    var resultInfo = await request(netUrl, formData: paramObj);
    return resultInfo;
  }

  loadScryXRuntimeVersion() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(GlobalConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "state_getRuntimeVersion",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    var resultInfo = await request(netUrl, formData: paramObj);
    return resultInfo;
  }

  loadScryXBlockHash() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(GlobalConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    var resultInfo = await request(netUrl, formData: paramObj);
    return resultInfo;
  }

  submitExtrinsic(txInfo) async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(GlobalConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "author_submitExtrinsic", // author_submitExtrinsic
      "params": [txInfo],
      "id": 1,
      "jsonrpc": "2.0"
    };
    var resultInfo = await request(netUrl, formData: paramObj);
    return resultInfo;
  }
}
