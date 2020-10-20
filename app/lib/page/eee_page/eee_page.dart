import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/net/rate_util.dart';
import 'package:app/page/left_drawer_card/left_drawer_card.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';

class EeePage extends StatefulWidget {
  const EeePage({Key key, this.isForceLoadFromJni}) : super(key: key);

  final bool isForceLoadFromJni; //Whether to force reload of wallet information

  @override
  _EeePageState createState() => _EeePageState();
}

class _EeePageState extends State<EeePage> {
  List<Wallet> walletList = [];
  Wallet nowWallet = Wallet();
  static int singleDigitCount = 20; //Display 20 items of data on a single page, update and update 20 items at a time
  String moneyUnitStr = "USD";
  num nowWalletAmount = 0.00; //The current total market price of tokens in the wallet
  List<String> moneyUnitList = [];
  List<String> chainTypeList = []; //"BTC", "ETH",
  Chain nowChain;
  String nowChainAddress = "";
  String walletName = "";
  Future future;
  List<Digit> nowChainDigitsList = []; //All token data obtained on the chain
  List<Digit> displayDigitsList = []; //Information about the number of fixed tokens displayed on the current page

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    bool isForceLoadFromJni = widget.isForceLoadFromJni;
    if (isForceLoadFromJni == null) isForceLoadFromJni = true;
    this.walletList = await Wallets.instance.loadAllWalletList(isForceLoadFromJni: isForceLoadFromJni);
    for (int i = 0; i < walletList.length; i++) {
      int index = i;
      Wallet wallet = walletList[index];
      print("isNowWallet===>" + wallet.isNowWallet.toString() + wallet.walletId.toString() + "walletName===>" + wallet.walletName.toString());
      if (wallet.isNowWallet == true) {
        this.nowWallet = wallet;
        this.nowWallet.chainList.forEach((item) {
          if (item.chainType == ChainType.EEE || item.chainType == ChainType.EEE_TEST) {
            chainTypeList.add(Chain.chainTypeToValue(item.chainType));
          }
        });
        this.walletName = nowWallet.walletName;
        if (nowWallet.walletType == WalletType.WALLET) {
          this.nowChain = this.nowWallet.getChainByChainType(ChainType.EEE);
        } else {
          this.nowChain = this.nowWallet.getChainByChainType(ChainType.EEE_TEST);
        }
        Wallets.instance.nowWallet.setNowChainType(nowChain);
        this.nowChainAddress = nowChain.chainAddress;
        this.nowChainDigitsList = nowChain.digitsList;
        break; //Find, terminate the loop
      }
    }
    setState(() {
      this.walletList = walletList;
    });
    future = loadDisplayDigitListData();
    LogUtil.d("log init==================>", "dart init");
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
      Digit digit = EeeDigit();
      digit
        ..digitId = nowChainDigitsList[i].digitId
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          walletName ?? "",
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: LeftDrawerCard(), //Left drawer
      body: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                _buildChainCard(), //Chain card swipe
                //_buildMiddleFuncCard(), //Functional location
                Gaps.scaleVGap(5),
                _buildDigitListCard(), //Token list
                //DigitListCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Token list display card
  Widget _buildDigitListCard() {
    return Container(
      height: ScreenUtil().setHeight(78),
      width: ScreenUtil().setWidth(90),
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("snapshot.error==>" + snapshot.error.toString());
            LogUtil.e("digitList future snapshot.hasError is +>", snapshot.error.toString());
            return Center(
              child: Text(
                translate('failure_to_load_data_pls_retry'),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          if (snapshot.hasData && this.displayDigitsList.length > 0) {
            return Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(3)),
              child: _digitListWidgets(snapshot),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text(
                translate('digit_info_null').toString(),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
        },
      ),
    );
  }

  //Token list layout
  Widget _digitListWidgets(snapshot) {
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
        //Token list bar, pull down Refresh || Load data.
        await Future.delayed(
          Duration(seconds: 2),
          () {
            setState(() {
              if (displayDigitsList.length < nowChainDigitsList.length) {
                // The data loaded from JNI (nowChain.digitList), there are still not displayed, continue to the remaining data of nowChainDigitsList,
                // Add to displayDigitsList for display
                loadDisplayDigitListData(); //When pull down to refresh, load new digit to displayDigitsList
              } else {
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
              // {
              //   Provider.of<TransactionProvide>(context)
              //     ..setDigitName(displayDigitsList[index].shortName)
              //     ..setBalance(displayDigitsList[index].balance)
              //     ..setMoney(displayDigitsList[index].money)
              //     ..setDecimal(displayDigitsList[index].decimal)
              //     ..setFromAddress(nowChainAddress)
              //     ..setChainType(nowChain.chainType)
              //     ..setContractAddress(displayDigitsList[index].contractAddress);
              // }
              // NavigatorUtils.push(context, Routes.transactionHistoryPage);
            },
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset("assets/images/ic_eth.png"),
                ),
                Container(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setHeight(3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(3),
                          ),
                          width: ScreenUtil().setWidth(65),
                          height: ScreenUtil().setHeight(10),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: new FractionalOffset(0.0, 0.0),
                                child: Text(
                                  (displayDigitsList[index].shortName ?? "") + " * " + (displayDigitsList[index].balance ?? "0.00"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(3),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(0.0),
                                  width: ScreenUtil().setWidth(30),
                                  child: Text(
                                    "≈" + moneyUnitStr + " " + displayDigitsList[index].money ?? "0.00",
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(3)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(1),
                          ),
                          color: Colors.transparent,
                          width: ScreenUtil().setWidth(65),
                          height: ScreenUtil().setHeight(7),
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    moneyUnitStr + " 0.00 ", //Market price
                                    //moneyUnitStr + " " + (displayDigitsList[index].digitRate.getPrice(moneyUnitStr).toStringAsFixed(5) ?? "0"), //Market price
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(2.5)),
                                      child: Text(
                                        displayDigitsList[index].digitRate.getChangeDaily ?? "0%", //Market price fluctuations
                                        style: TextStyle(color: Colors.yellowAccent, fontSize: ScreenUtil().setSp(2.5)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Opacity(
                                    opacity: 0,
                                    child: Text(
                                      "0", //Last transaction
                                      style: TextStyle(fontSize: ScreenUtil().setSp(2.5), color: Colors.greenAccent),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
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

  //Transfer && Address Function Card
  Widget _buildMiddleFuncCard() {
    return Container(
      height: ScreenUtil().setHeight(15),
      width: ScreenUtil().setWidth(90),
      margin: EdgeInsets.only(top: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(10),
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(3.5),
                    ),
                    child: Image.asset("assets/images/ic_transfer.png"),
                  ),
                  Text(
                    translate('transfer'),
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                  )
                ],
              ),
            ),
            onTap: () {
              Provider.of<TransactionProvide>(context)..setChainType(nowChain.chainType);
              NavigatorUtils.push(context, Routes.digitListPage);
            },
          ),
          GestureDetector(
            child: Container(
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(10),
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(3.5)), child: Image.asset("assets/images/ic_receive.png")),
                  Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(3.5)),
                      child: Text(
                        translate('receive'),
                        style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                      )),
                ],
              ),
            ),
            onTap: () {
              _navigatorToQrInfoPage(walletName, translate('chain_address_info'), nowChainAddress);
            },
          )
        ],
      ),
    );
  }

  //Chain card
  Widget _buildChainCard() {
    if (chainTypeList.isEmpty) {
      return Container(
        child: null,
      );
    }
    return Container(
      width: ScreenUtil().setWidth(77.5),
      height: ScreenUtil().setHeight(42.75),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(42.75),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(8.5), top: ScreenUtil().setHeight(11)),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_card.png"), fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chainCardMoneyWidget(),
                  Gaps.scaleVGap(8),
                  _chainCardAddressWidget(index),
                ],
              ),
            ),
          );
        },
        itemCount: chainTypeList.isNotEmpty ? chainTypeList.length : 0,
        pagination: new SwiperPagination(
          builder: SwiperPagination(
            builder: SwiperPagination.rect, //Cut page icon
          ),
        ),
        autoplay: false,
      ),
    );
  }

  //Chain card money
  Widget _chainCardMoneyWidget() {
    return Container(
      height: ScreenUtil().setHeight(7),
      child: GestureDetector(
        onTap: () {
          print("money unit is click~~~");
        },
        child: Container(
          height: ScreenUtil().setHeight(7),
          alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              //constraints: BoxConstraints(maxWidth:ScreenUtil().setWidth(30)),
              height: ScreenUtil().setHeight(7),
              //width: ScreenUtil().setWidth(30),
              alignment: Alignment.centerLeft,
              child: new Text(
                moneyUnitStr + nowWalletAmount.toStringAsFixed(4) ?? "0.00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gaps.scaleHGap(1),
            Container(
              height: ScreenUtil().setHeight(7),
              child: new PopupMenuButton<String>(
                color: Colors.black12,
                icon: Icon(Icons.keyboard_arrow_down),
                itemBuilder: (BuildContext context) => _makePopMenuList(),
                onSelected: (String value) {
                  Rate.instance.setNowLegalCurrency(value);
                  setState(() {
                    moneyUnitStr = value;
                  });
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  List<PopupMenuItem<String>> _makePopMenuList() {
    List<PopupMenuItem<String>> popMenuList = List.generate(moneyUnitList.length, (index) {
      return PopupMenuItem<String>(
          value: moneyUnitList[index] ?? "",
          child: new Text(
            moneyUnitList[index] ?? "",
            style: new TextStyle(color: Colors.white),
          ));
    });
    return popMenuList;
  }

  //Chain card address
  Widget _chainCardAddressWidget(index) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                if (walletName.isEmpty || nowChainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, translate('chain_address_info'), nowChainAddress);
              },
              child: Image.asset("assets/images/ic_card_qrcode.png"),
            ),
          ),
          Gaps.scaleHGap(1.5),
          Container(
            alignment: Alignment.bottomLeft,
            constraints: BoxConstraints(
              maxWidth: ScreenUtil().setWidth(20.5),
            ),
            child: GestureDetector(
              onTap: () {
                if (walletName.isEmpty || nowChainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, translate('chain_address_info'), nowChainAddress);
              },
              child: Text(
                nowChainAddress,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.lightBlueAccent),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Gaps.scaleHGap(15.5),
          Container(
            child: Container(
              child: Text(
                chainTypeList[index],
                style: TextStyle(
                  fontSize: 45,
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigatorToQrInfoPage(String title, String hintInfo, String content) {
    print("_navigatorToQrInfoPage=>" + "target info is" + "addresspage?title=" + title + "&hintInfo=" + hintInfo + "&content=" + content);
    //Temporary use of data state management processing, routing function fluro Chinese pass value will have problems.
    Provider.of<QrInfoProvide>(context).setTitle(title);
    Provider.of<QrInfoProvide>(context).setHintInfo(hintInfo);
    Provider.of<QrInfoProvide>(context).setContent(content);

    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
