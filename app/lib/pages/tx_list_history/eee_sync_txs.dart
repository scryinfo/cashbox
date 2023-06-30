import 'dart:async';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eee_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/util/utils.dart';
import 'package:logger/logger.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/wallets_c.dc.dart';

class RunParams {
  final String address;
  final ChainType chainType;

  RunParams(this.address, this.chainType);
}

class EeeSyncTxs {
  static EeeSyncTxs startOnce(EeeChain chain) => _getInstance(chain); //此方法可以多次调用，但只运行一个线程
  static final Map<String, EeeSyncTxs> _instance = {};

  EeeSyncTxs._internal(EeeChain chain)
      : _address = chain.chainShared.walletAddress.address,
        _chainType = WalletsControl.getInstance().currentChainType() {
    // 初始化
  }

  static EeeSyncTxs _getInstance(EeeChain chain) {
    for (var key in _instance.keys.toList()) {
      var it = _instance[key];
      if (it != null) {
        if (it._address != chain.chainShared.walletAddress.address) {
          it.stop();
          _instance.remove(key);
        }
      }
    }

    if (!_instance.containsKey(chain.chainShared.walletAddress.address)) {
      var newOne = EeeSyncTxs._internal(chain);
      _instance[chain.chainShared.walletAddress.address] = newOne;
      newOne._start();
    }
    return _instance[chain.chainShared.walletAddress.address]!;
  }

  final String _address;
  final ChainType _chainType;
  Timer? _timer = null;
  bool _timing = false;
  String _eeeStorageKey = '';
  String _tokenXStorageKey = '';

  ScryXNetUtil _scryXNetUtil = new ScryXNetUtil();

  _start() async {
    Config config = await HandleConfig.instance.getConfig();
    RunParams runParams = new RunParams(_address, _chainType);
    _eeeStorageKey =
        await EeeChainControl.getInstance().loadEeeStorageKey(config.systemSymbol, config.accountSymbol, runParams.address);
    _tokenXStorageKey =
        await EeeChainControl.getInstance().loadEeeStorageKey(config.tokenXSymbol, config.balanceSymbol, runParams.address);

    _threadRun(runParams);
  }

  stop() {
    if (_timer != null) {
      _timer!.cancel();
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
        Logger().e("_loadEeeChainTxHistoryData error is ", e.toString());
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
        _eeeStorageKey = await EeeChainControl.getInstance()
            .loadEeeStorageKey(config.systemSymbol, config.accountSymbol, runParams.address);
      }
      if (_tokenXStorageKey == null || _tokenXStorageKey.isEmpty) {
        _tokenXStorageKey = await EeeChainControl.getInstance()
            .loadEeeStorageKey(config.tokenXSymbol, config.balanceSymbol, runParams.address);
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
      AccountInfoSyncProg accountInfoSyncProg =
          EeeChainControl.getInstance().getSyncRecord(WalletsControl().currentChainAddress());
      if (accountInfoSyncProg != null && accountInfoSyncProg.account.toLowerCase() == runParams.address.toLowerCase()) {
        startBlockHeight = int.parse(accountInfoSyncProg.blockNo);
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
      Map queryStorageMap =
          await _scryXNetUtil.loadQueryStorage([_eeeStorageKey, _tokenXStorageKey], startBlockHash, endBlockHash);
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
        ExtrinsicContext extrinsicContext = ExtrinsicContext();
        ArrayCChar arrayCChar = ArrayCChar()..data = List<String>.from(extrinsicList);
        extrinsicContext
          ..account = WalletsControl.getInstance().currentChainAddress()
          ..blockHash = blockHash
          ..chainVersion = EeeChainControl.getInstance().getChainVersion()
          ..blockNumber = element["block"]
          ..event = loadStorageMap["result"]
          ..extrinsics = arrayCChar;
        bool isSaveOk = EeeChainControl.getInstance().saveExtrinsicDetail(extrinsicContext);
        Logger.getInstance().d("saveExtrinsicDetail", "saveExtrinsicDetail result is" + isSaveOk.toString());
      }
      {
        AccountInfoSyncProg accountInfoSyncProg = AccountInfoSyncProg();
        accountInfoSyncProg
          ..account = runParams.address
          ..blockNo = endBlockHeight.toString()
          ..blockHash = endBlockHash;
        var isUpdateSyncRecordOk = EeeChainControl.getInstance().updateSyncRecord(accountInfoSyncProg);
        if (!isUpdateSyncRecordOk) {
          Logger().e("updateSyncRecord error blockNo is ", endBlockHeight.toString());
          return;
        }
      }
    }
  }

  static bool _isMapStatusOk(Map returnMap) {
    if (returnMap == null || !returnMap.containsKey("status") || returnMap["status"] != 200) {
      Logger().e("returnMap error is ", returnMap.toString());
      return false;
    }
    return true;
  }
}
