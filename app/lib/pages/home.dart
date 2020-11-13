import 'dart:async';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/net/rate_util.dart';
import 'package:app/net/scryx_net_util.dart';
import 'package:app/pages/left_drawer.dart';
import 'package:app/provide/qr_info_provide.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.isForceLoadFromJni}) : super(key: key);

  final bool isForceLoadFromJni; //Whether to force reload of wallet information

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wallet> walletList = [];
  static int singleDigitCount = 20; //Display 20 items of data on a single page, update and update 20 items at a time
  String moneyUnitStr = "";
  num nowWalletAmount = 0.00; //The current total market price of tokens in the wallet
  List<String> moneyUnitList = [];
  String walletName = "";
  Future digitListFuture;
  List<Digit> allVisibleDigitsList = []; //List of all visible tokens in the current chain
  List<Digit> displayDigitsList = []; //Information about the number of fixed tokens displayed on the current page
  List<Chain> allVisibleChainsList = [];
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
    Provider.of<TransactionProvide>(context).emptyDataRecord();
  }

  void initData() async {
    {
      Config config = await HandleConfig.instance.getConfig();
      moneyUnitStr = config.currency;
    }

    bool isForceLoadFromJni = widget.isForceLoadFromJni;
    if (isForceLoadFromJni == null) isForceLoadFromJni = true;
    this.walletList = [];
    this.walletList = await Wallets.instance.loadAllWalletList(isForceLoadFromJni: isForceLoadFromJni);
    for (int i = 0; i < walletList.length; i++) {
      int index = i;
      Wallet wallet = walletList[index];
      if (wallet.isNowWallet == true) {
        this.walletName = Wallets.instance.nowWallet.walletName;
        break; //Find, terminate the loop
      }
    }
    this.allVisibleDigitsList = Wallets.instance.nowWallet.nowChain.getVisibleDigitList(); //init data
    this.allVisibleChainsList = [];
    this.allVisibleChainsList = Wallets.instance.nowWallet.getVisibleChainList(isForceLoad: true);
    digitListFuture = loadDisplayDigitListData();
    chainIndex = this.allVisibleChainsList.indexOf(Wallets.instance.nowWallet.nowChain);
    if (mounted) {
      setState(() {
        this.walletList = walletList;
      });
    }
    loadDigitBalance();
    loadLegalCurrency();
    loadDigitRateInfo();
    AppInfoUtil.instance.checkAppUpgrade();
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
    if (displayDigitsList == null || displayDigitsList.length == 0) {
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
        for (var i = 0; i < displayDigitsList.length; i++) {
          int index = i;
          if ((this.displayDigitsList[index].shortName.toUpperCase() != null) &&
              (rateKeys.contains(this.displayDigitsList[index].shortName.toUpperCase().trim().toString()))) {
            if (mounted) {
              setState(() {
                this.displayDigitsList[index].digitRate
                  ..symbol = rateInstance.getSymbol(this.displayDigitsList[index])
                  ..price = rateInstance.getPrice(this.displayDigitsList[index])
                  ..changeDaily = rateInstance.getChangeDaily(this.displayDigitsList[index]);
              });
            }
          } else {
            LogUtil.w("digitName is not exist===>", this.displayDigitsList[index].shortName);
          }
        }
      }
    });
  }

  //Token balance
  loadDigitBalance() async {
    if (displayDigitsList == null || displayDigitsList.length == 0) {
      return;
    }
    if (_loadingBalanceTimerTask != null) {
      _loadingBalanceTimerTask.cancel();
    }
    Config config = await HandleConfig.instance.getConfig();
    _loadingBalanceTimerTask = Timer(const Duration(milliseconds: 1000), () async {
      switch (Wallets.instance.nowWallet.nowChain.chainType) {
        case ChainType.ETH:
        case ChainType.ETH_TEST:
          {
            for (var i = 0; i < displayDigitsList.length; i++) {
              int index = i;
              String balance = "0";
              if (this.displayDigitsList[index].contractAddress != null && this.displayDigitsList[index].contractAddress.trim() != "") {
                balance = await loadErc20Balance(Wallets.instance.nowWallet.nowChain.chainAddress, this.displayDigitsList[index].contractAddress,
                    Wallets.instance.nowWallet.nowChain.chainType);
                Wallets.instance
                    .updateDigitBalance(this.displayDigitsList[index].contractAddress, this.displayDigitsList[index].digitId, balance ?? "");
              } else if (Wallets.instance.nowWallet.nowChain.chainAddress != null && Wallets.instance.nowWallet.nowChain.chainAddress.trim() != "") {
                balance = await loadEthBalance(Wallets.instance.nowWallet.nowChain.chainAddress, Wallets.instance.nowWallet.nowChain.chainType);
                Wallets.instance
                    .updateDigitBalance(Wallets.instance.nowWallet.nowChain.chainAddress, this.displayDigitsList[index].digitId, balance ?? "");
              } else {}
              if (balance == null || double.parse(balance) == double.parse("0")) {
                continue;
              }
              allVisibleDigitsList[index].balance = balance ?? "0";
              if (mounted) {
                setState(() {
                  this.displayDigitsList[index].balance = balance ?? "0";
                });
              }
            }
            loadDigitMoney(); //If you have a balance, go to calculate the money value
          }
          break;
        case ChainType.EEE:
        case ChainType.EEE_TEST:
          {
            ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
            for (var i = 0; i < displayDigitsList.length; i++) {
              int index = i;
              String balance = "0";

              if (this.displayDigitsList[index].shortName.toLowerCase() == config.eeeSymbol.toLowerCase()) {
                Map eeeStorageKeyMap =
                    await scryXNetUtil.loadEeeStorageMap(config.systemSymbol, config.accountSymbol, Wallets.instance.nowWallet.nowChain.pubKey);
                if (eeeStorageKeyMap != null && eeeStorageKeyMap.containsKey("status") && eeeStorageKeyMap["status"] == 200) {
                  try {
                    String eeeFree = eeeStorageKeyMap["free"] ?? "0";
                    balance = (BigInt.parse(eeeFree) / config.eeeUnit).toStringAsFixed(5) ?? "0";
                    if (balance == null || double.parse(balance) == double.parse("0")) {
                      continue;
                    }
                  } catch (e) {
                    LogUtil.e("_loadingBalanceTimerTask error is =>", e.toString());
                  }
                  Wallets.instance.nowWallet.nowChain.digitsList[index].balance = balance;
                  this.displayDigitsList[index].balance = balance;
                }
              } else if (this.displayDigitsList[index].shortName.toLowerCase() == config.tokenXSymbol.toLowerCase()) {
                Map tokenBalanceMap =
                    await scryXNetUtil.loadTokenXbalance(config.tokenXSymbol, config.balanceSymbol, Wallets.instance.nowWallet.nowChain.pubKey);
                if (tokenBalanceMap != null && tokenBalanceMap.containsKey("result")) {
                  try {
                    double tokenBalance = BigInt.parse(Utils.reverseHexValue2SmallEnd(tokenBalanceMap["result"]), radix: 16) / config.eeeUnit;
                    balance = tokenBalance.toStringAsFixed(5);
                    if (balance == null || double.parse(balance) == double.parse("0")) {
                      continue;
                    }
                  } catch (e) {
                    LogUtil.e("_loadingBalanceTimerTask error is =>", e.toString());
                  }
                  this.displayDigitsList[index].balance = balance ?? "";
                  Wallets.instance.nowWallet.nowChain.digitsList[index].balance = balance ?? "";
                }
              } else {
                Fluttertoast.showToast(msg: translate('eee_config_error').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
              }
              if (mounted) {
                setState(() {
                  this.displayDigitsList[index].balance = balance ?? "0";
                });
              }
            }
          }
          break;
        default:
          break;
      }
    });
  }

  //Corresponding to the number of tokens, the value of the market fiat currency
  loadDigitMoney() {
    if (displayDigitsList == null || displayDigitsList.length == 0) {
      return;
    }
    if (_loadingDigitMoneyTask != null) {
      _loadingDigitMoneyTask.cancel();
    }
    _loadingBalanceTimerTask = Timer(const Duration(milliseconds: 1000), () async {
      for (var i = 0; i < displayDigitsList.length; i++) {
        var index = i;
        nowWalletAmount = 0;
        var money = Rate.instance.getMoney(displayDigitsList[index]).toStringAsFixed(3);
        allVisibleDigitsList[i].money = money;
        if (mounted) {
          setState(() {
            nowWalletAmount = nowWalletAmount + Rate.instance.getMoney(displayDigitsList[index]);
            Wallets.instance.nowWallet.accountMoney = nowWalletAmount.toStringAsFixed(5);
            displayDigitsList[index].money = money;
          });
        }
      }
    });
  }

  //Display token list
  Future<List<Digit>> loadDisplayDigitListData() async {
    if (displayDigitsList.length == 0) {
      //No display data
      if (allVisibleDigitsList.length < singleDigitCount) {
        //Not enough pages loaded, full display
        addDigitToDisplayList(allVisibleDigitsList.length);
      } else {
        //Super page, showing singleDigitCount.
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //There are display data, continue to add
      if (allVisibleDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //More than one page left
        addDigitToDisplayList(singleDigitCount);
      } else {
        //If there is not enough one page left, all will be added.
        addDigitToDisplayList(allVisibleDigitsList.length - displayDigitsList.length);
      }
    }
    return displayDigitsList;
  }

  //Display allVisibleDigitsList in displayDigitsList. That is: add data to displayDigitsList
  List<Digit> addDigitToDisplayList(int targetCount) {
    for (var i = displayDigitsList.length; i < targetCount; i++) {
      var digitRate = DigitRate();
      Digit digit = EthDigit();
      digit
        ..digitId = allVisibleDigitsList[i].digitId
        ..chainId = allVisibleDigitsList[i].chainId
        ..decimal = allVisibleDigitsList[i].decimal
        ..shortName = allVisibleDigitsList[i].shortName
        ..fullName = allVisibleDigitsList[i].fullName
        ..balance = allVisibleDigitsList[i].balance
        ..contractAddress = allVisibleDigitsList[i].contractAddress
        ..address = allVisibleDigitsList[i].address
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
            Container(
              child: _isShowAddDigitBtn()
                  ? Positioned(
                      bottom: ScreenUtil().setHeight(5),
                      child: _buildAddDigitButton(),
                    )
                  : Text(""),
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
        future: digitListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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
        //Token list bar, pull down to refresh||load data.
        await Future.delayed(
          Duration(seconds: 2),
          () {
            if (mounted) {
              setState(() {
                if (displayDigitsList.length < allVisibleDigitsList.length) {
                  // allVisibleDigitsList is still not displayed
                  // When pulling down to refresh, load the new digit to displayDigitsList
                  loadDisplayDigitListData();
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
                Provider.of<TransactionProvide>(context)
                  ..emptyDataRecord()
                  ..setDigitName(displayDigitsList[index].shortName)
                  ..setBalance(displayDigitsList[index].balance)
                  ..setMoney(displayDigitsList[index].money)
                  ..setDecimal(displayDigitsList[index].decimal)
                  ..setFromAddress(Wallets.instance.nowWallet.nowChain.chainAddress)
                  ..setChainType(Wallets.instance.nowWallet.nowChain.chainType)
                  ..setContractAddress(displayDigitsList[index].contractAddress);
              }
              switch (Wallets.instance.nowWallet.nowChain.chainType) {
                case ChainType.EEE:
                case ChainType.EEE_TEST:
                  NavigatorUtils.push(context, Routes.eeeChainTxHistoryPage);
                  break;
                case ChainType.ETH_TEST:
                case ChainType.ETH:
                  NavigatorUtils.push(context, Routes.ethChainTxHistoryPage);
                  break;
                default:
                  LogUtil.e("switch chainType error is --->", "unknown which chainType");
                  break;
              }
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
                                    moneyUnitStr +
                                        " " +
                                        (rateInstance == null
                                            ? ""
                                            : rateInstance.getPrice(displayDigitsList[index]).toStringAsFixed(5) ?? "0"), //Market unit price
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(2.5)),
                                    child: Text(
                                      displayDigitsList[index].digitRate.getChangeDaily ?? "0%", //Market price fluctuations
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
              Provider.of<TransactionProvide>(context)..setChainType(Wallets.instance.nowWallet.nowChain.chainType);
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
              _navigatorToQrInfoPage(walletName, translate('chain_address_info'), Wallets.instance.nowWallet.nowChain.chainAddress);
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
          future: digitListFuture,
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
                  bool isSetNowChain = await Wallets.instance.nowWallet.setNowChainType(Wallets.instance.nowWallet.chainList[index]);
                  if (isSetNowChain) {
                    if (mounted) {
                      setState(() {
                        this.chainIndex = index;
                        Wallets.instance.nowWallet.nowChain.chainAddress = Wallets.instance.nowWallet.nowChain.chainAddress;
                        this.allVisibleDigitsList = Wallets.instance.nowWallet.nowChain.getVisibleDigitList(); //init data
                        this.displayDigitsList = [];
                        loadDisplayDigitListData();
                      });
                    }
                  }
                  loadDigitBalance();
                  loadDigitRateInfo();
                },
                index: chainIndex,
                itemCount: this.allVisibleChainsList.length,
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
        onTap: () {
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
                if (walletName.isEmpty || Wallets.instance.nowWallet.nowChain.chainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, translate('chain_address_info'), Wallets.instance.nowWallet.nowChain.chainAddress);
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
                if (walletName.isEmpty || Wallets.instance.nowWallet.nowChain.chainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, translate('chain_address_info'), Wallets.instance.nowWallet.nowChain.chainAddress);
              },
              child: Text(
                Wallets.instance.nowWallet.nowChain.chainAddress,
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
              Chain.chainTypeToValue(Wallets.instance.nowWallet.nowChain.chainType),
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

  bool _isShowAddDigitBtn() {
    if (Wallets.instance.nowWallet == null || Wallets.instance.nowWallet.nowChain == null) {
      return false;
    }
    switch (Wallets.instance.nowWallet.nowChain.chainType) {
      case ChainType.ETH:
      case ChainType.ETH_TEST:
        return true;
      default:
        return false;
    }
  }

  void _navigatorToQrInfoPage(String title, String hintInfo, String content) {
    //Temporary use of data status management processing, routing function fluro Chinese pass value will have problems.
    Provider.of<QrInfoProvide>(context).setTitle(title);
    Provider.of<QrInfoProvide>(context).setHintInfo(hintInfo);
    Provider.of<QrInfoProvide>(context).setContent(content);

    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
