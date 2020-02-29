import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/digit.dart';
import 'package:app/model/rate.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
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
import '../eth_page/left_drawer_card.dart';

class EthPage extends StatefulWidget {
  @override
  _EthPageState createState() => _EthPageState();
}

class _EthPageState extends State<EthPage> {
  List<Wallet> walletList = [];
  Wallet nowWallet = Wallet();
  static int singleDigitCount = 20; //单页面显示20条数据，一次下拉刷新更新20条
  String moneyUnitStr = "USD";
  List<String> moneyUnitList = ["USD", "CNY", "KRW", "GBP", "JPY"];
  List<String> chainTypeList = ["EEE"]; //"BTC", "ETH",
  Chain nowChain;
  String nowChainAddress = "";
  String walletName = "";
  Future future;
  List<Digit> nowChainDigitsList = []; //链上获取到的所有代币数据
  List<Digit> displayDigitsList = []; //当前分页展示的固定代币数量信息

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    this.walletList = await Wallets.instance.loadAllWalletList(isForceLoadFromJni: true);
    print("eth_page => initData walletlist.length===>" + walletList.length.toString());
    Fluttertoast.showToast(msg: "this.walletList.length.toString===>" + this.walletList.length.toString());
    for (int i = 0; i < walletList.length; i++) {
      int index = i;
      Wallet wallet = walletList[index];
      print("isNowWallet===>" + wallet.isNowWallet.toString() + wallet.walletId.toString() + "walletName===>" + wallet.walletName.toString());
      if (wallet.isNowWallet == true) {
        setState(() {
          this.nowWallet = wallet;
          this.walletName = nowWallet.walletName;
          print("nowWallet.walletType======>" + nowWallet.walletType.toString());
          if (nowWallet.walletType == WalletType.WALLET) {
            this.nowChain = this.nowWallet.getChainByChainType(ChainType.ETH);
          } else {
            this.nowChain = this.nowWallet.getChainByChainType(ChainType.EEE_TEST);
          }
          print("this.nowChain======>" + this.nowChain.toString());
          this.nowChainAddress = nowChain.chainAddress;
          this.nowChainDigitsList = nowChain.digitsList;
        });
        break; //找到，终止循环
      }
    }
    setState(() {
      this.walletList = walletList;
    });
    future = loadDisplayDigitListData();
  }

  loadDigitBalance() async {
    print("loadDigitBalance is enter ===>" + displayDigitsList.length.toString());
    if (displayDigitsList.length == 0) {
      return;
    } else {
      for (var i = 0; i < displayDigitsList.length; i++) {
        print("loadDigitBalance    displayDigitsList[i].contractAddress===>" +
            this.displayDigitsList[i].contractAddress.toString() +
            "||" +
            this.displayDigitsList[i].address.toString());
        String balance;
        if (this.displayDigitsList[i].contractAddress != null && this.displayDigitsList[i].contractAddress.trim() != "") {
          balance = await loadErc20Balance(nowChainAddress, this.displayDigitsList[i].contractAddress, nowChain.chainType);
          print("erc20 balance==>" + balance.toString());
        } else if (nowChainAddress != null && nowChainAddress.trim() != "") {
          balance = await loadEthBalance(nowChainAddress, nowChain.chainType);
          print("eth balance==>" + balance.toString());
        } else {}
        this.displayDigitsList[i].balance = balance ?? "0.00";
      }
    }
  }

  Future<List<Digit>> loadDisplayDigitListData() async {
    if (displayDigitsList.length == 0) {
      //没有展示数据
      if (nowChainDigitsList.length < singleDigitCount) {
        //加载到的不够一页，全展示
        addDigitToDisplayList(nowChainDigitsList.length);
      } else {
        //超一页，展示singleDigitCount个。
        addDigitToDisplayList(singleDigitCount);
      }
    } else {
      //有展示数据，继续往里添加
      if (nowChainDigitsList.length - displayDigitsList.length > singleDigitCount) {
        //剩余的超过一页
        addDigitToDisplayList(singleDigitCount);
      } else {
        //剩余的不够一页，全给加入进去。
        addDigitToDisplayList(nowChainDigitsList.length - displayDigitsList.length);
      }
    }
    await loadDigitBalance();
    return displayDigitsList;
  }

  List<Digit> addDigitToDisplayList(int targetCount) {
    for (var i = displayDigitsList.length; i < targetCount; i++) {
      var digitRate = DigitRate();
      digitRate.volume = 0.035;
      digitRate.changeHourly = 0.096;

      Digit digit = EthDigit();
      digit
        ..chainId = nowChainDigitsList[i].chainId
        ..decimal = nowChainDigitsList[i].decimal
        ..shortName = nowChainDigitsList[i].shortName
        ..fullName = nowChainDigitsList[i].fullName
        ..balance = nowChainDigitsList[i].balance
        ..contractAddress = nowChainDigitsList[i].contractAddress
        ..address = nowChainDigitsList[i].address
        ..digitRate = digitRate; //todo
      //..money =  nowChainDigitsList[i].money;
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
          walletName ?? walletName,
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: LeftDrawerCard(), //左侧抽屉栏
      body: Container(
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
          ],
        ),
      ),
    );
  }

  //代币列表展示卡片
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
                "代币信息为空",
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
            setState(
              () {
                //todo 根据 JNI walletList每次refreshDataList +singleDigitCount 条显示数据
                if (displayDigitsList.length < nowChainDigitsList.length) {
                  // 从JNI加载的数据还有没显示完的，继续将nowChainDigitsList剩余数据，
                  // 添加到 displayDigitsList里面做展示
                  loadDisplayDigitListData(); //下拉刷新的时候，加载新digit到displayDigitsList
                } else {
                  //todo ，继续调jni获取，或者提示已经没数据了。 根据是否jni分页处理来决定。
                }
              },
            );
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
                  ..setDecimal(displayDigitsList[index].decimal)
                  ..setFromAddress(nowChainAddress)
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
                                child: Text(
                                  "≈" + moneyUnitStr + " " + "0",
                                  //"≈" + displayDigitsList[index].money,
                                  style: TextStyle(color: Colors.white, fontSize: ScreenUtil.instance.setSp(3)),
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
                                    displayDigitsList[index].digitRate.price ?? "0", //市场单价
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: ScreenUtil.instance.setSp(2.5),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(2.5)),
                                    child: Text(
                                      "0%", //市场价格波动
                                      style: TextStyle(color: Colors.yellowAccent, fontSize: ScreenUtil.instance.setSp(2.5)),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: FractionalOffset.topRight,
                                child: Text(
                                  "0", //最近一笔交易记录
                                  style: TextStyle(fontSize: ScreenUtil.instance.setSp(2.5), color: Colors.greenAccent),
                                ),
                              ),
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
          Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(10),
              child: GestureDetector(
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
                onTap: () {
                  NavigatorUtils.push(context, Routes.transferEthPage);
                },
              )),
          Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(10),
            child: GestureDetector(
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
              onTap: () {
                _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, nowChainAddress);
              },
            ),
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
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(42.75),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(8.5), top: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_card.png"), fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chainCardMoneyWidget(),
                  Gaps.scaleVGap(10),
                  _chainCardAddressWidget(index),
                ],
              ),
            ),
          );
        },
        itemCount: chainTypeList.length,
        pagination: new SwiperPagination(
          builder: SwiperPagination(
            builder: SwiperPagination.rect, //切页面图标
          ),
        ),
        autoplay: false,
      ),
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
              height: ScreenUtil().setHeight(7),
              width: ScreenUtil().setWidth(30),
              alignment: Alignment.centerLeft,
              child: new Text(
                moneyUnitStr + " 0.00000",
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
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                      value: 'USD',
                      child: new Text(
                        'USD',
                        style: new TextStyle(color: Colors.white),
                      )),
                  new PopupMenuItem<String>(
                      value: 'CNY',
                      child: new Text(
                        'CNY',
                        style: new TextStyle(color: Colors.white),
                      )),
                  new PopupMenuItem<String>(
                      value: 'KRW',
                      child: new Text(
                        'KRW',
                        style: new TextStyle(color: Colors.white),
                      )),
                  new PopupMenuItem<String>(
                      value: 'GBP',
                      child: new Text(
                        'GBP',
                        style: new TextStyle(color: Colors.white),
                      )),
                  new PopupMenuItem<String>(
                      value: 'JPY',
                      child: new Text(
                        'JPY',
                        style: new TextStyle(color: Colors.white),
                      ))
                ],
                onSelected: (String value) {
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

  //链卡片 地址address
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
                _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, nowChainAddress);
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
                _navigatorToQrInfoPage(walletName, S.of(context).chain_address_info, nowChainAddress);
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
    //暂用 数据状态管理 处理， 路由功能fluro中文传值会有问题。
    Provider.of<QrInfoProvide>(context).setTitle(title);
    Provider.of<QrInfoProvide>(context).setHintInfo(hintInfo);
    Provider.of<QrInfoProvide>(context).setContent(content);

    NavigatorUtils.push(context, Routes.qrInfoPage);
  }
}
