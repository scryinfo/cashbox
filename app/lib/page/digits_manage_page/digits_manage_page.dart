import 'package:app/generated/i18n.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/wallets.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:app/widgets/restart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DigitsManagePage extends StatefulWidget {
  @override
  _DigitsManagePageState createState() => _DigitsManagePageState();
}

class _DigitsManagePageState extends State<DigitsManagePage> {
  static int singleDigitCount = 20; //单页面显示20条数据，一次下拉刷新更新20条
  List<Digit> nowChainDigitsList = []; //当前链的代币列表
  List<Digit> serverDigitsList = []; //服务器接口上的代币列表
  List<Digit> allDisplayDigitsList = []; //界面所有可展示的代币： nowChainDigitsList + serverDigitsList
  List<Digit> displayDigitsList = []; //页面展示的代币列表数据
  Widget checkedWidget = Image.asset("assets/images/ic_checked.png");
  Widget addWidget = Image.asset("assets/images/ic_plus.png");

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    nowChainDigitsList = Wallets.instance.nowWallet.nowChain.digitsList;
    addToAllDisplayDigitsList(nowChainDigitsList);
    await loadDisplayDigitListData(); //先显示本地已有的代币
    await loadServerDigitListData(); //服务器可信任代币列表
  }

  addToAllDisplayDigitsList(List<Digit> newDigitList) {
    newDigitList.forEach((element) {
      if (!allDisplayDigitsList.contains(element.shortName == element.shortName)) {
        allDisplayDigitsList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(120),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  backAndReloadData();
                },
                child: Image.asset("assets/images/ic_back.png")),
            backgroundColor: Colors.transparent,
            elevation: 0,
            brightness: Brightness.light,
            centerTitle: true,
            title: Text(
              S.of(context).digit_list_title ?? "",
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Container(
              child: Column(
            children: <Widget>[Gaps.scaleVGap(5), _digitListAreaWidgets()],
          )),
        ),
      ),
      onWillPop: () {
        backAndReloadData();
        Navigator.pop(context);
      },
    );
  }

  Widget _digitListAreaWidgets() {
    return Container(
      height: ScreenUtil().setHeight(78),
      width: ScreenUtil().setWidth(90),
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(3)),
        child: _digitListWidgets(),
      ),
    );
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
                // 从JNI加载的数据(nowWalletM.getNowChainM().digitList),还有没显示完的，继续将nowChainDigitsList剩余数据，
                // 添加到 displayDigitsList里面做展示
                loadDisplayDigitListData(); //下拉刷新的时候，加载新digit到displayDigitsList
              } else {
                // todo 2.0。 功能：加载代币列表，可选择添加erc20代币。 代币列表下拉刷新。
                // 继续调jni获取，或者提示已经没数据了。 根据是否jni分页处理来决定。
                Fluttertoast.showToast(msg: S.of(context).load_finish_wallet_digit.toString());
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
              onTap: () async {
                var isExecutorSuccess = false;
                if (displayDigitsList[index].isVisible) {
                  isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.hideDigit(displayDigitsList[index]);
                } else {
                  isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.showDigit(displayDigitsList[index]);
                  //todo 确认要保存到本地digit模型中
                  Wallets.instance.nowWallet.nowChain.addDigit(Wallets.instance.nowWallet.walletId, displayDigitsList[index]);
                }
                if (isExecutorSuccess) {
                  Wallets.instance.nowWallet.nowChain.digitsList.forEach((element) {
                    if (element.shortName == displayDigitsList[index].shortName) {
                      element.isVisible = displayDigitsList[index].isVisible;
                    }
                    print("digit_manage_page digit.shortname===>" + element.shortName + "||element.isVisible===>" + element.isVisible.toString());
                  });
                  setState(() {
                    displayDigitsList[index].isVisible = displayDigitsList[index].isVisible;
                  });
                } else {
                  Fluttertoast.showToast(msg: "执行状态保存，出问题了");
                }
              },
              child: Container(
                width: ScreenUtil().setWidth(80),
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(10),
                      height: ScreenUtil().setWidth(10),
                      child: displayDigitsList[index].isVisible ? checkedWidget : addWidget,
                    ),
                    Container(
                      width: ScreenUtil().setWidth(10),
                      height: ScreenUtil().setWidth(10),
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
              )),
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

  //
  backAndReloadData() {
    // enter page reload  nowWallet.nowChain.digitList
    RestartWidget.restartApp(context); //todo 方式待优化
    //NavigatorUtils.push(context, '${Routes.ethPage}?isForceLoadFromJni=true', clearStack: true); //重新加载walletList
  }

  Future<List<Digit>> loadServerDigitListData() async {}

  Future<List<Digit>> loadDisplayDigitListData() async {
    if (displayDigitsList.length == 0) {
      //没有展示数据
      if (allDisplayDigitsList.length < singleDigitCount) {
        //加载到的不够一页，全展示
        addDigitToDisplayList(allDisplayDigitsList.length);
      } else {
        //超一页，展示singleDigitCount个。
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //有展示数据，继续往里添加
      if (allDisplayDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //剩余的超过一页
        addDigitToDisplayList(singleDigitCount);
      } else {
        //剩余的不够一页，全给加入进去。
        addDigitToDisplayList(allDisplayDigitsList.length - displayDigitsList.length);
      }
    }
    return displayDigitsList;
  }

  List<Digit> addDigitToDisplayList(int targetCount) {
    for (var i = displayDigitsList.length; i < targetCount; i++) {
      var digitRate = DigitRate();
      Digit digit = EthDigit();
      print("addDigitToDisplayList allDisplayDigitsList[i].balance===>" + allDisplayDigitsList[i].balance.toString());
      digit
        ..chainId = allDisplayDigitsList[i].chainId
        ..digitId = allDisplayDigitsList[i].digitId
        ..decimal = allDisplayDigitsList[i].decimal
        ..shortName = allDisplayDigitsList[i].shortName
        ..fullName = allDisplayDigitsList[i].fullName
        ..balance = allDisplayDigitsList[i].balance
        ..contractAddress = allDisplayDigitsList[i].contractAddress
        ..address = allDisplayDigitsList[i].address
        ..isVisible = allDisplayDigitsList[i].isVisible
        ..digitRate = digitRate;
      displayDigitsList.add(digit);
    }
    return displayDigitsList;
  }
}
