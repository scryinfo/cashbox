import 'package:app/model/Digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/resources.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Future future;
  List<Digit> walletDataList = [];
  List<Digit> showDataList = [];

  @override
  void initState() {
    super.initState();
    future = getData(); //todo initData
  }

  Future<List<Digit>> getData() async {
    //todo mock data to test
    for (var i = 0; i < 10; i++) {
      Digit digit = Digit("chainId001");
      digit.shortName = "ETH" + i.toString();
      print("digit.shortName=>" + digit.shortName);
      digit.fullName = "ETHereum";
      digit.balance = "15";
      digit.money = "666";
      var digitRate = DigitRate();
      digitRate.volume = 0.035;
      digitRate.changeHourly = 0.096;
      digit.digitRate = digitRate;
      showDataList.add(digit);
    }
    return showDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(120),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "交易记录",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: _buildTxHistoryWidget(),
        ),
      ),
    );
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
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(20.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Gaps.scaleHGap(3),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(25),
            height: ScreenUtil().setHeight(8),
            child: Text(
              "6462314.0",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
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
                fontSize: 16,
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
                fontSize: 12,
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
                NavigatorUtils.push(context, Routes.transferEeePage);
              },
              child: Text(
                "转账",
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
          Gaps.scaleHGap(6),
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
                      "交易记录",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Gaps.scaleHGap(45),
                  Container(
                    child: Text(
                      "2018.07",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.end,
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
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(5),
                right: ScreenUtil().setWidth(5)),
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("数据加载失败,请查看网络状况，可尝试下拉刷新");
                }
                if (snapshot.hasData) {
                  return Container(
                    child: _makeRefreshWidgets(snapshot),
                  );
                } else {
                  return Text(
                    "暂时没有历史交易记录",
                    style: TextStyle(color: Colors.white),
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
            childCount: showDataList.length,
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
                        showDataList[index].shortName,
                        style:
                            TextStyle(color: Colors.greenAccent, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        "0xD235654678891316546516879",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 13),
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
                        "* 发送中",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Gaps.scaleHGap(30),
                    Container(
                      width: ScreenUtil().setWidth(30),
                      child: Text(
                        "2019.07.01",
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
