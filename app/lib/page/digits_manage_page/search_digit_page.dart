import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/res/resources.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SearchDigitPage extends StatefulWidget {
  @override
  _SearchDigitPageState createState() => _SearchDigitPageState();
}

class _SearchDigitPageState extends State<SearchDigitPage> {
  List<Digit> displayDigitsList = [];
  Wallet nowWalletM;
  Chain nowChain;
  TextEditingController _searchContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchContentController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget buildCancelWidget() {
    return Container(
        width: ScreenUtil.instance.setWidth(10),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: translate('cancel'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: ScreenUtil.instance.setSp(3),
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
      width: ScreenUtil.instance.setWidth(60),
      //Retouched black background with rounded corners
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey, width: ScreenUtil.instance.setWidth(1)), //Gray layer border
        color: Colors.grey,
        borderRadius: new BorderRadius.all(new Radius.circular(ScreenUtil.instance.setWidth(3))),
      ),
      alignment: Alignment.center,
      height: ScreenUtil.instance.setHeight(8),
      child: buildSearchTextFieldWidget(),
    );
  }

  Widget buildSearchTextFieldWidget() {
    return Container(
        child: TextField(
      cursorColor: Colors.white,
      //Set cursor
      decoration: InputDecoration(
        contentPadding: new EdgeInsets.only(bottom: ScreenUtil.instance.setHeight(2.5)),
        border: InputBorder.none,
        icon: IconButton(
            icon: ImageIcon(
              AssetImage(
                "assets/images/ic_search.png",
              ),
            ),
            onPressed: () {
              _searchDigit(_searchContentController.text);
            }),
        hintText: "请输入代币名称或合约地址",
        hintStyle: new TextStyle(fontSize: ScreenUtil.instance.setSp(3), color: Colors.white),
      ),
      onSubmitted: (value) {
        _searchDigit(value);
      },
      controller: _searchContentController,
      //Text alignment (i.e. initial cursor position)
      textAlign: TextAlign.start,
      style: new TextStyle(fontSize: ScreenUtil.instance.setSp(3), color: Colors.white),
    ));
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
                // todo save or change the display state interface function to be verified
                var addDigitMap = await Wallets.instance
                    .addDigitToChainModel(Wallets.instance.nowWallet.walletId, Wallets.instance.nowWallet.nowChain, displayDigitsList[index].digitId);
                int status = addDigitMap["status"];
                if (status != null && status == 200) {
                  setState(() {
                    displayDigitsList[index].isVisible = true;
                  });
                } else {
                  print("addDigitToChainModel appear error:" + addDigitMap["message"]);
                  return;
                }
              } catch (e) {
                print("digit_list_page点击传值出现位置错误===>" + e.toString());
                LogUtil.e("digit_list_page", e.toString());
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

  _searchDigit(String param) async {
    // todo execute lookup interface
    Map queryMap = await Wallets.instance.queryDigit(Wallets.instance.nowWallet.nowChain, param);
    if (queryMap == null) {
      return;
    }
    var status = queryMap["status"];
    if (status != null && status == 200) {
      print("_searchDigit  status===>" + queryMap["status"].toString());
      print("_searchDigit  count===>" + queryMap["count"].toString());
      List tempList = queryMap["authDigit"];
      if (tempList != null && tempList.length > 0) {
        setState(() {
          this.displayDigitsList = tempList;
        });
      } else {
        print("搜索结果为空===>");
      }
    } else {
      print("搜索出现问题了===>" + status.toString());
    }
  }
}
