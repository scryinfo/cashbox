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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';

class EthPage extends StatefulWidget {
  const EthPage({Key key, this.isForceLoadFromJni}) : super(key: key);

  final bool isForceLoadFromJni; //是否强制重新加载钱包信息

  @override
  _EthPageState createState() => _EthPageState();
}

class _EthPageState extends State<EthPage> {
  List<Wallet> walletList = [];
  Wallet nowWallet = Wallet();
  static int singleDigitCount = 20; //单页面显示20条数据，一次下拉刷新更新20条
  String moneyUnitStr = "USD";
  num nowWalletAmount = 0.00; //当前钱包内代币总市价
  List<String> moneyUnitList = [];
  String walletName = "";
  Future digitListFuture;
  List<Digit> allVisibleDigitsList = []; //当前链所有可见代币列表
  List<Digit> displayDigitsList = []; //当前分页展示的固定代币数量信息
  num chainIndex = 0; //当前链的下标

  @override
  void initState() {
    super.initState();
    initData();
    print("initState =========================>");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies =========================>");
  }

  @override
  void didUpdateWidget(EthPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget =========================>");
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
        this.walletName = nowWallet.walletName;
        //todo 查看是否需要 判钱包类型 测试处理
        break; //找到，终止循环
      }
    }
    this.allVisibleDigitsList = this.nowWallet.nowChain.getVisibleDigitList(); //init data
    digitListFuture = loadDisplayDigitListData();
    chainIndex = this.nowWallet.chainList.indexOf(this.nowWallet.nowChain);
    print("chainIndex=======>" + chainIndex.toString());
    setState(() {
      this.walletList = walletList;
    });
    loadDigitBalance();
    loadLegalCurrency();
    //loadDigitRateInfo(); //todo
  }

  loadLegalCurrency() async {
    Rate rate = await loadRateInstance();
    if (rate == null) {
      return;
    }
    this.moneyUnitList = rate.getAllSupportLegalCurrency();
    setState(() {
      this.moneyUnitList = this.moneyUnitList;
    });
  }

  //市场价格 变化（每小时）
  loadDigitRateInfo() async {
    if (displayDigitsList.length == 0) {
      return;
    } else {
      Rate rate = await loadRateInstance();
      if (rate == null) {
        return;
      }
      for (var i = 0; i < displayDigitsList.length; i++) {
        print("rate.digitRateMap.length ===>" + rate.digitRateMap.length.toString());
        if (this.displayDigitsList[i].shortName.toUpperCase() != null &&
            (rate.digitRateMap.containsKey(this.displayDigitsList[i].shortName.toUpperCase()))) {
          setState(() {
            this.displayDigitsList[i].digitRate
              ..symbol = rate.getSymbol(this.displayDigitsList[i])
              ..price = rate.getPrice(this.displayDigitsList[i])
              ..changeHourly = rate.getChangeHourly(this.displayDigitsList[i]);
          });
        } else {
          print("digitName is not exist===>" + this.displayDigitsList[i].shortName);
          LogUtil.w("digitName is not exist===>", this.displayDigitsList[i].shortName);
        }
      }
    }
  }

  loadDigitBalance() async {
    print("loadDigitBalance is enter ===>" + displayDigitsList.length.toString());
    if (displayDigitsList == null || displayDigitsList.length == 0) {
      return;
    } else {
      for (var i = 0; i < displayDigitsList.length; i++) {
        print("loadDigitBalance  contractAddress===>" +
            this.displayDigitsList[i].contractAddress.toString() +
            "|| address====>" +
            this.displayDigitsList[i].address.toString());
        String balance;
        if (this.displayDigitsList[i].contractAddress != null && this.displayDigitsList[i].contractAddress.trim() != "") {
          balance = await loadErc20Balance(
              this.nowWallet.nowChain.chainAddress, this.displayDigitsList[i].contractAddress, this.nowWallet.nowChain.chainType);
          print("erc20 balance==>" + balance.toString());
          Wallets.instance.updateDigitBalance(this.displayDigitsList[i].contractAddress, this.displayDigitsList[i].digitId, balance ?? "");
        } else if (this.nowWallet.nowChain.chainAddress != null && this.nowWallet.nowChain.chainAddress.trim() != "") {
          balance = await loadEthBalance(this.nowWallet.nowChain.chainAddress, this.nowWallet.nowChain.chainType);
          print("eth balance==>" + balance.toString());
          Wallets.instance.updateDigitBalance(this.nowWallet.nowChain.chainAddress, this.displayDigitsList[i].digitId, balance ?? "");
        } else {}
        allVisibleDigitsList[i].balance = balance ?? "0";
        setState(() {
          this.displayDigitsList[i].balance = balance ?? "0";
        });
      }
      loadDigitMoney(); //有余额了再去计算money值
    }
  }

  //代币数量对应的，市场法币的值
  loadDigitMoney() {
    for (var i = 0; i < displayDigitsList.length; i++) {
      var index = i;
      nowWalletAmount = 0;
      var money = Rate.instance.getMoney(displayDigitsList[index]).toStringAsFixed(3);
      allVisibleDigitsList[i].money = money;
      setState(() {
        nowWalletAmount = nowWalletAmount + Rate.instance.getMoney(displayDigitsList[index]);
        nowWallet.accountMoney = nowWalletAmount.toStringAsFixed(5);
        displayDigitsList[index].money = money;
      });
    }
  }

  Future<List<Digit>> loadDisplayDigitListData() async {
    if (displayDigitsList.length == 0) {
      //没有展示数据
      if (allVisibleDigitsList.length < singleDigitCount) {
        //加载到的不够一页，全展示
        addDigitToDisplayList(allVisibleDigitsList.length);
      } else {
        //超一页，展示singleDigitCount个。
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //有展示数据，继续往里添加
      if (allVisibleDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //剩余的超过一页
        addDigitToDisplayList(singleDigitCount);
      } else {
        //剩余的不够一页，全给加入进去。
        addDigitToDisplayList(allVisibleDigitsList.length - displayDigitsList.length);
      }
    }
    return displayDigitsList;
  }

  //将 allVisibleDigitsList 分页展示在displayDigitsList里面。即：往displayDigitsList里面加数据
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
      drawer: LeftDrawerCard(), //左侧抽屉栏
      body: Container(
        width: ScreenUtil.instance.setWidth(90),
        height: ScreenUtil.instance.setHeight(160),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                _buildChainCard(), //链卡片swipe
                _buildMiddleFuncCard(), //功能位置
                _buildDigitListCard(), //代币列表
                //DigitListCard(),
              ],
            ),
            Positioned(
              bottom: ScreenUtil.instance.setHeight(5),
              child: _buildAddDigitButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddDigitButton() {
    return Container(
      width: ScreenUtil.instance.setWidth(90),
      height: ScreenUtil.instance.setHeight(9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(26, 141, 198, 0.40),
            child: FlatButton(
              child: Text(
                S.of(context).digit_manage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  letterSpacing: 0.03,
                  fontSize: ScreenUtil.instance.setSp(3.2),
                ),
              ),
              onPressed: () {
                NavigatorUtils.push(context, Routes.digitManagePage);
              },
            ),
          )
        ],
      ),
    );
  }

  //代币列表展示卡片
  Widget _buildDigitListCard() {
    return Container(
      height: ScreenUtil().setHeight(78),
      width: ScreenUtil().setWidth(90),
      child: FutureBuilder(
        future: digitListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("snapshot.error==>" + snapshot.error.toString());
            LogUtil.e("digitList future snapshot.hasError is +>", snapshot.error.toString());
            return Center(
              child: Text(
                S.of(context).failure_to_load_data_pls_retry,
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
                S.of(context).digit_info_null.toString(),
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
        },
      ),
    );
  }

  //代币列表layout
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
        //代币列表栏，下拉 刷新||加载 数据。
        await Future.delayed(
          Duration(seconds: 2),
          () {
            setState(() {
              if (displayDigitsList.length < allVisibleDigitsList.length) {
                // allVisibleDigitsList还有没显示完的
                // 下拉刷新的时候，加载新digit到displayDigitsList
                loadDisplayDigitListData();
              } else {
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
            onTap: () {
              {
                Provider.of<TransactionProvide>(context)
                  ..setDigitName(displayDigitsList[index].shortName)
                  ..setBalance(displayDigitsList[index].balance)
                  ..setMoney(displayDigitsList[index].money)
                  ..setDecimal(displayDigitsList[index].decimal)
                  ..setFromAddress(this.nowWallet.nowChain.chainAddress)
                  ..setChainType(this.nowWallet.nowChain.chainType)
                  ..setContractAddress(displayDigitsList[index].contractAddress);
              }
              NavigatorUtils.push(context, Routes.transactionHistoryPage);
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
                                    fontSize: ScreenUtil.instance.setSp(3),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(0.0),
                                  width: ScreenUtil.instance.setWidth(30),
                                  child: Text(
                                    "≈" + moneyUnitStr + " " + displayDigitsList[index].money ?? "0.00",
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.white, fontSize: ScreenUtil.instance.setSp(3)),
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
                                    moneyUnitStr + " " + (displayDigitsList[index].digitRate.getPrice(moneyUnitStr).toStringAsFixed(5) ?? "0"), //市场单价
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: ScreenUtil.instance.setSp(2.5),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(2.5)),
                                    child: Text(
                                      displayDigitsList[index].digitRate.getChangeHour ?? "0%", //市场价格波动
                                      style: TextStyle(color: Colors.yellowAccent, fontSize: ScreenUtil.instance.setSp(2.5)),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Opacity(
                                    opacity: 0,
                                    child: Text(
                                      "0", //最近一笔交易记录
                                      style: TextStyle(fontSize: ScreenUtil.instance.setSp(2.5), color: Colors.greenAccent),
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

  //转账&&地址 功能卡片
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
                    S.of(context).transfer,
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                  )
                ],
              ),
            ),
            onTap: () {
              Provider.of<TransactionProvide>(context)..setChainType(this.nowWallet.nowChain.chainType);
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
                        S.of(context).receive,
                        style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                      )),
                ],
              ),
            ),
            onTap: () {
              _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, this.nowWallet.nowChain.chainAddress);
            },
          )
        ],
      ),
    );
  }

  //链卡片
  Widget _buildChainCard() {
    return Container(
      width: ScreenUtil().setWidth(77.5),
      height: ScreenUtil().setHeight(42.75),
      child: FutureBuilder(
          future: digitListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(S.of(context).load_data_error);
            }
            if (snapshot.hasData) {
              print("this.nowWallet.chainList.length snapshot.hasData===>" + this.nowWallet.chainList.length.toString());
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  print("itemBuilder length====>" + this.nowWallet.chainList.length.toString());
                  print("itemBuilder index====>" + index.toString() + "||" + this.nowWallet.chainList[index].chainType.toString());
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
                index: chainIndex,
                onIndexChanged: (index) async {
                  print("onIndexChanged index======>" + index.toString() + "||" + this.nowWallet.chainList[index].chainType.toString());
                  bool isSetNowChain = await this.nowWallet.setNowChain(this.nowWallet.chainList[index]);
                  print("isSetNowChain===>" + isSetNowChain.toString());
                  if (isSetNowChain) {
                    setState(() {
                      this.chainIndex = index;
                      this.nowWallet.nowChain.chainAddress = this.nowWallet.nowChain.chainAddress;
                      this.allVisibleDigitsList = this.nowWallet.nowChain.getVisibleDigitList(); //init data
                      this.displayDigitsList = [];
                      loadDisplayDigitListData();
                    });
                  }
                  loadDigitBalance();
                  //loadDigitRateInfo();//todo
                },
                itemCount: this.nowWallet.chainList.length,
                pagination: new SwiperPagination(
                  builder: SwiperPagination(
                    builder: SwiperPagination.rect, //切页面图标
                  ),
                ),
                autoplay: false,
              );
            }
            return Text("");
          }),
    );
  }

  //链卡片money
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
                  //this.loadDigitMoney();//todo
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

  //链卡片 地址address
  Widget _chainCardAddressWidget(index) {
    print("nowChian===>" + this.nowWallet.nowChain.toString() + "||");
    print("_chainCardAddressWidget index======>" +
        index.toString() +
        "||" +
        this.nowWallet.chainList[index].chainType.toString() +
        "||" +
        Chain.chainTypeToValue(this.nowWallet.nowChain.chainType) +
        "||" +
        this.nowWallet.chainList[index].chainAddress.toString());
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                if (walletName.isEmpty || this.nowWallet.nowChain.chainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, this.nowWallet.nowChain.chainAddress);
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
                if (walletName.isEmpty || this.nowWallet.nowChain.chainAddress.isEmpty) {
                  return;
                }
                _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, this.nowWallet.nowChain.chainAddress);
              },
              child: Text(
                this.nowWallet.nowChain.chainAddress,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.lightBlueAccent),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Gaps.scaleHGap(4.5),
          Container(
            color: Colors.transparent,
            child: Container(
              width: ScreenUtil.instance.setWidth(28),
              child: Text(
                Chain.chainTypeToValue(this.nowWallet.nowChain.chainType),
                style: TextStyle(
                  fontSize: 45,
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigatorToQrInfoPage(String title, String hintInfo, String content) {
    print("_navigatorToQrInfoPage=>" + "target info is" + "addresspage?title=" + title + "&hintInfo=" + hintInfo + "&content=" + content);
    //暂用 数据状态管理 处理， 路由功能fluro中文传值会有问题。
    Provider.of<QrInfoProvide>(context).setTitle(title);
    Provider.of<QrInfoProvide>(context).setHintInfo(hintInfo);
    Provider.of<QrInfoProvide>(context).setContent(content);

    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
