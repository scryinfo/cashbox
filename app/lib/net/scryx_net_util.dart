import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:logger/logger.dart';
import 'net_util.dart';

class ScryXNetUtil {
  //todo 待优化
  Future<String> _loadScryXIp() async {
    Config config = await HandleConfig.instance.getConfig();
    return config.privateConfig.scryXIp;
    // return "http://192.168.2.7:9933";
  }

  Future<Map> loadScryXStorage(formattedAddress) async {
    String netUrl = await _loadScryXIp();
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
      Logger().e("loadScryXStorage error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadScryXRuntimeVersion() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "state_getRuntimeVersion", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadScryXRuntimeVersion error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadScryXBlockHash() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
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
      Logger().e("loadScryXBlockHash error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadChainHeader() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "chain_getHeader", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadChainHeader error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadChainBlockHash(int endBlockHeight) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
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
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadQueryStorage(List<String> accountKeyInfo, String startBlockHash, String endBlockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_queryStorage",
      "params": [accountKeyInfo, startBlockHash, endBlockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadBlock(String blockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
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
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadStateStorage(String eventKeyPrefix, String blockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
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
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> submitExtrinsic(txInfo) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
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
      Logger().e("submitExtrinsic error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadMetadata() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "state_getMetadata", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("getMetadata error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadSystemProperties() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "system_properties", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadSystemProperties error is  ", e.toString());
      return null;
    }
  }


}
