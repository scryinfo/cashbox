import 'dart:async';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eee_chain_control.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/token.dart';
import 'package:app/model/token_rate.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/net/rate_util.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/pages/left_drawer.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:logger/logger.dart';
import 'package:app/util/app_info_util.dart';
import 'package:app/util/utils.dart';
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
import 'package:wallets/enums.dart';

class EeePage extends StatefulWidget {
  const EeePage({Key key, this.isForceLoadFromJni}) : super(key: key);

  final bool isForceLoadFromJni; //Whether to force reload of wallet information

  @override
  _EeePageState createState() => _EeePageState();
}

class _EeePageState extends State<EeePage> {
  static int singlePageTokenCount = 20; //Display 20 items of data on a single page, update and update 20 items at a time
  String moneyUnitStr = "";
  num nowWalletAmount = 0.00; //The current total market price of tokens in the wallet
  List<String> moneyUnitList = [];
  Future tokenListFuture;
  List<TokenM> allVisibleTokenMList = []; //List of all visible tokens in the current chain
  List<TokenM> displayTokenMList = []; //Information about the number of fixed tokens displayed on the current page
  num chainIndex = 0; //Subscript of current chain
  Rate rateInstance;
  Timer _loadingBalanceTimerTask; // is loading balance
  Timer _loadingRateTimerTask; // is loading balance
  Timer _loadingDigitMoneyTask; // is loading balance

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TransactionProvide>().emptyDataRecord();
  }

  void initData() async {
    {
      Config config = await HandleConfig.instance.getConfig();
      moneyUnitStr = config.currency;
    }
    bool isForceLoadFromJni = widget.isForceLoadFromJni;
    if (isForceLoadFromJni == null) isForceLoadFromJni = true;
    this.allVisibleTokenMList = EeeChainControl.getInstance().getVisibleTokenList(WalletsControl.getInstance().currentWallet());
    tokenListFuture = loadDisplayTokenListData();
    if (mounted) {
      setState(() {});
    }
    loadDigitBalance();
    loadLegalCurrency();
    // loadDigitRateInfo();
    // todo AppInfoUtil.instance.checkAppUpgrade();
  }

  //Processing display fiat currency usd, cny, etc.
  loadLegalCurrency() async {
    Rate rate = await loadRateInstance();
    if (rate == null) {
      return;
    }
    this.moneyUnitList = rate.getAllSupportLegalCurrency();
    if (mounted) {
      setState(() {
        this.moneyUnitList = this.moneyUnitList;
      });
    }
  }

  //Market price information (hourly changes, etc.)
  loadDigitRateInfo() async {
    if (displayTokenMList == null || displayTokenMList.length == 0) {
      return;
    }
    if (_loadingRateTimerTask != null) {
      _loadingRateTimerTask.cancel();
    }
    _loadingRateTimerTask = Timer(const Duration(milliseconds: 1000), () async {
      rateInstance = await loadRateInstance();
      if (rateInstance == null) {
        return;
      }
      if (true) {
        List<String> rateKeys = rateInstance.digitRateMap.keys.toList();
        for (var i = 0; i < displayTokenMList.length; i++) {
          int index = i;
          if ((this.displayTokenMList[index].shortName.toUpperCase() != null) &&
              (rateKeys.contains(this.displayTokenMList[index].shortName.toUpperCase().trim().toString()))) {
            if (mounted) {
              setState(() {
                this.displayTokenMList[index].tokenRate
                  ..symbol = TokenRate.instance.getSymbol(this.displayTokenMList[index])
                  ..price = TokenRate.instance.getPrice(this.displayTokenMList[index])
                  ..changeDaily = TokenRate.instance.getChangeDaily(this.displayTokenMList[index]);
              });
            }
          } else {
            Logger().w("digitName is not exist===>", this.displayTokenMList[index].shortName);
          }
        }
      }
    });
  }

  //Token balance
  loadDigitBalance() async {
    if (displayTokenMList == null || displayTokenMList.length == 0) {
      return;
    }
    if (_loadingBalanceTimerTask != null) {
      _loadingBalanceTimerTask.cancel();
    }
    Config config = await HandleConfig.instance.getConfig();
    _loadingBalanceTimerTask = Timer(const Duration(milliseconds: 1000), () async {
      ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
      for (var i = 0; i < displayTokenMList.length; i++) {
        int index = i;
        String balance = "0";

        if (this.displayTokenMList[index].shortName.toLowerCase() == config.eeeSymbol.toLowerCase()) {
          Map eeeStorageKeyMap =
              await scryXNetUtil.loadEeeStorageMap(config.systemSymbol, config.accountSymbol, this.displayTokenMList[index].address);
          if (eeeStorageKeyMap != null && eeeStorageKeyMap.containsKey("status") && eeeStorageKeyMap["status"] == 200) {
            try {
              String eeeFree = eeeStorageKeyMap["free"] ?? "0";
              balance = (BigInt.parse(eeeFree) / config.eeeUnit).toStringAsFixed(5) ?? "0";
              if (balance == null || double.parse(balance) == double.parse("0")) {
                continue;
              }
            } catch (e) {
              Logger().e("_loadingBalanceTimerTask error is =>", e.toString());
            }
            // Wallets.instance.nowWallet.nowChain.digitsList[index].balance = balance;
            this.displayTokenMList[index].balance = balance;
          }
        } else if (this.displayTokenMList[index].shortName.toLowerCase() == config.tokenXSymbol.toLowerCase()) {
          Map tokenBalanceMap =
              await scryXNetUtil.loadTokenXbalance(config.tokenXSymbol, config.balanceSymbol, this.displayTokenMList[index].address);
          if (tokenBalanceMap != null && tokenBalanceMap.containsKey("result")) {
            try {
              double tokenBalance = BigInt.parse(Utils.reverseHexValue2SmallEnd(tokenBalanceMap["result"]), radix: 16) / config.eeeUnit;
              balance = tokenBalance.toStringAsFixed(5);
              if (balance == null || double.parse(balance) == double.parse("0")) {
                continue;
              }
            } catch (e) {
              Logger().e("_loadingBalanceTimerTask error is =>", e.toString());
            }
            this.displayTokenMList[index].balance = balance ?? "";
            // Wallets.instance.nowWallet.nowChain.digitsList[index].balance = balance ?? "";
          }
        } else {
          Fluttertoast.showToast(msg: translate('eee_config_error').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
        }
        if (mounted) {
          setState(() {
            this.displayTokenMList[index].balance = balance ?? "0";
          });
        }
      }
    });
  }

  //Corresponding to the number of tokens, the value of the market fiat currency
  loadDigitMoney() {
    if (displayTokenMList == null || displayTokenMList.length == 0) {
      return;
    }
    if (_loadingDigitMoneyTask != null) {
      _loadingDigitMoneyTask.cancel();
    }
    _loadingBalanceTimerTask = Timer(const Duration(milliseconds: 1000), () async {
      for (var i = 0; i < displayTokenMList.length; i++) {
        var index = i;
        nowWalletAmount = 0;
        var money = TokenRate.instance.getMoney(displayTokenMList[index]).toStringAsFixed(3);
        allVisibleTokenMList[i].money = money;
        if (mounted) {
          setState(() {
            nowWalletAmount = nowWalletAmount + TokenRate.instance.getMoney(displayTokenMList[index]);
            // Wallets.instance.nowWallet.accountMoney = nowWalletAmount.toStringAsFixed(5);
            displayTokenMList[index].money = money;
          });
        }
      }
    });
  }

  //Display token list
  Future<List<TokenM>> loadDisplayTokenListData() async {
    if (displayTokenMList.length == 0) {
      //No display data
      if (allVisibleTokenMList.length < singlePageTokenCount) {
        //Not enough pages loaded, full display
        addTokenToDisplayList(allVisibleTokenMList.length);
      } else {
        //Super page, showing singlePageTokenCount.
        //addDigitToDisplayList(singlePageTokenCount);
        addTokenToDisplayList(singlePageTokenCount);
      }
    } else {
      //There are display data, continue to add
      if (allVisibleTokenMList.length - displayTokenMList.length > singlePageTokenCount) {
        //More than one page left
        addTokenToDisplayList(singlePageTokenCount);
      } else {
        //If there is not enough one page left, all will be added.
        addTokenToDisplayList(allVisibleTokenMList.length - displayTokenMList.length);
      }
    }
    return displayTokenMList;
  }

  List<TokenM> addTokenToDisplayList(int targetCount) {
    for (var i = displayTokenMList.length; i < targetCount; i++) {
      TokenRate tokenRate = TokenRate.instance;
      TokenM tokenM = TokenM();
      tokenM
        ..tokenId = allVisibleTokenMList[i].tokenId
        ..chainId = allVisibleTokenMList[i].chainId
        ..decimal = allVisibleTokenMList[i].decimal
        ..shortName = allVisibleTokenMList[i].shortName
        ..fullName = allVisibleTokenMList[i].fullName
        ..balance = allVisibleTokenMList[i].balance
        ..contractAddress = allVisibleTokenMList[i].contractAddress
        ..address = allVisibleTokenMList[i].address
        ..tokenRate = tokenRate;
      displayTokenMList.add(tokenM);
    }
    return displayTokenMList;
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
          WalletsControl.getInstance().currentWallet().name ?? "",
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: LeftDrawer(), //Left drawer
      body: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                _buildChainCard(), //Chain card swipe
                _buildMiddleFuncCard(), //Functional location
                _buildDigitListCard(), //Token list
              ],
            ),
            Positioned(
              bottom: ScreenUtil().setHeight(5),
              child: _buildAddDigitButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddDigitButton() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(26, 141, 198, 0.40),
            child: FlatButton(
              child: Text(
                translate('digit_manage'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  letterSpacing: 0.03,
                  fontSize: ScreenUtil().setSp(3.2),
                ),
              ),
              onPressed: () {
                NavigatorUtils.push(context, '${Routes.digitManagePage}?isReloadDigitList=true', clearStack: false);
              },
            ),
          )
        ],
      ),
    );
  }

  //Token list display card
  Widget _buildDigitListCard() {
    return Container(
      height: ScreenUtil().setHeight(78),
      width: ScreenUtil().setWidth(90),
      child: FutureBuilder(
        future: tokenListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Logger().e("digitList future snapshot.hasError is +>", snapshot.error.toString());
            return Center(
              child: Text(
                translate('failure_to_load_data_pls_retry'),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          if (snapshot.hasData && this.displayTokenMList.length > 0) {
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
            childCount: displayTokenMList.length,
          ),
        ),
      ],
      onLoad: () async {
        //Token list bar, pull down to refresh||load data.
        await Future.delayed(
          Duration(seconds: 2),
          () {
            if (mounted) {
              setState(() {
                if (displayTokenMList.length < allVisibleTokenMList.length) {
                  // allVisibleTokenMList is still not displayed
                  // When pulling down to refresh, load the new digit to displayTokenMList
                  loadDisplayTokenListData();
                } else {
                  Fluttertoast.showToast(msg: translate('load_finish_wallet_digit').toString());
                  return;
                }
              });
            }
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
              {
                context.read<TransactionProvide>()
                  ..emptyDataRecord()
                  ..setDigitName(displayTokenMList[index].shortName)
                  ..setBalance(displayTokenMList[index].balance)
                  ..setMoney(displayTokenMList[index].money)
                  ..setDecimal(displayTokenMList[index].decimal)
                  ..setFromAddress(WalletsControl.getInstance().currentChainAddress())
                  ..setChainType(WalletsControl.getInstance().currentChainType())
                  ..setContractAddress(displayTokenMList[index].contractAddress);
              }
              NavigatorUtils.push(context, Routes.eeeChainTxHistoryPage);
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
                                  (displayTokenMList[index].shortName ?? "") + " * " + (displayTokenMList[index].balance ?? "0.00"),
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
                                    "≈" + moneyUnitStr + " " + displayTokenMList[index].money.toString() ?? "0.00",
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
                                    moneyUnitStr +
                                        " " +
                                        (rateInstance == null
                                            ? ""
                                            : TokenRate.instance.getPrice(displayTokenMList[index]).toStringAsFixed(5) ?? "0"), //Market unit price
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(2.5)),
                                    child: Text(
                                      "0%", //Market price fluctuations
                                      // todo  displayTokenMList[index].tokenRate.getChangeDaily.toString() ?? "0%", //Market price fluctuations
                                      style: TextStyle(color: Colors.yellowAccent, fontSize: ScreenUtil().setSp(2.5)),
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
              _navigatorToQrInfoPage(WalletsControl.getInstance().currentWallet().name, translate('chain_address_info'),
                  WalletsControl.getInstance().currentChainAddress());
            },
          )
        ],
      ),
    );
  }

  //Chain card
  Widget _buildChainCard() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(42.75),
      child: FutureBuilder(
          future: tokenListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(translate('load_data_error'));
            }
            if (snapshot.hasData) {
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: ScreenUtil().setWidth(90),
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
                onIndexChanged: (index) async {
                  // bool isSetNowChain = await Wallets.instance.nowWallet.setNowChainType(Wallets.instance.nowWallet.chainList[index]);
                  // if (isSetNowChain) {
                  //   if (mounted) {
                  //     setState(() {
                  //       this.chainIndex = index;
                  //       // Wallets.instance.nowWallet.nowChain.chainAddress = Wallets.instance.nowWallet.nowChain.chainAddress;
                  //       // this.allVisibleDigitsList = Wallets.instance.nowWallet.nowChain.getVisibleDigitList(); //init data
                  //       this.displayTokenMList = [];
                  //       loadDisplayTokenListData();
                  //     });
                  //   }
                  // }
                  // loadDigitBalance();
                  // loadDigitRateInfo();
                },
                index: chainIndex,
                itemCount: 1,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: new SwiperPagination(
                  builder: SwiperPagination(
                    builder: SwiperPagination.rect, //Cut page icon
                  ),
                ),
                loop: false,
                autoplay: false,
              );
            }
            return Text("");
          }),
    );
  }

  //Chain card money
  Widget _chainCardMoneyWidget() {
    return Container(
      height: ScreenUtil().setHeight(7),
      child: GestureDetector(
        onTap: () {},
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
                onSelected: (String value) async {
                  Rate.instance.setNowLegalCurrency(value);
                  if (mounted) {
                    setState(() {
                      moneyUnitStr = value;
                    });
                  }
                  this.loadDigitMoney();

                  Config config = await HandleConfig.instance.getConfig();
                  config.currency = value;
                  HandleConfig.instance.saveConfig(config);
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
                if (WalletsControl.getInstance().currentWallet().name.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(WalletsControl.getInstance().currentWallet().name, translate('chain_address_info'),
                    WalletsControl.getInstance().currentChainAddress() ?? "");
              },
              child: Image.asset("assets/images/ic_card_qrcode.png"),
            ),
          ),
          Gaps.scaleHGap(1.5),
          Container(
            alignment: Alignment.bottomLeft,
            constraints: BoxConstraints(
              maxWidth: ScreenUtil().setWidth(25.5),
            ),
            child: GestureDetector(
              onTap: () {
                if (WalletsControl.getInstance().currentWallet().name.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(WalletsControl.getInstance().currentWallet().name, translate('chain_address_info'),
                    WalletsControl.getInstance().currentWallet().eeeChain.chainShared.walletAddress.address);
              },
              child: Text(
                WalletsControl.getInstance().currentWallet().eeeChain.chainShared.walletAddress.address ?? "",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.lightBlueAccent),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Gaps.scaleHGap(4),
          Container(
            width: ScreenUtil().setWidth(26),
            child: Text(
              ChainType.EEE.toEnumString(),
              style: TextStyle(
                fontSize: 45,
                color: Color.fromRGBO(255, 255, 255, 0.1),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  void _navigatorToQrInfoPage(String title, String hintInfo, String content) {
    //Temporary use of data status management processing, routing function fluro Chinese pass value will have problems.
    context.read<QrInfoProvide>().setTitle(title);
    context.read<QrInfoProvide>().setHintInfo(hintInfo);
    context.read<QrInfoProvide>().setContent(content);

    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
