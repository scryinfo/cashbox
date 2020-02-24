import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/tx_model/eth_transaction_model.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Future txListFuture;
  List<Digit> walletDataList = [];
  List<Digit> showDataList = [];
  List<EthTransactionModel> ethTxListModel = [];
  String balanceInfo = "0.00";
  String fromAddress = "";
  //String fromAddress = "0xa4512ca7618d8d12a30C28979153aB09809ED7fD";
  String contractAddress = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    {
      // fromAddress = Provider.of<TransactionProvide>(context).fromAddress;
      // contractAddress = Provider.of<TransactionProvide>(context).contractAddress;
    }
    getBalanceData();
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
          centerTitle: S.of(context).transaction_history,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildTxHistoryWidget(),
        ),
      ),
    );
  }

  getBalanceData() async {
    try {
      if(contractAddress.trim()==""){
        balanceInfo = await loadEthBalance(fromAddress);
      }else{
        balanceInfo = await loadErc20Balance(fromAddress,contractAddress);
      }
      print("balanceInfo===>" + balanceInfo.toString());
    } catch (onError) {
      print("onError===>" + "$onError");
      this.balanceInfo = "0";
    }
    setState(() {
      this.balanceInfo = balanceInfo;
    });
  }

  Future<List<EthTransactionModel>> getTxListData() async {
    try {
      if(contractAddress.trim()==""&&(fromAddress.trim()!="")){
        ethTxListModel = await loadEthTxHistory(fromAddress);
      }else if(fromAddress.trim()!=""){
        ethTxListModel = await loadErc20TxHistory(fromAddress,contractAddress);
      }else{
        Fluttertoast.showToast(msg: "地址信息为空，请再检查");
      }
      print("ethTxListModel.length.===>" + ethTxListModel.length.toString());
    } catch (onError) {
      print("onError===>" + "$onError");
    }
    print("getData() ethTxListModel=====================>" + ethTxListModel.length.toString());
    setState(() {
      this.ethTxListModel = ethTxListModel;
    });
    return ethTxListModel;
  }

  Widget _buildTxHistoryWidget() {
    return Container(
      width: ScreenUtil().setWidth(90),
      child: Column(
        children: <Widget>[
          Gaps.scaleVGap(1),
          _buildDigitBalanceWidget(),
          Gaps.scaleVGap(7),
          _buildDigitTxTitleWidget(),
          Gaps.scaleVGap(5),
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
          Gaps.scaleHGap(5),
          Container(
            alignment: Alignment.centerLeft,
            width: ScreenUtil().setWidth(23),
            height: ScreenUtil().setHeight(8),
            child: Text(
              balanceInfo ?? "0.00" ,
              textAlign:  TextAlign.start,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(4),
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Gaps.scaleHGap(0.5),
          Container(
            width: ScreenUtil().setWidth(8),
            child: Text(
              "ETH",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(3.5),
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Gaps.scaleHGap(0.5),
          Container(
            width: ScreenUtil().setWidth(15),
            child: Text(
              "≈" + "\$" + "6300.111311111",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(3),
                color: Colors.lightBlueAccent,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gaps.scaleHGap(10),
          Container(
            //height: ScreenUtil().setHeight(8),
            child: FlatButton(
              color: Color.fromRGBO(26, 141, 198, 0.2),
              onPressed: () {
                NavigatorUtils.push(context, Routes.transferEthPage);
              },
              child: Text(
                S.of(context).transfer,
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
                    width: ScreenUtil().setWidth(18),
                    child: Text(
                      S.of(context).transaction_history,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: ScreenUtil.instance.setSp(3.5),
                      ),
                    ),
                  ),
                  Gaps.scaleHGap(45),
                  Container(
                    child: Opacity(
                      opacity: 0,  //todo 通过时间筛选交易，暂不显示
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
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
            child: FutureBuilder(
              future: txListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(S.of(context).fail_to_load_data_hint);
                }
                if (snapshot.hasData) {
                  return Container(
                    child: _makeRefreshWidgets(snapshot),
                  );
                } else {
                  return Text(
                    "数据加载中...",
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
            childCount: ethTxListModel.length,
          ),
        ),
      ],
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print("onLoad");
          setState(() {
            //todo add Data
          });
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
          print("click tap is " + index.toString());

          Provider.of<TransactionProvide>(context)
            ..empty()
            ..setFromAddress(ethTxListModel[index].from)
            ..setToAddress(ethTxListModel[index].to)
            ..setValue(ethTxListModel[index].value)
            ..setBackup(ethTxListModel[index].input)
            ..setGas(ethTxListModel[index].gas)
            ..setGasPrice(ethTxListModel[index].gasPrice)
            ..setGasUsed(ethTxListModel[index].gasUsed)
            ..setTimeStamp(ethTxListModel[index].timeStamp)
            ..setNonce(ethTxListModel[index].nonce);

          NavigatorUtils.push(context, Routes.transactionEeeDetailPage);
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
                        ethTxListModel[index].value,
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
                        ethTxListModel[index].hash,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: ScreenUtil.instance.setSp(3),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        ethTxListModel[index].isError,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.instance.setSp(2.5),
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
                          color: Colors.white,
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
}
