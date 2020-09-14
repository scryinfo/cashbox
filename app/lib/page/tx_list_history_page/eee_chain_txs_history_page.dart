import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/tx_model/base_tx_model.dart';
import 'package:app/model/tx_model/eee_transaction_model.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import 'dart:convert' as convert;

class EeeChainTxsHistoryPage extends StatefulWidget {
  @override
  _EeeChainTxsHistoryPageState createState() => _EeeChainTxsHistoryPageState();
}

class _EeeChainTxsHistoryPageState extends State<EeeChainTxsHistoryPage> {
  Future txListFuture;
  List<Digit> walletDataList = [];
  List<Digit> showDataList = [];
  List<EeeTransactionModel> eeeTxListModel = [];
  String balanceInfo = "0.00";
  String moneyInfo = "0.00";
  String digitName = "";
  String fromAddress = "";
  int displayTxOffset = 0;
  int refreshAddCount = 20;

  @override
  void initState() {
    super.initState();
    //initTest();  // manual mock add tokenX
  }

  initTest() async {
    var paramString = VendorConfig.defaultDigitsContentDefaultValue;
    var updateMap = await Wallets.instance.updateDefaultDigitList(paramString);
    print("updateMap[isUpdateDefaultDigit]() =====>" + updateMap["status"].toString() + updateMap["isUpdateDefaultDigit"].toString());
    Map nativeAuthMap = await Wallets.instance.getNativeAuthDigitList(Wallets.instance.nowWallet.nowChain, 0, 100);
    if (nativeAuthMap == null) {
      print("getAuthDigitList() native digit list failure===》");
      return [];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    {
      fromAddress = Provider.of<TransactionProvide>(context).fromAddress;

      digitName = Provider.of<TransactionProvide>(context).digitName;
      balanceInfo = Provider.of<TransactionProvide>(context).balance;
      moneyInfo = Provider.of<TransactionProvide>(context).money;
    }
    print("fromAddress===>" + fromAddress + "||digitName===>" + digitName + "||balanceInfo===>" + balanceInfo + "||moneyInfo===>" + moneyInfo);
    txListFuture = getTxListData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(120),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('transaction_history'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildTxHistoryLayout(),
        ),
      ),
    );
  }

  Widget _buildTxHistoryLayout() {
    return Container(
      width: ScreenUtil().setWidth(90),
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(1),
          _buildDigitBalanceWidget(),
          Gaps.scaleVGap(7),
          _buildDigitTxTitleWidget(),
          Gaps.scaleVGap(4),
          _buildDigitTxHistoryWidget(),
        ],
      ),
    );
  }

  Widget _buildDigitBalanceWidget() {
    return Container(
      color: Color.fromRGBO(101, 98, 98, 0.12),
      height: ScreenUtil().setHeight(20.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Gaps.scaleHGap(7),
          Container(
              width: ScreenUtil().setWidth(55),
              //color: Colors.amberAccent,
              child: SingleChildScrollView(
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: balanceInfo ?? "0.0000",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(4.2),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: digitName ?? "*",
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil.instance.setSp(3.5), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "≈" + (Rate.instance.getNowLegalCurrency() ?? "") + " " + (moneyInfo ?? "0.0"),
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: ScreenUtil.instance.setSp(3.5), fontStyle: FontStyle.normal),
                  ),
                ])),
              )),
          Gaps.scaleHGap(1),
          Container(
            //height: ScreenUtil().setHeight(8),
            child: FlatButton(
              color: Color.fromRGBO(26, 141, 198, 0.2),
              onPressed: () {
                switch (Wallets.instance.nowWallet.nowChain.chainType) {
                  case ChainType.EEE:
                  case ChainType.EEE_TEST:
                    Provider.of<TransactionProvide>(context)
                      ..emptyDataRecord()
                      ..setDigitName(digitName)
                      ..setBalance(balanceInfo);
                    NavigatorUtils.push(context, Routes.transferEeePage);
                    break;
                  default:
                    NavigatorUtils.push(context, Routes.transferEeePage);
                    break;
                }
              },
              child: Text(
                translate('transfer'),
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: ScreenUtil.instance.setSp(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitTxTitleWidget() {
    return Container(
        width: ScreenUtil().setWidth(90),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Gaps.scaleHGap(5),
                  Container(
                    width: ScreenUtil().setWidth(22),
                    child: Text(
                      translate('transaction_history_record'),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: ScreenUtil.instance.setSp(3.5),
                      ),
                    ),
                  ),
                  Gaps.scaleHGap(45),
                  Container(
                    child: Opacity(
                      opacity: 0, //todo filters transactions by time, not shown for now
                      child: Text(
                        "2018.07",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Gaps.scaleHGap(6),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildDigitTxHistoryWidget() {
    return Container(
      width: ScreenUtil().setWidth(90),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(0.1),
            child: CustomPaint(
              foregroundPainter: MySeparatorLine(
                lineColor: Colors.blueAccent,
                width: ScreenUtil().setWidth(90),
              ),
            ),
          ),
          Gaps.scaleVGap(5),
          Container(
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
            child: FutureBuilder(
              future: txListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("snapshot.hasError is ===>" + snapshot.hasError.toString());
                  return Text(translate('fail_to_load_data_hint'));
                }
                if (snapshot.hasData) {
                  if (eeeTxListModel.length == 0) {
                    return Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        translate('not_exist_tx_history').toString(),
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }
                  return Container(
                    child: _makeRefreshWidgets(snapshot),
                  );
                } else {
                  return Text(
                    translate('data_loading').toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(4),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _makeRefreshWidgets(snapshot) {
    return EasyRefresh.custom(
      footer: BallPulseFooter(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: ScreenUtil().setHeight(16),
                child: _makeTxItemWidget(index),
              );
            },
            childCount: eeeTxListModel.length,
          ),
        ),
      ],
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () async {
          print("refresh onLoad======>");
          if (this.eeeTxListModel.length < displayTxOffset) {
            //Shown, less loaded than the last request, indicating that it is gone
            Fluttertoast.showToast(msg: translate('finish_load_tx_history').toString());
            return;
          }
          var eeeTxListModel = await getTxListData();
          if (eeeTxListModel != null && eeeTxListModel.length > 0) {
            setState(() {
              this.eeeTxListModel = eeeTxListModel;
            });
          }
        });
      },
    );
  }

  Widget _makeTxItemWidget(index) {
    return Container(
      width: ScreenUtil().setHeight(90),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Provider.of<TransactionProvide>(context)
            ..emptyDataRecord()
            ..setFromAddress(eeeTxListModel[index].from ?? eeeTxListModel[index].signer ?? "")
            ..setToAddress(eeeTxListModel[index].to)
            ..setHash(eeeTxListModel[index].blockHash)
            ..setTimeStamp(eeeTxListModel[index].timeStamp)
            ..setValue(eeeTxListModel[index].value);
          NavigatorUtils.push(context, Routes.eeeTransactionDetailPage);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setWidth(6),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(18),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        eeeTxListModel[index].value ?? "",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: ScreenUtil.instance.setSp(3.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        eeeTxListModel[index].blockHash, //hash
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: ScreenUtil.instance.setSp(3),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setWidth(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(18),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        eeeTxListModel[index].isSuccess ? translate('tx_success') : translate('tx_failure'),
                        style: TextStyle(
                          color: eeeTxListModel[index].isSuccess ? Colors.white70 : Colors.redAccent,
                          fontSize: ScreenUtil.instance.setSp(2.5),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        eeeTxListModel[index].timeStamp,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: ScreenUtil.instance.setSp(2.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.scaleVGap(2),
            Container(
              alignment: Alignment.bottomLeft,
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setHeight(0.1),
              child: CustomPaint(
                foregroundPainter: MySeparatorLine(
                  lineColor: Colors.blueAccent,
                  width: ScreenUtil().setWidth(90),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<EeeTransactionModel>> getTxListData() async {
    //去加载本地DB已有的交易，进行显示
    eeeTxListModel = await Wallets.instance.loadEeeChainTxHistory(Wallets.instance.nowWallet.nowChain.chainAddress, digitName, 0, 100);
    print("eeeChainTxList=========>" + eeeTxListModel.toString());
    //再去同步 最新块的交易记录
    loadEeeChainTxHistoryData();
    return eeeTxListModel;
  }

  loadEeeChainTxHistoryData() async {
    //再次同步最新数据
    ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
    Map txHistoryMap = await scryXNetUtil.loadChainHeader();
    if (txHistoryMap == null || !txHistoryMap.containsKey("result")) {
      return;
    }
    String eeeStorageKey = await scryXNetUtil.loadEeeStorageKey(SystemSymbol, AccountSymbol, Wallets.instance.nowWallet.nowChain.pubKey);
    String tokenXStorageKey = await scryXNetUtil.loadEeeStorageKey(TokenXSymbol, BalanceSymbol, Wallets.instance.nowWallet.nowChain.pubKey);
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
            accountDetailMap["account"].toString().toLowerCase().trim() == Wallets.instance.nowWallet.nowChain.chainAddress.toLowerCase()) {
          startBlockHeight = accountDetailMap["blockNum"];
          return;
        }
      });
      queryCount = (latestBlockHeight - startBlockHeight) ~/ onceCount + 1; //divide down to fetch int
    }
    if (true) {
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
          print("scryXNetUtil loadBlockMap is ======>" + loadBlockMap.toString());
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
            return; //todo 停止整个同步记录流程
          }
          String extrinsicJson = convert.jsonEncode(extrinsicList);
          print("scryXNetUtil extrinsicJson is ======>" + extrinsicJson);
          Map saveEeeMap = await Wallets.instance
              .saveEeeExtrinsicDetail(Wallets.instance.nowWallet.nowChain.chainAddress, loadStorageMap["result"], element["block"], extrinsicJson);
          print("saveEeeMap is ===>" + saveEeeMap.toString() + "|| block is ===>" + element["block"] + "||extrinsicJson===>" + extrinsicJson);
          if (!_isMapStatusOk(saveEeeMap)) {
            //todo 停止整个同步记录流程
          }
        });
        print("updateEeeSyncRecord ===> endBlockHeight is ===>" + endBlockHeight.toString());
        Map updateEeeMap = await Wallets.instance.updateEeeSyncRecord(Wallets.instance.nowWallet.nowChain.chainAddress,
            Chain.chainTypeToInt(Wallets.instance.nowWallet.nowChain.chainType), endBlockHeight, endBlockHash);
        print("updateEeeMap is ===>" + updateEeeMap.toString() + "|| endBlockHeight.toString()" + endBlockHeight.toString());
        if (!_isMapStatusOk(updateEeeMap)) {
          //todo 停止整个同步记录流程
        }
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
  void deactivate() {
    super.deactivate();
  }
}
