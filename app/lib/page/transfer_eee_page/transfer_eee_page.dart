import 'dart:typed_data';

import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class TransferEeePage extends StatefulWidget {
  @override
  _TransferEeePageState createState() => _TransferEeePageState();
}

class _TransferEeePageState extends State<TransferEeePage> {
  TextEditingController _toAddressController = TextEditingController();
  TextEditingController _txValueController = TextEditingController();
  TextEditingController _backupMsgController = TextEditingController();
  var chainAddress = "";
  int runtimeVersion;
  int txVersion;
  String eeeBalance;
  int nonce;
  String genesisHash;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
    Map eeeBalanceMap = await scryXNetUtil.loadEeeAccountInfo(Wallets.instance.nowWallet.nowChain.chainType);
    if (!_isMapStatusOk(eeeBalanceMap)) {
      return;
    }
    eeeBalance = eeeBalanceMap["free"];
    nonce = eeeBalanceMap["nonce"];
    Map blockHashMap = await scryXNetUtil.loadScryXBlockHash();
    if (blockHashMap == null || !blockHashMap.containsKey("result")) {
      return;
    }
    genesisHash = blockHashMap["result"];
    print("genesisHash.toString is ===> " + genesisHash.toString());

    Map runtimeMap = await scryXNetUtil.loadScryXRuntimeVersion();
    print("runtimeMap.toString is ===> " + runtimeMap.toString());
    if (runtimeMap == null || !runtimeMap.containsKey("result")) {
      return;
    }
    var resultMap = runtimeMap["result"];
    if (resultMap == null || !resultMap.containsKey("specVersion") || !resultMap.containsKey("transactionVersion")) {
      return;
    }
    runtimeVersion = resultMap["specVersion"];
    txVersion = resultMap["transactionVersion"];

    Map txHistoryMap = await scryXNetUtil.loadChainHeader();
    if (txHistoryMap == null || !txHistoryMap.containsKey("result")) {
      return;
    }

    Map accountKeyMap = await Wallets.instance.eeeAccountInfoKey(Wallets.instance.nowWallet.nowChain.chainAddress);
    if (!_isMapStatusOk(accountKeyMap) || !accountKeyMap.containsKey("accountKeyInfo")) {
      return;
    }

    int latestBlockHeight = Utils.hexToInt(txHistoryMap["result"]["number"].toString().substring(2));
    print("latestBlockHeight is ===>" + latestBlockHeight.toString());

    Map eeeSyncMap = await Wallets.instance.getEeeSyncRecord();
    if (!_isMapStatusOk(eeeSyncMap) || !eeeSyncMap.containsKey("records")) {
      return;
    }
    Map records = eeeSyncMap["records"];

