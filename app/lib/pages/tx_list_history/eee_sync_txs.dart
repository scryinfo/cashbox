import 'dart:async';
import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:log_util/log_util.dart';
import 'package:app/util/utils.dart';
import 'dart:convert' as convert;

class RunParams {
  final String address;
  final ChainType chainType;

  RunParams(this.address, this.chainType);
}

class EeeSyncTxs {
  static EeeSyncTxs startOnce(Chain chain) => _getInstance(chain); //此方法可以多次调用，但只运行一个线程
  static Map<String, EeeSyncTxs> _instance;

  EeeSyncTxs._internal(Chain chain)
      : _address = chain.chainAddress,
        _chainType = chain.chainType {
    // 初始化
  }

  static EeeSyncTxs _getInstance(Chain chain) {
    if (_instance == null) {
      _instance = <String, EeeSyncTxs>{};
    }
    if (!_instance.containsKey(chain.chainAddress)) {
      var newOne = EeeSyncTxs._internal(chain);
      _instance[chain.chainAddress] = newOne;
      newOne._start();
    }
    for (var key in _instance.keys.toList()) {
      var it = _instance[key];
      if (it._address != chain.chainAddress) {
        it.stop();
        _instance.remove(key);
      }
    }

    return _instance[chain.chainAddress];
  }

  final String _address;
  final ChainType _chainType;
  Timer _timer;
  bool _timing = false;
  String _eeeStorageKey = '';
  String _tokenXStorageKey = '';
  String _infoId = '';

  ScryXNetUtil _scryXNetUtil = new ScryXNetUtil();

  _start() async {
    Config config = await HandleConfig.instance.getConfig();
    RunParams runParams = new RunParams(_address, _chainType);
    _eeeStorageKey = await _scryXNetUtil.loadEeeStorageKey(config.systemSymbol, config.accountSymbol, runParams.address);
    _tokenXStorageKey = await _scryXNetUtil.loadEeeStorageKey(config.tokenXSymbol, config.balanceSymbol, runParams.address);
    Map getSubChainMap = await Wallets.instance.getSubChainBasicInfo("", 0, 0);
    if (getSubChainMap != null && getSubChainMap["status"] == 200) {
      _infoId = getSubChainMap["infoId"];
    }
    _threadRun(runParams);
  }

  stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  _threadRun(RunParams runParams) async {
    _timer = Timer.periodic(new Duration(seconds: 30), (Timer t) async {
      if (_timing) {
        return;
      }
      _timing = true;
      try {
        await _loadEeeChainTxHistoryData(runParams);
      } catch (e) {
        LogUtil.instance().e("_loadEeeChainTxHistoryData error is ", e.toString());
      }
      _timing = false;
    });
  }

