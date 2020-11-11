import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/net_util.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

class DigitsManagePage extends StatefulWidget {
  const DigitsManagePage({Key key, this.isReloadDigitList}) : super(key: key);

  final bool isReloadDigitList; //Whether to force reload of wallet digitList

  @override
  _DigitsManagePageState createState() => _DigitsManagePageState();
}

class _DigitsManagePageState extends State<DigitsManagePage> {
  List<Digit> allDigitsList = [];
  List<Digit> displayDigitsList = [];

  //Tokens displayed on the page = nowWallet.nowChain.digitsList (this chain already exists, visible is displayed in front) + nativeAuthDigitsList (paged authentication tokens)
  Widget checkedWidget = Image.asset("assets/images/ic_checked.png");
  Widget addWidget = Image.asset("assets/images/ic_plus.png");
  int nativeDigitIndex = 0;
  int onePageOffSet = 20; //Display 20 items of data on a single page, update and update 20 items at a time
  int maxAuthTokenCount = 0; //Total number of local authToken
  bool isLoadAuthDigitFinish = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    bool isReloadDigitList = widget.isReloadDigitList;
    if (isReloadDigitList == null) isReloadDigitList = true;
    if (isReloadDigitList) {
      var allNativeDigitList = Wallets.instance.nowWallet.nowChain.digitsList;
      allNativeDigitList.sort((left, right) {
        if (left.isVisible ^ right.isVisible) {
          //different state of  visible
          return left.isVisible ? -1 : 1;
        }
        return 0;
      });
      addToAllDigitsList(allNativeDigitList);
      pushToDisplayDigitList();
    }
    {
      try {
        Config config = await HandleConfig.instance.getConfig();
        String authDigitIp = "";
        if (config.privateConfig.authDigitIpList != null && config.privateConfig.authDigitIpList.length > 0) {
          authDigitIp = config.privateConfig.authDigitIpList[0];
        }
        print("authDigitIp is ----->" + authDigitIp);
        var param = await loadServerDigitsData(authDigitIp);
        if (param == null || param.trim() == "") {
          return;
        }
        await updateNativeAuthDigitList(param);
      } catch (e) {
        LogUtil.e("DigitsManagePage error is=>", e);
      }
      if (displayDigitsList.length < onePageOffSet) {
        var tempNativeAuthDigitsList = await getAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);
        addToAllDigitsList(tempNativeAuthDigitsList);
        pushToDisplayDigitList();
      }
    }
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
                  NavigatorUtils.push(context, '${Routes.homePage}?isForceLoadFromJni=true', clearStack: true);
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
                width: ScreenUtil().setWidth(10),
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
        NavigatorUtils.push(context, '${Routes.homePage}?isForceLoadFromJni=true', clearStack: true);
        return Future(() => false);
      },
    );
  }

  Widget _digitListAreaWidgets() {
    return Container(
      height: ScreenUtil().setHeight(138),
      width: ScreenUtil().setWidth(90),
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(3)),
        child: _digitListWidgets(),
      ),
    );
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
        //Token list bar, pull down to refresh||load data.
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
            addToAllDigitsList(tempList);
            pushToDisplayDigitList();
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
              onTap: () async {
                var isExecutorSuccess = false;
                if (displayDigitsList[index].isVisible) {
                  isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.hideDigit(displayDigitsList[index]);
                } else {
                  //Invisible, perform visible show operation
                  bool isDigitExist = false;
                  var tempDigitList = Wallets.instance.nowWallet.nowChain.digitsList;
                  for (int i = 0; i < tempDigitList.length; i++) {
                    var element = tempDigitList[i];
                    if (element.digitId == displayDigitsList[index].digitId) {
                      isDigitExist = true;
                      break;
                    }
                  }
                  if (isDigitExist) {
                    isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.showDigit(displayDigitsList[index]);
                  } else {
                    // Save to digit under the local Chain (bottom + model)
                    var addDigitMap = await Wallets.instance.addDigitToChainModel(
                        Wallets.instance.nowWallet.walletId, Wallets.instance.nowWallet.nowChain, displayDigitsList[index].digitId);
                    int status = addDigitMap["status"];
                    if (status == null || status != 200) {
                      Fluttertoast.showToast(msg: translate("save_digit_model_failure"));
                      print("addDigitToChainModel failure==" + addDigitMap["message"]);
                    } else {
                      isExecutorSuccess = true;
                    }
                    isExecutorSuccess = await Wallets.instance.nowWallet.nowChain.showDigit(displayDigitsList[index]);
                  }
                }
                if (isExecutorSuccess) {
                  setState(() {
                    displayDigitsList[index].isVisible = displayDigitsList[index].isVisible;
                  });
                } else {
                  Fluttertoast.showToast(msg: translate("save_digit_model_failure"));
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
                          fontSize: ScreenUtil().setSp(3.5),
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
      var result = await requestWithDeviceId(authUrl);
      if (result["code"] != null && result["code"] == 0) {
        print("loadServerDigitsData result.code=>" + convert.jsonEncode(result["data"]));
        return convert.jsonEncode(result["data"]).toString();
      }
    } catch (e) {
      print("loadServerDigitsData error is ===>" + e.toString());
      return "";
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

  pushToDisplayDigitList() {
    int targetLength = 0;
    if (onePageOffSet < (allDigitsList.length - displayDigitsList.length)) {
      targetLength = onePageOffSet;
    } else {
      targetLength = allDigitsList.length - displayDigitsList.length;
    }
    List<Digit> tempList = new List();
    for (int i = 0; i < targetLength; i++) {
      var index = i;
      tempList.add(allDigitsList[displayDigitsList.length + index]);
    }
    this.displayDigitsList.addAll(tempList);
    setState(() {
      this.displayDigitsList = displayDigitsList;
    });
  }

  //Add to displayDigitsList
  addToAllDigitsList(List<Digit> newDigitList) {
    if (newDigitList == null || newDigitList.length == 0) {
      print("addToAllDigitsList newDigitList is null");
      return;
    }
    for (num i = 0; i < newDigitList.length; i++) {
      var element = newDigitList[i];
      if (element.contractAddress != null && element.contractAddress.isNotEmpty) {
        //erc20
        bool isExistErc20 = false;
        for (num index = 0; index < allDigitsList.length; index++) {
          var digit = allDigitsList[index];
          print(" digit.fullName ===>" + digit.fullName.toString() + " ||digit--->" + digit.contractAddress.toString());
          print(" element.fullName ===>" + element.fullName.toString() + " ||element--->" + element.contractAddress.toString());
          if ((digit.contractAddress != null) &&
              (element.contractAddress != null) &&
              (digit.contractAddress.trim().toLowerCase() == element.contractAddress.trim().toLowerCase())) {
            isExistErc20 = true;
            break;
          }
        }
        print("isExistErc20 ===>" + isExistErc20.toString() + " || element.contractAddress--->" + element.contractAddress.toString());
        if (!isExistErc20) {
          allDigitsList.add(element);
        }
      } else {
        bool isExistDigit = false;
        for (num index = 0; index < allDigitsList.length; index++) {
          var digit = allDigitsList[index];
          if ((digit.shortName != null) && (element.shortName != null) && (digit.shortName == element.shortName)) {
            //print("digit.shortName=>" + digit.shortName + "||element.shortName===>" + element.shortName);
            isExistDigit = true;
            break;
          }
        }
        print("isExistDigit ===>" + isExistDigit.toString());
        if (!isExistDigit) {
          allDigitsList.add(element);
        }
      }
    }
  }

  Future<List<Digit>> getAuthDigitList(Chain chain, int tempDigitIndex, int onePageOffSet) async {
    Map nativeAuthMap = await Wallets.instance.getNativeAuthDigitList(Wallets.instance.nowWallet.nowChain, nativeDigitIndex, onePageOffSet);
    if (nativeAuthMap == null) {
      print("getAuthDigitList() native digit list failure===》");
      return [];
    }
    maxAuthTokenCount = nativeAuthMap["count"];
    List<Digit> tempDigitsList = nativeAuthMap["authDigit"];
    if (tempDigitsList == null || tempDigitsList.length == 0) {
      print("getAuthDigitList() is empty, nativeDigitIndex===》" + this.nativeDigitIndex.toString());
      isLoadAuthDigitFinish = true;
      return [];
    }
    if (onePageOffSet == tempDigitsList.length) {
      this.nativeDigitIndex = tempDigitIndex + onePageOffSet;
      print("getAuthDigitList() continue, nativeDigitIndex===》" + this.nativeDigitIndex.toString());
    } else {
      this.nativeDigitIndex = tempDigitIndex + tempDigitsList.length;
      print("getAuthDigitList() finish, nativeDigitIndex===》" + this.nativeDigitIndex.toString());
      isLoadAuthDigitFinish = true;
    }
    print("getAuthDigitList() result，tempDigitsList===》" + tempDigitsList.toString());
    return tempDigitsList;
  }
}
