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
  static int singleDigitCount = 20; //Display 20 items of data on a single page, update and update 20 items at a time
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

  //Token list layout
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
        //Token list bar, pull down Refresh||Load data.
        await Future.delayed(
          Duration(seconds: 2),
          () {
            setState(() {
              if (displayDigitsList.length < nowChainDigitsList.length) {
                // The data loaded from JNI (nowChain.digitList), there are still not displayed, continue to the remaining data of nowChainDigitsList,
                // Add to displayDigitsList for display
                loadDisplayDigitListData(); //When pull down to refresh, load new digit to displayDigitsList
              } else {
                // todo 2.0. Function: load token list, optionally add erc20 tokens. The token list is refreshed by drop-down.
                // Continue to adjust jni to obtain, or suggest that there is no data. Decide according to whether or not jni paging processing.
                Fluttertoast.showToast(msg: translate('load_finish_wallet_digit').toString());
                return;
              }
            });
          },
        );
      },
    );
  }

  //Layout of each token
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
              switch (Wallets.instance.nowWallet.nowChain.chainType) {
                case ChainType.ETH:
                case ChainType.ETH_TEST:
                  NavigatorUtils.push(context, Routes.ethChainTxHistoryPage);
                  break;
                case ChainType.EEE:
                case ChainType.EEE_TEST:
                  NavigatorUtils.push(context, Routes.eeeChainTxHistoryPage);
                  break;
                default:
                  print("未知链类型");
                  break;
              }
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
                      fontSize: ScreenUtil().setSp(3.5),
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
      //No display data
      if (nowChainDigitsList.length < singleDigitCount) {
        //Not enough pages loaded, full display
        addDigitToDisplayList(nowChainDigitsList.length);
      } else {
        //Super page, showing singleDigitCount.
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //There are display data, continue to add
      if (nowChainDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //More than one page left
        addDigitToDisplayList(singleDigitCount);
      } else {
        //If there is not enough one page left, all will be added.
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
