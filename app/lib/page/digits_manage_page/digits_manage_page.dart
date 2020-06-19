import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/net_util.dart';
import 'package:app/provide/server_config_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:app/widgets/restart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

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
    print("initData() displayDigitsList.length====>" + displayDigitsList.length.toString());
    {
      /*   todo 1.0 暂时不做，写死预置代币数据
      var spUtil = await SharedPreferenceUtil.instance;
      var localDigitsVersion = spUtil.getString(GlobalConfig.authDigitsVersionKey);
      var serverDigitsVersion = Provider.of<ServerConfigProvide>(context).authDigitListVersion;
      var serverDigitsIp = Provider.of<ServerConfigProvide>(context).authDigitListIp;
      var localDigitListIP = spUtil.getString(GlobalConfig.authDigitsIpKey);
      if (localDigitsVersion == null || localDigitsVersion == "") {
        //本地没有认证代币版本号，没加载过
        if (serverDigitsIp != null && serverDigitsIp != "") {
          var param = await loadServerDigitsData(serverDigitsIp);
          await updateNativeAuthDigitList(param); //保存代币：服务器可信任代币列表ip
        } else {
          var param = await loadServerDigitsData(localDigitListIP);
          await updateNativeAuthDigitList(param); //保存代币：本地初始记录的代币列表ip
        }
        spUtil.setString(GlobalConfig.authDigitsVersionKey, serverDigitsVersion); //保存server端，拿到的版本号Version
      } else {
        //本地有版本号，检查更新,且有服务端版本号信息
        if (serverDigitsVersion != null && serverDigitsVersion != "") {
          if (double.parse(localDigitsVersion) < double.parse(serverDigitsVersion)) {
            //server端有新版本出现
            //todo 随机策略, 检查服务器端 可信代币列表 版本，更新本地代币列表
            //todo 替换 ======> 2、本地已有代币列表
            if (serverDigitsIp != null && serverDigitsIp != "") {
              //有服务端代币ip地址
              var param = await loadServerDigitsData(serverDigitsIp);
              await updateNativeAuthDigitList(param); //保存代币：服务器可信任代币列表ip
              spUtil.setString(GlobalConfig.authDigitsVersionKey, serverDigitsVersion); //保存server端，拿到的版本号
            }
          }
        }
      }*/
      {
        //todo 1.0 写死，预置代币
        var digitParam =
            '[{"contractAddress":"0x9F5F3CFD7a32700C93F971637407ff17b91c7342","shortName":"DDD","fullName":"DDD","urlImg":"locale://ic_ddd.png","id":"3","decimal":"","chainType":"ETH"}]';
        await updateNativeAuthDigitList(digitParam);
        var addDigitMap = await Wallets.instance.addDigitToChainModel(Wallets.instance.nowWallet.walletId, Wallets.instance.nowWallet.nowChain, "3");
        int status = addDigitMap["status"];
        if (status == null || status != 200) {
          Fluttertoast.showToast(msg: "执行状态保存，出问题了,请重新尝试");
          print("addDigitToChainModel failure==" + addDigitMap["message"]);
        } else {
          print("addDigitToChainModel successful==");
        }
      }
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
                  NavigatorUtils.goBack(context);
                },
                child: Image.asset("assets/images/ic_back.png")),
            backgroundColor: Colors.transparent,
            elevation: 0,
            brightness: Brightness.light,
            centerTitle: true,
            title: Text(
              translate('digit_list_title') ?? "",
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
        NavigatorUtils.goBack(context);
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
              Fluttertoast.showToast(msg: translate('load_finish_wallet_digit').toString());
              return;
            }
            List tempList = await getAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);
            if (tempList == null || tempList.length == 0) {
              Fluttertoast.showToast(msg: translate('load_finish_wallet_digit').toString());
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
                  //不可见，执行可见show操作
                  bool isDigitExist = false;
                  Wallets.instance.nowWallet.nowChain.digitsList.forEach((element) {
                    if (element.digitId == displayDigitsList[index].digitId) {
                      isDigitExist = true;
                    }
                  });
                  if (isDigitExist) {
                    isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.showDigit(displayDigitsList[index]);
                  } else {
                    // todo 保存 或者 更改显示状态 接口功能待验证
                    // 保存到本地Chain下的digit中 （底层 + model）
                    var addDigitMap = await Wallets.instance.addDigitToChainModel(
                        Wallets.instance.nowWallet.walletId, Wallets.instance.nowWallet.nowChain, displayDigitsList[index].digitId);
                    int status = addDigitMap["status"];
                    if (status == null || status != 200) {
                      Fluttertoast.showToast(msg: "执行状态保存，出问题了,请重新尝试");
                      print("addDigitToChainModel failure==" + addDigitMap["message"]);
                    } else {
                      isExecutorSuccess = true;
                    }
                  }
                }
                if (isExecutorSuccess) {
                  //底层执行成功，上层刷新 显示数据
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

  Future<String> loadServerDigitsData(String authUrl) async {
    if (authUrl == null || authUrl.isEmpty) {
      print("loadServerDigitsData authUrl is null===>");
      return "";
    }
    try {
      var result = await request(authUrl);
      if (result["code"] != null && result["code"] == 0) {
        print("loadServerDigitsData result.code=>" + convert.jsonEncode(result["data"]));
        //return convert.jsonEncode(result["data"]).toString();
        //TODO 测试用
        return '[{"contractAddress":"0xaa638fca332190b63be1605baefde1df0b3b031e","shortName":"DDD","fullName":"DDD","urlImg":"locale://ic_ddd.png","id":"3","decimal":"","chainType":"ETH"}]';
        //return "";
      }
    } catch (e) {
      print("loadServerDigitsData error is ===>" + e.toString());
      return null;
    }
    return "";
  }

  updateNativeAuthDigitList(String param) async {
    if (param == null || param.isEmpty || (param.trim() == "")) {
      print("param is empty======>" + param);
      return;
    }
    print("updateNativeAuthDigitList  param=====>" + param.toString());
    var updateMap = await Wallets.instance.updateAuthDigitList(param);
    print("updateMap[isUpdateAuthDigit]=====>" + updateMap["status"].toString() + updateMap["isUpdateAuthDigit"].toString());
  }

  //加入到展示列表displayDigitsList中
  addToDisplayDigitsList(List<Digit> newDigitList) {
    if (newDigitList == null || newDigitList.length == 0) {
      print("addToDisplayDigitsList newDigitList is null");
      return;
    }
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
    List<Digit> tempDigitsList = nativeAuthMap["authDigit"];
    if (tempDigitsList == null || tempDigitsList.length == 0) {
      print("认证列表的代币，加载完了 下标===》" + nativeDigitIndex.toString());
      isLoadAuthDigitFinish = true;
      return [];
    }
    if (onePageOffSet == tempDigitsList.length) {
      nativeDigitIndex = nativeDigitIndex + onePageOffSet;
      print("还有未加载完的认证代币，分页是下标是：===》" + nativeDigitIndex.toString());
    } else {
      nativeDigitIndex = nativeDigitIndex + tempDigitsList.length;
      print("认证列表的代币，加载完了 下标===》" + nativeDigitIndex.toString());
      isLoadAuthDigitFinish = true;
    }
    return tempDigitsList;
  }
}
