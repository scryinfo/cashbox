import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallet.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchDigitPage extends StatefulWidget {
  @override
  _SearchDigitPageState createState() => _SearchDigitPageState();
}

class _SearchDigitPageState extends State<SearchDigitPage> {
  List<Digit> nowChainDigitsList = [];
  List<Digit> displayDigitsList = [];
  Wallet nowWalletM;
  Chain nowChain;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(120),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: _searchInputWidget(), backgroundColor: Colors.transparent, actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil.instance.setWidth(10),
                child: Text("取消"),
              )
            ],
          )
        ]),
        body: Container(
            child: Column(
          children: <Widget>[Gaps.scaleVGap(5), _digitListAreaWidgets()],
        )),
      ),
    );
  }

  Widget _searchInputWidget() {
    return Container(
      width: ScreenUtil.instance.setWidth(60),
      //修饰黑色背景与圆角
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey, width: ScreenUtil.instance.setWidth(1)), //灰色的一层边框
        color: Colors.grey,
        borderRadius: new BorderRadius.all(new Radius.circular(ScreenUtil.instance.setWidth(3))),
      ),
      alignment: Alignment.center,
      height: ScreenUtil.instance.setHeight(8),
      child: buildTextField(),
    );
  }

  Widget buildTextField() {
    return Container(
        child: TextField(
            cursorColor: Colors.white, //设置光标
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only( bottom: ScreenUtil.instance.setHeight(2.5)),
              border: InputBorder.none,
              icon: IconButton(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/images/ic_search.png",
                    ),
                  ),
                  onPressed: () {
                    print("click search icon");
                  }),
              hintText: "digitName",
              hintStyle: new TextStyle(fontSize: ScreenUtil.instance.setSp(3), color: Colors.white),
            ),
            //文本对齐方式(即光标初始位置)
            textAlign: TextAlign.start,
            style: new TextStyle(fontSize: ScreenUtil.instance.setSp(3), color: Colors.white)));
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
            // setState(() {
            //   if (displayDigitsList.length < nowChainDigitsList.length) {
            //     // 从JNI加载的数据(nowChain.digitList),还有没显示完的，继续将nowChainDigitsList剩余数据，
            //     // 添加到 displayDigitsList里面做展示
            //     loadDisplayDigitListData(); //下拉刷新的时候，加载新digit到displayDigitsList
            //   } else {
            //     // todo 2.0。 功能：加载代币列表，可选择添加erc20代币。 代币列表下拉刷新。
            //     // 继续调jni获取，或者提示已经没数据了。 根据是否jni分页处理来决定。
            //     Fluttertoast.showToast(msg: S.of(context).load_finish_wallet_digit.toString());
            //     return;
            //   }
            // });
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
}