  _loadEeeChainTxHistoryData(RunParams runParams) async {
    Config config = await HandleConfig.instance.getConfig();
    int latestBlockHeight = -1;
    {
      Map txHistoryMap = await _scryXNetUtil.loadChainHeader();
      if (txHistoryMap == null || !txHistoryMap.containsKey("result")) {
        return;
      }

      latestBlockHeight = Utils.hexToInt(txHistoryMap["result"]["number"].toString().substring(2));
    }

    {
      if (_eeeStorageKey == null || _eeeStorageKey.isEmpty) {
        _eeeStorageKey = await _scryXNetUtil.loadEeeStorageKey(config.systemSymbol, config.accountSymbol, runParams.address);
      }
      if (_tokenXStorageKey == null || _tokenXStorageKey.isEmpty) {
        _tokenXStorageKey = await _scryXNetUtil.loadEeeStorageKey(config.tokenXSymbol, config.balanceSymbol, runParams.address);
      }
      if (_eeeStorageKey == null ||
          _eeeStorageKey.isEmpty ||
          _eeeStorageKey.trim().isEmpty ||
          _tokenXStorageKey == null ||
          _tokenXStorageKey.isEmpty ||
          _tokenXStorageKey.trim().isEmpty) {
        return;
      }
    }
    var startBlockHeight = 0;
    {
      Map eeeSyncMap = await Wallets.instance.getEeeSyncRecord();
      if (!_isMapStatusOk(eeeSyncMap)) {
        return;
      }
      Map records = eeeSyncMap["records"];
      if (records != null && records.isNotEmpty) {
        Map<dynamic, dynamic> recordsMap = eeeSyncMap["records"];
        for (var v in recordsMap.values) {
          Map<dynamic, dynamic> accountDetailMap = v;
          if (accountDetailMap != null &&
              accountDetailMap.containsKey("account") &&
              accountDetailMap["account"].toString().toLowerCase().trim() == runParams.address.toLowerCase()) {
            startBlockHeight = accountDetailMap["blockNum"];
            break;
          }
        }
      }
    }

    const onceCount = 3000;
    var queryCount = ((latestBlockHeight - startBlockHeight) / onceCount.toDouble()).ceil(); //divide down to fetch int

    for (int i = 0; i < queryCount; i++) {
      String startBlockHash = '';
      int currentStartBlockNum = startBlockHeight + i * onceCount + 1;
      {
        Map currentMap = await _scryXNetUtil.loadChainBlockHash(currentStartBlockNum);
        if (currentMap == null || !currentMap.containsKey("result")) {
          return;
        }
        startBlockHash = currentMap["result"].toString();
        if (startBlockHash.isEmpty) {
          return;
        }
      }
      String endBlockHash = '';
      int endBlockHeight = currentStartBlockNum + onceCount;
      {
        if (endBlockHeight > latestBlockHeight) {
          endBlockHeight = latestBlockHeight;
        }
        Map endBlockMap = await _scryXNetUtil.loadChainBlockHash(endBlockHeight);
        if (endBlockMap == null || !endBlockMap.containsKey("result")) {
          return;
        }
        endBlockHash = endBlockMap["result"].toString();
        if (endBlockHash.isEmpty) {
          return;
        }
      }
      Map queryStorageMap = await _scryXNetUtil.loadQueryStorage([_eeeStorageKey, _tokenXStorageKey], startBlockHash, endBlockHash);
      if (queryStorageMap == null || !queryStorageMap.containsKey("result")) {
        return;
      }
      List storageChanges = queryStorageMap["result"];
      if (storageChanges == null || storageChanges.isEmpty) {
        return;
      }
      for (var element in storageChanges) {
        if (element == null || !element.containsKey("block")) {
          continue;
        }
        String blockHash = element["block"];
        Map loadBlockMap = await _scryXNetUtil.loadBlock(blockHash);
        if (loadBlockMap == null || !loadBlockMap.containsKey("result")) {
          return;
        }
        Map blockResultMap = loadBlockMap["result"];
        if (blockResultMap == null || !blockResultMap.containsKey("block")) {
          return;
        }
        Map extrinsicResultMap = blockResultMap["block"]; // check maybe be null
        if (extrinsicResultMap == null || !extrinsicResultMap.containsKey("extrinsics")) {
          return;
        }
        List extrinsicList = extrinsicResultMap["extrinsics"];
        if (extrinsicList == null || extrinsicList.length <= 1) {
          continue; //这里没有出错，是没有数据，所以不用返回
        }
        String eventKeyPrefix = "0x26aa394eea5630e07c48ae0c9558cef780d41e5e16056765bc8461851072c9d7";
        Map loadStorageMap = await _scryXNetUtil.loadStateStorage(eventKeyPrefix, element["block"]); //如何检测具体的交易是否成功
        if (loadStorageMap == null || !loadStorageMap.containsKey("result")) {
          return;
        }
        String extrinsicJson = convert.jsonEncode(extrinsicList);
        Map saveEeeMap =
            await Wallets.instance.saveEeeExtrinsicDetail(_infoId, runParams.address, loadStorageMap["result"], element["block"], extrinsicJson);
        if (!_isMapStatusOk(saveEeeMap)) {
          return;
        }
      }

      Map updateEeeMap =
          await Wallets.instance.updateEeeSyncRecord(runParams.address, Chain.chainTypeToInt(runParams.chainType), endBlockHeight, endBlockHash);
      if (!_isMapStatusOk(updateEeeMap)) {
        return;
      }
    }
  }

  static bool _isMapStatusOk(Map returnMap) {
    if (returnMap == null || !returnMap.containsKey("status") || returnMap["status"] != 200) {
      LogUtil.instance().e("returnMap error is ", returnMap.toString());
      return false;
    }
    return true;
  }
}
