

import 'dart:async';
import 'dart:isolate';

import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/util/utils.dart';
import 'dart:convert' as convert;

class RunParams{
  final String address;
  final String pubKey;
  final ChainType chainType;

  RunParams(this.address, this.pubKey, this.chainType);
}
class EeeSyncTxs {
  static EeeSyncTxs startOnce(Chain chain) => _getInstance(chain); //此方法可以多次调用，但只运行一个线程
  static Map<String,EeeSyncTxs> _instance;
  EeeSyncTxs._internal(Chain chain):_address = chain.chainAddress, _pubKey = chain.pubKey,_chainType = chain.chainType {
    // 初始化
  }
  static EeeSyncTxs _getInstance(Chain chain) {
    if (_instance == null) {
      _instance = <String,EeeSyncTxs>{};
    }
    if(!_instance.containsKey(chain.chainAddress)){
      var newOne = EeeSyncTxs._internal(chain);
      _instance[chain.chainAddress] = newOne;
      newOne._start();
    }
    for(var key in _instance.keys.toList()){
      var it = _instance[key];
      if(it._address != chain.chainAddress){
        it.stop();
        _instance.remove(key);
      }
    }

    return _instance[chain.chainAddress];
  }

  final String _address;
  final String _pubKey;
  final ChainType _chainType;
  Isolate isolate;
  ReceivePort receivePort;
  Timer timer;



  _start() async {
    receivePort = ReceivePort();
    RunParams runParams = new RunParams(_address, _pubKey, _chainType);
    // isolate =  await Isolate.spawn(_threadRun, runParams);
    _threadRun(runParams);
  }

  stop() {
    if(timer != null){
      timer.cancel();
      timer = null;
    }
    if(isolate != null){
      isolate.kill();
      isolate = null;
    }
  }

  _threadRun(RunParams runParams) async {
    var oneFinish = true;
    timer = Timer.periodic(new Duration(seconds: 60),  (Timer t) async {
      if(!oneFinish){
        return;
      }
      oneFinish = false;
      try {
            await _loadEeeChainTxHistoryData(runParams);
        }catch(e){
          print(e);
        }
      oneFinish = true;
    });

    // await SharedPreferenceUtil.initIpConfig();
    // WidgetsFlutterBinding.ensureInitialized();
    // await SystemChrome.setEnabledSystemUIOverlays([]);
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // await di.init(); //initialize the service locator
    // for (;true;) {
    //   try {
    //     await _loadEeeChainTxHistoryData(runParams);
    //   }catch(e){
    //     print(e);
    //   }
    //   sleep(new Duration(seconds: 1));
    // }
  }

  static _loadEeeChainTxHistoryData(RunParams runParams) async{
    print("_loadEeeChainTxHistoryData");
      //再次同步最新数据
      ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
      int latestBlockHeight = -1;
      {
        Map txHistoryMap = await scryXNetUtil.loadChainHeader();
        if (txHistoryMap == null || !txHistoryMap.containsKey("result")) {
          return;
        }

        latestBlockHeight = Utils.hexToInt(txHistoryMap["result"]["number"].toString().substring(2));
        print("latestBlockHeight is ===>" + latestBlockHeight.toString());
      }

      var tokenXStorageKey = '',eeeStorageKey = '';
      {
        String eeeStorageKey = await scryXNetUtil.loadEeeStorageKey(SystemSymbol, AccountSymbol, runParams.pubKey);
        tokenXStorageKey = await scryXNetUtil.loadEeeStorageKey(TokenXSymbol, BalanceSymbol, runParams.pubKey);
        if (eeeStorageKey == null || eeeStorageKey.isEmpty || eeeStorageKey.trim() == "") {
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
        recordsMap.forEach((key, value) {
          Map<dynamic, dynamic> accountDetailMap = value;
          if (accountDetailMap != null &&
              accountDetailMap.containsKey("account") &&
              accountDetailMap["account"].toString().toLowerCase().trim() == runParams.address.toLowerCase()) {
            startBlockHeight = accountDetailMap["blockNum"];
            return;
          }
        });
      }
    }

    const onceCount = 1000;
    var queryCount = ((latestBlockHeight - startBlockHeight)/onceCount).round() ; //divide down to fetch int

      for (int i = 0; i < queryCount; i++) {
        String startBlockHash = '';
        {
          int currentStartBlockNum = startBlockHeight + i * onceCount + 1;
          Map currentMap = await scryXNetUtil.loadChainBlockHash(currentStartBlockNum);
          if (currentMap == null || !currentMap.containsKey("result")) {
            return;
          }
          startBlockHash = currentMap["result"].toString();
          if(startBlockHash.isEmpty){
            return;
          }
        }
        String endBlockHash = '';
        int endBlockHeight = startBlockHeight + onceCount;
        {
          if(endBlockHeight > latestBlockHeight){
            endBlockHeight = latestBlockHeight;
          }
          Map endBlockMap = await scryXNetUtil.loadChainBlockHash(endBlockHeight);
          if (endBlockMap == null || !endBlockMap.containsKey("result")) {
            return;
          }
          endBlockHash = endBlockMap["result"].toString();
          if(endBlockHash.isEmpty){
            return;
          }
        }
        Map queryStorageMap = await scryXNetUtil.loadQueryStorage([eeeStorageKey, tokenXStorageKey], startBlockHash, endBlockHash);
        if (queryStorageMap == null || !queryStorageMap.containsKey("result")) {
          return;
        }
        List storageChanges = queryStorageMap["result"];
        if (storageChanges == null || storageChanges.isEmpty) {
          return;
        }
        for(var element in storageChanges){
          if (element == null || !element.containsKey("block")) {
            continue;
          }
          String blockHash = element["block"];
          Map loadBlockMap = await scryXNetUtil.loadBlock(blockHash);
          if (loadBlockMap == null || !loadBlockMap.containsKey("result")) {
            return;
          }
          // print("scryXNetUtil loadBlockMap is ======>" + loadBlockMap.toString());
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
            return;
          }
          String eventKeyPrefix = "0x26aa394eea5630e07c48ae0c9558cef780d41e5e16056765bc8461851072c9d7";
          Map loadStorageMap = await scryXNetUtil.loadStateStorage(eventKeyPrefix, element["block"]); //如何检测具体的交易是否成功
          if (loadStorageMap == null || !loadStorageMap.containsKey("result")) {
            return;
          }
          String extrinsicJson = convert.jsonEncode(extrinsicList);
          Map saveEeeMap = await Wallets.instance
              .saveEeeExtrinsicDetail(runParams.address, loadStorageMap["result"], element["block"], extrinsicJson);
          if (!_isMapStatusOk(saveEeeMap)) {
            return;
          }
        }

        Map updateEeeMap = await Wallets.instance.updateEeeSyncRecord(runParams.address,
            Chain.chainTypeToInt(runParams.chainType), endBlockHeight, endBlockHash);

        if (!_isMapStatusOk(updateEeeMap)) {
           return;
        }
      }
  }

  static bool _isMapStatusOk(Map returnMap) {
    if (returnMap == null || !returnMap.containsKey("status") || returnMap["status"] != 200) {
      return false;
    }
    return true;
  }

}