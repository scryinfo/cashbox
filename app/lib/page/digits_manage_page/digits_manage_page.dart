import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallets.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:app/widgets/restart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

class DigitsManagePage extends StatefulWidget {
  @override
  _DigitsManagePageState createState() => _DigitsManagePageState();
}

class _DigitsManagePageState extends State<DigitsManagePage> {
  List<Digit> displayDigitsList = []; //页面展示的代币=nowWallet.nowChain.digitsList(本链已有，visible显示在前面) + nativeAuthDigitsList(分页认证代币)
  Widget checkedWidget = Image.asset("assets/images/ic_checked.png");
  Widget addWidget = Image.asset("assets/images/ic_plus.png");
  int nativeDigitIndex = 0;
  int onePageOffSet = 50; //单页面显示20条数据，一次下拉刷新更新20条
  int maxAuthTokenCount = 0; //本地authToken总个数
  bool isLoadAuthDigitFinish = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    addToDisplayDigitsList(Wallets.instance.nowWallet.nowChain.getVisibleDigitList()); //1、可见代币显示在前面 isVisible = true;
    addToDisplayDigitsList(Wallets.instance.nowWallet.nowChain.digitsList); //2、本地已有代币列表
    print("initData displayDigitsList.length====>" + displayDigitsList.length.toString());
    {
      //todo 随机策略, 检查服务器端 可信代币列表 版本，更新本地代币列表。
      //todo 替换 ===》 2、本地已有代币列表
      //await updateNativeDigitListVersion(loadServerDigitListData());//服务器可信任代币列表
      var tempNativeAuthDigitsList = await getAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);

      addToDisplayDigitsList(tempNativeAuthDigitsList);
    }
    setState(() {
      this.displayDigitsList = displayDigitsList;
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
            actions: <Widget>[
              Container(
                width: ScreenUtil.instance.setWidth(10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        NavigatorUtils.push(context, Routes.searchDigitPage);
                      },
                      child: Image.asset("assets/images/ic_search.png"),
                    )
                  ],
                ),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
              ),
              child: Column(
                children: <Widget>[Gaps.scaleVGap(1), _digitListAreaWidgets()],
              )),
        ),
      ),
      onWillPop: () {
        backAndReloadData();
        Navigator.pop(context);
        return Future.value(true);
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
          () async {
            if (isLoadAuthDigitFinish) {
              Fluttertoast.showToast(msg: S.of(context).load_finish_wallet_digit.toString());
              return;
            }
            List tempList = await getAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);
            if (tempList == null || tempList.length == 0) {
              Fluttertoast.showToast(msg: S.of(context).load_finish_wallet_digit.toString());
              return;
            }
            addToDisplayDigitsList(tempList);
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

  updateNativeDigitListVersion(String jsonString) async {
    //todo test api code
    var obj = [
      {
        "id": "eth_chain_ddd_test0",
        "symbol": "parker0",
        "name": "scryinfo parker0",
        "publisher": "scryinfo",
        "project": "scryinfo",
        "logoUrl": "scry.info",
        "logoBytes": "parker",
        "decimal": 18,
        "gasLimit": 523654,
        "contract": "0x2aef987",
        "acceptId": "0x3aef987",
        "chainType": "ETH",
        "mark": "test",
        "updateTime": 158748557,
        "createTime": 158965444,
        "version": 12,
      },
    ];
    String jsonString = convert.jsonEncode(obj);
    var updateMap = await Wallets.instance.updateAuthDigitList(jsonString);
    print("updateMap[status]=====>" + updateMap["status"].toString());
    print("updateMap[isUpdateAuthDigit]=====>" + updateMap["isUpdateAuthDigit"].toString());
  }

  //加入到展示列表displayDigitsList中
  addToDisplayDigitsList(List<Digit> newDigitList) {
    for (num i = 0; i < newDigitList.length; i++) {
      var element = newDigitList[i];
      if (element.contractAddress != null && element.contractAddress.isNotEmpty) {
        //erc20
        bool isExistErc20 = false;
        for (num index = 0; index < displayDigitsList.length; index++) {
          var digit = displayDigitsList[index];
          if ((digit.contractAddress != null) && (element.contractAddress != null) && (digit.contractAddress == element.contractAddress)) {
            print("digit.contractAddress=>" + digit.contractAddress + "||element.contractAddress===>" + element.contractAddress);
            isExistErc20 = true;
            break;
          }
        }
        print("isExistErc20 ===>" + isExistErc20.toString());
        if (!isExistErc20) {
          displayDigitsList.add(element);
        }
      } else {
        bool isExistDigit = false;
        for (num index = 0; index < displayDigitsList.length; index++) {
          var digit = displayDigitsList[index];
          if ((digit.shortName != null) && (element.shortName != null) && (digit.shortName == element.shortName)) {
            print("digit.shortName=>" + digit.shortName + "||element.shortName===>" + element.shortName);
            isExistDigit = true;
            break;
          }
        }
        print("isExistDigit ===>" + isExistDigit.toString());
        if (!isExistDigit) {
          displayDigitsList.add(element);
        }
      }
    }
  }

  Future<List<Digit>> getAuthDigitList(Chain chain, int nativeDigitIndex, int onePageOffSet) async {
    Map nativeAuthMap = await Wallets.instance.getNativeAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);
    if (nativeAuthMap == null) {
      print("加载本地认证列表失败===》");
      return [];
    }
    maxAuthTokenCount = nativeAuthMap["count"];
    List tempDigitsList = nativeAuthMap["authDigit"];
    if (onePageOffSet == tempDigitsList.length) {
      nativeDigitIndex = nativeDigitIndex + onePageOffSet;
      print("还有未加载完的认证代币，分页是下标是：===》" + nativeDigitIndex.toString());
    } else {
      nativeDigitIndex = nativeDigitIndex + tempDigitsList.length;
      print("认证列表的代币，加载完了 下标===》" + nativeDigitIndex.toString());
      isLoadAuthDigitFinish = true;
    }
    if (tempDigitsList == null || tempDigitsList.length == 0) {
      return [];
    }
    return tempDigitsList;
  }

  backAndReloadData() {
    RestartWidget.restartApp(context); //由于widget模式，虚拟dom与activity区分。不走生命周期，重改key，重新加载
  }
}
