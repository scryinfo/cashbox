import 'package:app/global_config/vendor_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'net_util.dart';

class ScryXNetUtil {
  Future<Map> loadEeeAccountInfo(ChainType eeeChainType) async {
    Map eeeResultMap;
    Map<dynamic, dynamic> eeeAccountKeyMap =
        await Wallets.instance.eeeAccountInfoKey(Wallets.instance.nowWallet.getChainByChainType(eeeChainType).chainAddress);
    if (eeeAccountKeyMap != null && eeeAccountKeyMap.containsKey("status")) {
      if (eeeAccountKeyMap["status"] != null && eeeAccountKeyMap["status"] == 200) {
        String formattedKeyInfo = eeeAccountKeyMap["accountKeyInfo"];
        print("eeeAccountKeyMap is ===>"+eeeAccountKeyMap.toString());
        print("formattedKeyInfo is ===>"+formattedKeyInfo);
        Map netFormatMap = await _loadScryXStorage(formattedKeyInfo);
        if (netFormatMap != null && netFormatMap.containsKey("result")) {
          eeeResultMap = await Wallets.instance.decodeEeeAccountInfo(netFormatMap["result"]);
        }
      }
    }
    return eeeResultMap;
  }

  Future<Map> _loadScryXStorage(formattedAddress) async {
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    Map resultMap = new Map();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [formattedAddress],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      print("loadScryXStorage error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadScryXRuntimeVersion() async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "state_getRuntimeVersion", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      print("loadScryXRuntimeVersion error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadScryXBlockHash() async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      print("loadScryXBlockHash error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadChainHeader() async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "chain_getHeader", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      print("loadChainHeader resultMap is ===>" + resultMap.toString());
      return resultMap;
    } catch (e) {
      print("loadChainHeader error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadChainBlockHash(int endBlockHeight) async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [endBlockHeight],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      print("loadBlockHash resultMap is ===>" + resultMap.toString());
      return resultMap;
    } catch (e) {
      print("loadBlockHash error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadQueryStorage(String accountKeyInfo, String startBlockHash, String endBlockHash) async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_queryStorage",
      "params": [
        [accountKeyInfo],
        startBlockHash,
        endBlockHash
      ],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      print("loadQueryStorage resultMap is ===>" + resultMap.toString());
      return resultMap;
    } catch (e) {
      print("loadQueryStorage error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadBlock(String blockHash) async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlock",
      "params": [blockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      print("loadBlocks resultMap is ===>" + resultMap.toString());
      return resultMap;
    } catch (e) {
      print("loadBlocks error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> loadStateStorage(String eventKeyPrefix, String blockHash) async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [eventKeyPrefix, blockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      print("loadBlocks resultMap is ===>" + resultMap.toString());
      return resultMap;
    } catch (e) {
      print("loadBlocks error is ===>" + e.toString());
      return null;
    }
  }

  Future<Map> submitExtrinsic(txInfo) async {
    Map resultMap = new Map();
    var spUtil = await SharedPreferenceUtil.instance;
    var netUrl = spUtil.getString(VendorConfig.scryXIpKey);
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "author_submitExtrinsic", // author_submitExtrinsic
      "params": [txInfo],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      print("submitExtrinsic error is ===>" + e.toString());
      return null;
    }
  }
}
