import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
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

class DigitListPage extends StatefulWidget {
  @override
  _DigitListPageState createState() => _DigitListPageState();
}

class _DigitListPageState extends State<DigitListPage> {
  static int singleDigitCount = 20; //单页面显示20条数据，一次下拉刷新更新20条
  Wallet nowWalletM;
  Chain nowChain;
  String nowChainAddress = "";
  List<Digit> nowChainDigitsList = [];
  List<Digit> displayDigitsList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    nowWalletM = Wallets.instance.nowWallet;
    if (nowWalletM != null) {
      nowChain = nowWalletM.nowChain;
    }
    if (nowChain != null) {
      nowChainDigitsList = nowChain.digitsList;
    }
    await loadDisplayDigitListData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(120),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('digit_list_title'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: Column(
          children: <Widget>[Gaps.scaleVGap(5), _digitListAreaWidgets()],
        )),
      ),
    );
  }

  Widget _digitListAreaWidgets() {
    return Container(
        height: ScreenUtil().setHeight(78),
        width: ScreenUtil().setWidth(90),
        child: Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(3)),
          child: _digitListWidgets(),
        ));
  }

  //代币列表layout
  Widget _digitListWidgets() {
    return EasyRefresh.custom(
      footer: BallPulseFooter(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                child: _makeDigitListItem(index),
              );
            },
            childCount: displayDigitsList.length,
          ),
        ),
      ],
      onLoad: () async {
        //代币列表栏，下拉 刷新||加载 数据。
        await Future.delayed(
          Duration(seconds: 2),
          () {
            setState(() {
              if (displayDigitsList.length < nowChainDigitsList.length) {
                // 从JNI加载的数据(nowChain.digitList),还有没显示完的，继续将nowChainDigitsList剩余数据，
                // 添加到 displayDigitsList里面做展示
                loadDisplayDigitListData(); //下拉刷新的时候，加载新digit到displayDigitsList
              } else {
                // todo 2.0。 功能：加载代币列表，可选择添加erc20代币。 代币列表下拉刷新。
                // 继续调jni获取，或者提示已经没数据了。 根据是否jni分页处理来决定。
                Fluttertoast.showToast(msg: translate('load_finish_wallet_digit').toString());
                return;
              }
            });
          },
        );
      },
    );
  }

  //每个代币的layout
  Widget _makeDigitListItem(index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(17),
          margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(3),
            right: ScreenUtil().setWidth(3),
          ),
          child: GestureDetector(
            onTap: () {
              try {
                Provider.of<TransactionProvide>(context)
                  ..setDigitName(displayDigitsList[index].shortName)
                  ..setBalance(displayDigitsList[index].balance)
                  ..setDecimal(displayDigitsList[index].decimal)
                  ..setFromAddress(nowChain.chainAddress)
                  ..setChainType(nowChain.chainType)
                  ..setContractAddress(displayDigitsList[index].contractAddress ?? "");
              } catch (e) {
                print("digit_list_page点击传值出现位置错误===>" + e.toString());
                LogUtil.e("digit_list_page", e.toString());
              }
              NavigatorUtils.push(context, Routes.transactionHistoryPage);
            },
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/images/ic_eth.png"),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(3),
                    left: ScreenUtil().setHeight(3),
                  ),
                  width: ScreenUtil().setWidth(30),
                  height: ScreenUtil().setHeight(10),
                  child: Text(
                    displayDigitsList[index].shortName ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(3.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: ScreenUtil().setWidth(75),
          height: ScreenUtil().setHeight(0.1),
          child: CustomPaint(
            foregroundPainter: MySeparatorLine(
              lineColor: Colors.blueAccent,
              width: ScreenUtil().setWidth(75),
            ),
          ),
        )
      ],
    );
  }

  Future<List<Digit>> loadDisplayDigitListData() async {
    if (displayDigitsList.length == 0) {
      //没有展示数据
      if (nowChainDigitsList.length < singleDigitCount) {
        //加载到的不够一页，全展示
        addDigitToDisplayList(nowChainDigitsList.length);
      } else {
        //超一页，展示singleDigitCount个。
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //有展示数据，继续往里添加
      if (nowChainDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //剩余的超过一页
        addDigitToDisplayList(singleDigitCount);
      } else {
        //剩余的不够一页，全给加入进去。
        addDigitToDisplayList(nowChainDigitsList.length - displayDigitsList.length);
      }
    }
    return displayDigitsList;
  }

  List<Digit> addDigitToDisplayList(int targetCount) {
    for (var i = displayDigitsList.length; i < targetCount; i++) {
      var digitRate = DigitRate();
      Digit digit = EthDigit();
      print("addDigitToDisplayList nowChainDigitsList[i].balance===>" + nowChainDigitsList[i].balance.toString());
      digit
        ..chainId = nowChainDigitsList[i].chainId
        ..decimal = nowChainDigitsList[i].decimal
        ..shortName = nowChainDigitsList[i].shortName
        ..fullName = nowChainDigitsList[i].fullName
        ..balance = nowChainDigitsList[i].balance
        ..contractAddress = nowChainDigitsList[i].contractAddress
        ..address = nowChainDigitsList[i].address
        ..digitRate = digitRate;
      displayDigitsList.add(digit);
    }
    return displayDigitsList;
  }
}
