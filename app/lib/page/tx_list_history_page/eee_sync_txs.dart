

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/util/utils.dart';
import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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

  static _threadRun(RunParams runParams) async {
    var oneFinish = true;
        Timer.periodic(new Duration(seconds: 60),  (Timer t) async {
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
    Map txHistoryMap = await scryXNetUtil.loadChainHeader();
    if (txHistoryMap == null || !txHistoryMap.containsKey("result")) {
      return;
    }
    String eeeStorageKey = await scryXNetUtil.loadEeeStorageKey(SystemSymbol, AccountSymbol, runParams.pubKey);
    String tokenXStorageKey = await scryXNetUtil.loadEeeStorageKey(TokenXSymbol, BalanceSymbol, runParams.pubKey);
    if (eeeStorageKey == null || eeeStorageKey.trim() == "") {
      return;
    }
    int latestBlockHeight = Utils.hexToInt(txHistoryMap["result"]["number"].toString().substring(2));
    print("latestBlockHeight is ===>" + latestBlockHeight.toString());

    Map eeeSyncMap = await Wallets.instance.getEeeSyncRecord();
    if (!_isMapStatusOk(eeeSyncMap) || !eeeSyncMap.containsKey("records")) {
      return;
    }
    Map records = eeeSyncMap["records"];
    const onceCount = 3000;
    int startBlockHeight = 0;
    int queryCount = 0;
    if (records == null || records.length < 1) {
      print("records  is ======>" + records.toString());
      startBlockHeight = 0;
      queryCount = (latestBlockHeight - 0) ~/ onceCount + 1; //divide down to fetch int
    } else {
      print("records.length.toString()  is ======>" + records.length.toString());
      print("records  is ======>" + records.toString());
      print("eeeSyncMap is ===>" + eeeSyncMap.toString());
      if (eeeSyncMap == null || !eeeSyncMap.containsKey("status") || eeeSyncMap["status"] != 200) {
        return;
      }
      Map<dynamic, dynamic> recordsMap = eeeSyncMap["records"];
      recordsMap.forEach((key, value) {
        print("recordsMap key is =======>" + key);
        Map<dynamic, dynamic> accountDetailMap = value;
        if (accountDetailMap != null &&
            accountDetailMap.containsKey("account") &&
            accountDetailMap["account"].toString().toLowerCase().trim() == runParams.address.toLowerCase()) {
        startBlockHeight = accountDetailMap["blockNum"];
        return;
        }
      });
      queryCount = (latestBlockHeight - startBlockHeight) ~/ onceCount + 1; //divide down to fetch int
    }

      for (int i = 0; i < queryCount; i++) {
        int queryIndex = i;
        int currentStartBlockNum = startBlockHeight + queryIndex * onceCount + 1;
        Map currentMap = await scryXNetUtil.loadChainBlockHash(currentStartBlockNum);
        if (currentMap == null || !currentMap.containsKey("result")) {
          return;
        }
        String currentBlockHash = currentMap["result"].toString();
        int endBlockHeight = queryIndex == (queryCount - 1) ? latestBlockHeight : ((queryIndex + 1) * onceCount + startBlockHeight);
        Map endBlockMap = await scryXNetUtil.loadChainBlockHash(endBlockHeight);
        if (endBlockMap == null || !endBlockMap.containsKey("result")) {
          return;
        }
        String endBlockHash = endBlockMap["result"].toString();
        Map queryStorageMap = await scryXNetUtil.loadQueryStorage([eeeStorageKey, tokenXStorageKey], currentBlockHash, endBlockHash);
        if (queryStorageMap == null || !endBlockMap.containsKey("result")) {
          return;
        }
        List storageChanges = queryStorageMap["result"];
        // print("storageChanges is ===>" + storageChanges.toString());
        if (storageChanges == null || storageChanges.length < 1) {
          return;
        }
        storageChanges.forEach((element) async {
          if (element == null || !element.containsKey("block")) {
            return;
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
          Map loadStorageMap = await scryXNetUtil.loadStateStorage(eventKeyPrefix, element["block"]);
          if (loadStorageMap == null || !loadStorageMap.containsKey("result")) {
            return;
          }
          String extrinsicJson = convert.jsonEncode(extrinsicList);
          // print("scryXNetUtil extrinsicJson is ======>" + extrinsicJson);
          Map saveEeeMap = await Wallets.instance
              .saveEeeExtrinsicDetail(runParams.address, loadStorageMap["result"], element["block"], extrinsicJson);
          print("saveEeeMap is ===>" + saveEeeMap.toString() + "|| block is ===>" + element["block"] + "||extrinsicJson===>" + extrinsicJson);
          if (!_isMapStatusOk(saveEeeMap)) {
            return;
          }
        });
        print("updateEeeSyncRecord ===> endBlockHeight is ===>" + endBlockHeight.toString());
        Map updateEeeMap = await Wallets.instance.updateEeeSyncRecord(runParams.address,
            Chain.chainTypeToInt(runParams.chainType), endBlockHeight, endBlockHash);
        print("updateEeeMap is ===>" + updateEeeMap.toString() + "|| endBlockHeight.toString()" + endBlockHeight.toString());
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