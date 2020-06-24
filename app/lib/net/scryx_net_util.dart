import 'package:app/global_config/vendor_config.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'net_util.dart';

class ScryXNetUtil {
  loadScryXStorage(address) async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [address],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      var resultInfo = await request(netUrl, formData: paramObj);
      return resultInfo;
    } catch (e) {
      print("loadScryXStorage error is ===>" + e.toString());
      return null;
    }
  }

  loadScryXRuntimeVersion() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "state_getRuntimeVersion",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      var resultInfo = await request(netUrl, formData: paramObj);
      return resultInfo;
    } catch (e) {
      print("loadScryXRuntimeVersion error is ===>" + e.toString());
      return null;
    }
  }

  loadScryXBlockHash() async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      var resultInfo = await request(netUrl, formData: paramObj);
      return resultInfo;
    } catch (e) {
      print("loadScryXBlockHash error is ===>" + e.toString());
      return null;
    }
  }

  submitExtrinsic(txInfo) async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return "";
    }
    var paramObj = {
      "method": "author_submitExtrinsic", // author_submitExtrinsic
      "params": [txInfo],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      var resultInfo = await request(netUrl, formData: paramObj);
      return resultInfo;
    } catch (e) {
      print("submitExtrinsic error is ===>" + e.toString());
      return null;
    }
  }
}
