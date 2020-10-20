import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchDigitPage extends StatefulWidget {
  @override
  _SearchDigitPageState createState() => _SearchDigitPageState();
}

class _SearchDigitPageState extends State<SearchDigitPage> {
  List<Digit> displayDigitsList = [];
  Wallet nowWalletM;
  Chain nowChain;
  TextEditingController _searchContentController = TextEditingController();
  Widget checkedWidget = Image.asset("assets/images/ic_checked.png");
  Widget addWidget = Image.asset("assets/images/ic_plus.png");

  @override
  void initState() {
    super.initState();
    _searchContentController.text = "";
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
              title: buildSearchInputWidget(),
              backgroundColor: Colors.transparent,
              elevation: 0,
              brightness: Brightness.light,
              actions: <Widget>[
                buildCancelWidget(),
              ]),
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
              ),
              child: Column(
                children: <Widget>[
                  Gaps.scaleVGap(5),
                  buildDigitListAreaWidgets(),
                ],
              )),
        ),
      ),
      onWillPop: () {
        NavigatorUtils.push(context, '${Routes.digitManagePage}?isReloadDigitList=true', clearStack: false);
        return Future(() => false);
      },
    );
  }

  Widget buildCancelWidget() {
    return Container(
        width: ScreenUtil().setWidth(10),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: translate('cancel'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (_searchContentController.text == "") {
                          Navigator.pop(context);
                          return;
                        }
                        _searchContentController.text = "";
                      }),
              ]),
            ),
          ],
        ));
  }

  Widget buildSearchInputWidget() {
    return Container(
      width: ScreenUtil().setWidth(60),
      //Retouched black background with rounded corners
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey, width: ScreenUtil().setWidth(1)), //Gray layer border
        color: Colors.grey,
        borderRadius: new BorderRadius.all(new Radius.circular(ScreenUtil().setWidth(3))),
      ),
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(8),
      child: buildSearchTextFieldWidget(),
    );
  }

  Widget buildSearchTextFieldWidget() {
    return Container(
      child: TextField(
        cursorColor: Colors.white,
        autofocus: true,
        //Set cursor
        decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(bottom: ScreenUtil().setHeight(2.5), left: ScreenUtil().setWidth(0)),
          border: InputBorder.none,
          icon: Container(
            width: ScreenUtil().setWidth(7),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _searchDigit(_searchContentController.text);
              },
            ),
          ),
          hintText: translate("input_ca_or_name"),
          hintStyle: new TextStyle(fontSize: ScreenUtil().setSp(3), color: Colors.white30),
          labelStyle: TextStyle(),
        ),
        onSubmitted: (value) {
          _searchDigit(value);
        },
        controller: _searchContentController,
        //Text alignment (i.e. initial cursor position)
        textAlign: TextAlign.start,
        style: new TextStyle(fontSize: ScreenUtil().setSp(3), color: Colors.white),
      ),
    );
  }

  Widget buildDigitListAreaWidgets() {
    return Container(
        height: ScreenUtil().setHeight(70),
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
              this.displayDigitsList = displayDigitsList;
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
              onTap: () async {
                try {
                  var isExecutorSuccess = false;
                  if (displayDigitsList[index].isVisible) {
                    // router to eth tx history
                    {
                      Provider.of<TransactionProvide>(context)
                        ..setDigitName(displayDigitsList[index].shortName)
                        ..setBalance(displayDigitsList[index].balance)
                        ..setMoney(displayDigitsList[index].money)
                        ..setDecimal(displayDigitsList[index].decimal)
                        ..setFromAddress(Wallets.instance.nowWallet.nowChain.chainAddress)
                        ..setChainType(Wallets.instance.nowWallet.nowChain.chainType)
                        ..setContractAddress(displayDigitsList[index].contractAddress);
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
                    return;
                  } else {
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
                        Fluttertoast.showToast(msg: translate('save_digit_model_failure').toString());
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
                    Fluttertoast.showToast(msg: translate('save_digit_model_failure').toString());
                  }
                } catch (e) {
                  print("digit_list_page error is===>" + e.toString());
                  LogUtil.e("digit_list_page", e.toString());
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

  _searchDigit(String param) async {
    if (param == null || param.trim() == "") {
      return;
    }
    List<Digit> tempList = [];
    Wallets.instance.nowWallet.nowChain.digitsList.forEach((element) {
      if (element.shortName.toLowerCase() == param.toLowerCase() ||
          element.fullName.toLowerCase() == param.toLowerCase() ||
          element.contractAddress.toLowerCase() == param.toLowerCase()) {
        tempList.add(element);
      }
    });
    if (tempList.length > 0) {
      setState(() {
        this.displayDigitsList = tempList;
      });
      return;
    }

    Map queryMap = await Wallets.instance.queryDigit(Wallets.instance.nowWallet.nowChain, param);
    if (queryMap == null) {
      return;
    }
    var status = queryMap["status"];
    if (status != null && status == 200) {
      List<Digit> tempList = List.from(queryMap["authDigit"]);
      if (tempList != null && tempList.length > 0) {
        setState(() {
          this.displayDigitsList = tempList;
        });
      } else {
        print("search result is empty===>");
      }
    } else {
      print("search appear some error===>" + status.toString());
    }
  }
}
