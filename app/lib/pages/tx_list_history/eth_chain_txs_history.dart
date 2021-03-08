import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:logger/logger.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';

class EthChainTxsHistoryPage extends StatefulWidget {
  @override
  _EthChainTxsHistoryPageState createState() => _EthChainTxsHistoryPageState();
}

class _EthChainTxsHistoryPageState extends State<EthChainTxsHistoryPage> {
  Future txListFuture;
  List<Digit> walletDataList = [];
  List<Digit> showDataList = [];
  List<EthTransactionModel> ethTxListModel = [];
  String balanceInfo = "0.00";
  String moneyInfo = "0.00";
  String digitName = "";
  String fromAddress = "";
  String contractAddress = "";
  ChainType chainType = ChainType.UNKNOWN;
  int displayTxOffset = 0;
  int refreshAddCount = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    {
      fromAddress = Provider.of<TransactionProvide>(context).fromAddress;
      contractAddress = Provider.of<TransactionProvide>(context).contractAddress;
      digitName = Provider.of<TransactionProvide>(context).digitName;
      balanceInfo = Provider.of<TransactionProvide>(context).balance;
      moneyInfo = Provider.of<TransactionProvide>(context).money;
      chainType = Provider.of<TransactionProvide>(context).chainType;
    }
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
                      fontSize: ScreenUtil().setSp(4.2),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: digitName ?? "*",
                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(3.5), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "≈" + (Rate.instance.getNowLegalCurrency() ?? "") + " " + (moneyInfo ?? "0.0"),
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: ScreenUtil().setSp(3.5), fontStyle: FontStyle.normal),
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
                  case ChainType.ETH:
                  case ChainType.ETH_TEST:
                    NavigatorUtils.push(context, Routes.transferEthPage);
                    break;
                  case ChainType.EEE:
                  case ChainType.EEE_TEST:
                    NavigatorUtils.push(context, Routes.transferEeePage);
                    break;
                  case ChainType.BTC_TEST:
                  case ChainType.BTC:
                    NavigatorUtils.push(context, Routes.transferBtcPage);
                    break;
                  default:
                    NavigatorUtils.push(context, Routes.transferEthPage);
                    break;
                }
              },
              child: Text(
                translate('transfer'),
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: ScreenUtil().setSp(3.5),
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
                        fontSize: ScreenUtil().setSp(3.5),
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
                  return Text(translate('fail_to_load_data_hint'));
                }
                if (snapshot.hasData) {
                  if (ethTxListModel.length == 0) {
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
                      fontSize: ScreenUtil().setSp(4),
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
            childCount: ethTxListModel.length,
          ),
        ),
      ],
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () async {
          if (this.ethTxListModel.length < displayTxOffset) {
            //Shown, less loaded than the last request, indicating that it is gone
            Fluttertoast.showToast(msg: translate('finish_load_tx_history').toString());
            return;
          }
          var ethTxListModel = await getTxListData();
          if (ethTxListModel != null && ethTxListModel.length > 0) {
            setState(() {
              this.ethTxListModel = ethTxListModel;
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
          context.read<TransactionProvide>()
            ..emptyDataRecord()
            ..setFromAddress(ethTxListModel[index].from)
            ..setToAddress(ethTxListModel[index].to)
            ..setValue(ethTxListModel[index].value)
            ..setHash(ethTxListModel[index].hash)
            ..setBackup(ethTxListModel[index].input)
            ..setGas(ethTxListModel[index].gas)
            ..setGasPrice(ethTxListModel[index].gasPrice)
            ..setGasUsed(ethTxListModel[index].gasUsed)
            ..setTimeStamp(ethTxListModel[index].timeStamp)
            ..setNonce(ethTxListModel[index].nonce);
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
                        ethTxListModel[index].value ?? "",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: ScreenUtil().setSp(3.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        ethTxListModel[index].hash,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: ScreenUtil().setSp(3),
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
                        ethTxListModel[index].isError ?? "",
                        style: TextStyle(
                          color: (ethTxListModel[index].isError == translate('tx_success')) ? Colors.white70 : Colors.redAccent,
                          fontSize: ScreenUtil().setSp(2.5),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        ethTxListModel[index].timeStamp,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: ScreenUtil().setSp(2.5),
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

  Future<List<EthTransactionModel>> getTxListData() async {
    displayTxOffset = displayTxOffset + refreshAddCount; //Increment refreshAddCount each time
    try {
      if ((contractAddress == null || contractAddress.trim() == "") && (fromAddress.trim() != "")) {
        ethTxListModel = await loadEthTxHistory(context, fromAddress, chainType, offset: displayTxOffset.toString());
      } else if (fromAddress.trim() != "") {
        ethTxListModel = await loadErc20TxHistory(context, fromAddress, contractAddress, chainType, offset: displayTxOffset.toString());
      } else {
        Fluttertoast.showToast(msg: translate('address_empty').toString());
      }
    } catch (onError) {
      Logger().e("getTxListData error ===>", "$onError");
    }
    if (ethTxListModel == null || ethTxListModel.length == 0) {
      ethTxListModel = [];
    }
    setState(() {
      this.ethTxListModel = ethTxListModel;
    });
    return ethTxListModel;
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<TransactionProvide>().emptyDataRecord();
  }
}