    String formattedKey = accountKeyMap["accountKeyInfo"];
    const onceCount = 3000;
    int startBlockHeight = 0;
    int queryCount = 0;
    if (records == null || records.length == 0) {
      print("records  is ===>" + records.toString());
      startBlockHeight = 0;
      queryCount = (latestBlockHeight - 0) ~/ onceCount + 1; //divide down to fetch int
    } else {
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
            accountDetailMap["account"].toString().toLowerCase().trim() == Wallets.instance.nowWallet.nowChain.chainAddress.toLowerCase()) {
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
      Map queryStorageMap = await scryXNetUtil.loadQueryStorage(formattedKey, currentBlockHash, endBlockHash);
      if (queryStorageMap == null || !endBlockMap.containsKey("result")) {
        return;
      }
      List storageChanges = queryStorageMap["result"];
      print("storageChanges is ===>" + storageChanges.toString());
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
        Map blockResultMap = loadBlockMap["result"];
        if (blockResultMap == null || !blockResultMap.containsKey("block")) {
          return;
        }
        Map extrinsicResultMap = blockResultMap["extrinsics"];
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
          return; //todo 停止整个同步记录流程
        }
        String extrinsicJson = convert.jsonEncode(extrinsicList);
        Map saveEeeMap = await Wallets.instance
            .saveEeeExtrinsicDetail(Wallets.instance.nowWallet.nowChain.chainAddress, loadStorageMap["result"], element["block"], extrinsicJson);
        print("saveEeeMap is ===>" + saveEeeMap.toString());
        if (!_isMapStatusOk(saveEeeMap)) {
          //todo 停止整个同步记录流程
        }
      });
      Map updateEeeMap = await Wallets.instance.updateEeeSyncRecord(Wallets.instance.nowWallet.nowChain.chainAddress,
          Chain.chainTypeToInt(Wallets.instance.nowWallet.nowChain.chainType), endBlockHeight, endBlockHash);
      print("updateEeeMap is ===>" + updateEeeMap.toString());
      if (!_isMapStatusOk(updateEeeMap)) {
        //todo 停止整个同步记录流程
      }
    }
  }

  bool _isMapStatusOk(Map returnMap) {
    if (returnMap == null || !returnMap.containsKey("status") || returnMap["status"] != 200) {
      return false;
    }
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('wallet_transfer'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildTransferEeeWidget(),
        ),
      ),
    );
  }

  Widget _buildTransferEeeWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.scaleVGap(5),
            _buildToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildValueWidget(),
            Gaps.scaleVGap(15),
            _buildTransferBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildToAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('receive_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil.instance.setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(13),
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: ScreenUtil.instance.setSp(3.5),
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setHeight(3),
                        right: ScreenUtil().setWidth(10),
                        top: ScreenUtil().setHeight(5),
                        bottom: ScreenUtil().setHeight(5),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                      hintText: translate('pls_input_receive_address'),
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: ScreenUtil.instance.setSp(3),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    controller: _toAddressController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  //width: ScreenUtil.getInstance().setWidth(13),
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(12),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(1),
                    right: ScreenUtil().setWidth(1),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      try {
                        String qrResult = await QrScanUtil.instance.qrscan();
                        print("qrResult===>" + qrResult.toString());
                        setState(() {
                          _toAddressController.text = qrResult.toString();
                        });
                      } catch (e) {
                        LogUtil.e("TransferEthPage", "qrscan appear unknow error===>" + e.toString());
                        Fluttertoast.showToast(msg: translate('unknown_error_in_scan_qr_code'), timeInSecForIos: 3);
                      }
                    },
                    icon: Image.asset("assets/images/ic_scan.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('transaction_amount'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil.instance.setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            height: ScreenUtil().setHeight(13),
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil.instance.setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.instance.setSp(3),
                ),
                hintText: translate('pls_input_transaction_amount'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil.instance.setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _txValueController,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[0-9.]")), //Only numbers or decimal points can be entered.
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferBtnWidget() {
    return GestureDetector(
      onTap: () async {
        showProgressDialog(context, translate("check_data_format"));
        NavigatorUtils.goBack(context);
        _showPwdDialog(context);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().setWidth(41),
        height: ScreenUtil().setHeight(9),
        color: Color.fromRGBO(26, 141, 198, 0.20),
        child: FlatButton(
          child: Text(
            translate('click_to_transfer'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
            ),
          ),
        ),
      ),
    );
  }

  void _showPwdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('wallet_pwd').toString(),
          hintContent: translate('input_pwd_hint_detail').toString(),
          hintInput: translate('input_pwd_hint').toString(),
          onPressed: (String pwd) async {
            print("_showPwdDialog pwd is ===>" + pwd + "value===>" + _txValueController.text);
            Map eeeTransferMap = await Wallets.instance.eeeTransfer(
                Wallets.instance.nowWallet.nowChain.chainAddress,
                _toAddressController.text.toString(),
                _txValueController.text.toString(),
                genesisHash,
                nonce,
                runtimeVersion,
                txVersion,
                Uint8List.fromList(pwd.codeUnits));
            if (eeeTransferMap == null || !eeeTransferMap.containsKey("status") || eeeTransferMap["status"] != 200) {
              print("error, eeeTransferMap appear error===~");
              NavigatorUtils.goBack(context);
              return;
            }
            String signInfo = eeeTransferMap["signedInfo"];
            print("eeeTransferMap, signInfo is ======>" + signInfo);
            ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
            Map submitMap = await scryXNetUtil.submitExtrinsic(signInfo);
            if (submitMap == null || !submitMap.containsKey("result")) {
              print("error, submitMap appear error===~");
              NavigatorUtils.goBack(context);
              return;
            }
            String txHash = submitMap["result"];
            print("txHash is " + txHash.toString());
            NavigatorUtils.push(context, '${Routes.ethPage}?isForceLoadFromJni=false', clearStack: true);
          },
        );
      },
    );
  }
}
