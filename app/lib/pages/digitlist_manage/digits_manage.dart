import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/model/token.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/app_info_util.dart';
import 'package:logger/logger.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/services.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'package:wallets/kits.dart';

class DigitsManagePage extends StatefulWidget {
  const DigitsManagePage({Key key, this.isReloadDigitList}) : super(key: key);

  final bool isReloadDigitList; //Whether to force reload of wallet digitList

  @override
  _DigitsManagePageState createState() => _DigitsManagePageState();
}

class _DigitsManagePageState extends State<DigitsManagePage> {
  List<TokenM> allDigitsList = [];
  List<TokenM> displayDigitsList = [];

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
      List<TokenM> allNativeDigitList = loadNativeToken();
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
  }

  List<TokenM> loadNativeToken() {
    List<TokenM> nativeTokenMList = [];
    var chainType = WalletsControl.getInstance().currentChainType();
    switch (chainType) {
      case ChainType.EthTest:
      case ChainType.ETH:
        List<EthChainToken> ethChainTokens = WalletsControl.getInstance().currentWallet().ethChain.tokens.data;
        ethChainTokens.forEach((element) {
          TokenM tokenM = TokenM()
            ..tokenId = element.chainTokenSharedId
            ..shortName = element.ethChainTokenShared.tokenShared.symbol
            ..contractAddress = element.contractAddress
            ..decimal = element.ethChainTokenShared.decimal
            ..urlImg = element.ethChainTokenShared.tokenShared.logoUrl ?? ""
            ..isVisible = element.show_1.isTrue();
          nativeTokenMList.add(tokenM);
        });
        break;
      default:
        Logger.getInstance().e("ChainType", "unknown chain type" + chainType.toString());
        break;
    }

    return nativeTokenMList;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    List<EthTokenOpen_Token> serverTokenList = await loadServerTokenList();
    if (serverTokenList == null) {
      return;
    }
    saveToAuthToken(serverTokenList);
    List<EthChainTokenAuth> ethChainTokenAuthList = EthChainControl.getInstance().getChainEthAuthTokenList(nativeDigitIndex, onePageOffSet);
    {
      if (ethChainTokenAuthList == null || ethChainTokenAuthList.length == 0) {
        isLoadAuthDigitFinish = true;
        return;
      }
      if (onePageOffSet == ethChainTokenAuthList.length) {
        this.nativeDigitIndex = this.nativeDigitIndex + onePageOffSet;
      } else {
        this.nativeDigitIndex = this.nativeDigitIndex + onePageOffSet;
        isLoadAuthDigitFinish = true;
      }
    }

    var authTokenList = formatTokenMList(ethChainTokenAuthList);
    addToAllDigitsList(authTokenList);
    pushToDisplayDigitList();
  }

  Future<List<EthTokenOpen_Token>> loadServerTokenList() async {
    final cashBoxType = "GA";
    final signInfo = "82499105f009f80a1fe2f1db86efdec7";
    final deviceId = "deviceIddddddd";
    final apkVersion = "2.0.0";
    var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), apkVersion, AppPlatformType.any, signInfo, "eeeddd", cashBoxType);
    var channel = createClientChannel(refresh.refreshCall);
    EthTokenOpen_QueryReq open_queryReq = new EthTokenOpen_QueryReq();

    BasicClientReq basicClientReq = new BasicClientReq();
    basicClientReq
      ..cashboxType = cashBoxType
      ..cashboxVersion = apkVersion
      ..deviceId = deviceId
      ..platformType = "aarch64-linux-android"
      ..signature = signInfo;

    PageReq pageReq = PageReq();
    pageReq..page = 0;
    open_queryReq
      ..info = basicClientReq
      ..page = pageReq
      ..isDefault = false;
    final ethTokenClient = EthTokenOpenFaceClient(channel);
    try {
      EthTokenOpen_QueryRes ethTokenOpenQueryRes = await ethTokenClient.query(open_queryReq);
      List<EthTokenOpen_Token> ethTokenList = ethTokenOpenQueryRes.tokens;
      return ethTokenList;
    } catch (e) {
      Logger.getInstance().e("rpc query error", "e is --->" + e.toString());
      return null;
    }
  }

  List<TokenM> formatTokenMList(List<EthChainTokenAuth> ethTokenList) {
    List<TokenM> nativeTokenMList = [];
    try {
      ethTokenList.forEach((element) {
        TokenM tokenM = TokenM()
          ..tokenId = element.chainTokenSharedId
          ..shortName = element.ethChainTokenShared.tokenShared.symbol
          ..fullName = element.ethChainTokenShared.tokenShared.name
          ..contractAddress = element.contractAddress
          ..decimal = element.ethChainTokenShared.decimal
          ..urlImg = element.ethChainTokenShared.tokenShared.logoUrl ?? ""
          ..isVisible = false;
        if (element.ethChainTokenShared.tokenShared.symbol.toLowerCase() == ChainType.ETH.toEnumString().toLowerCase()) {
          tokenM.address = WalletsControl().currentWallet().ethChain.chainShared.walletAddress.address;
        }
        nativeTokenMList.add(tokenM);
      });
      return nativeTokenMList;
    } catch (e) {
      print("EthTokenOpen_QueryReq  error is ------>" + e.toString());
      return null;
    }
  }

  saveToAuthToken(List<EthTokenOpen_Token> ethTokenList) async {
    List<EthChainTokenAuth> ethChainTokenList = [];
    ethTokenList.forEach((element) {
      EthChainTokenAuth ethChainTokenAuth = EthChainTokenAuth();
      ethChainTokenAuth
        ..chainTokenSharedId = element.tokenShardId
        ..position = element.position.toInt()
        ..contractAddress = element.contract
        ..netType = element.tokenShared.chainType
        ..ethChainTokenShared.decimal = element.decimal
        ..netType = element.tokenShared.netType
        ..ethChainTokenShared.tokenShared.name = element.tokenShared.name
        ..ethChainTokenShared.tokenShared.symbol = element.tokenShared.symbol
        ..ethChainTokenShared.gasLimit = element.gasLimit.toInt()
        ..ethChainTokenShared.tokenShared.logoUrl = element.tokenShared.logoUrl;
      ethChainTokenList.add(ethChainTokenAuth);
    });
    ArrayCEthChainTokenAuth arrayCEthChainTokenAuth = ArrayCEthChainTokenAuth();
    arrayCEthChainTokenAuth.data = ethChainTokenList;
    EthChainControl.getInstance().updateAuthTokenList(arrayCEthChainTokenAuth);
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
                  NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=true', clearStack: true);
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
        NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=true', clearStack: true);
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
              return [];
            }
            List<EthChainTokenAuth> ethChainTokenAuthList = EthChainControl.getInstance().getChainEthAuthTokenList(nativeDigitIndex, onePageOffSet);
            {
              if (ethChainTokenAuthList == null || ethChainTokenAuthList.length == 0) {
                isLoadAuthDigitFinish = true;
                return [];
              }
              if (onePageOffSet == ethChainTokenAuthList.length) {
                this.nativeDigitIndex = this.nativeDigitIndex + onePageOffSet;
              } else {
                this.nativeDigitIndex = this.nativeDigitIndex + onePageOffSet;
                isLoadAuthDigitFinish = true;
              }
            }
            var authTokenList = formatTokenMList(ethChainTokenAuthList);
            addToAllDigitsList(authTokenList);
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
                {
                  // save token to local, make sure token exist
                  TokenAddress tokenAddress = TokenAddress()
                    ..tokenId = displayDigitsList[index].tokenId
                    ..chainType = WalletsControl.getInstance().currentChainType().toEnumString()
                    ..walletId = WalletsControl.getInstance().currentWallet().id
                    ..balance = 0.toString()
                    ..addressId = WalletsControl.getInstance()
                            .getTokenAddressId(WalletsControl.getInstance().currentWallet().id, WalletsControl.getInstance().currentChainType()) ??
                        "";
                  bool isUpsertOk = WalletsControl.getInstance().updateBalance(tokenAddress);
                  if (!isUpsertOk) {
                    Logger.getInstance().e("updateBalance", "updateBalance failure ");
                    Fluttertoast.showToast(msg: translate("save_digit_model_failure"));
                    return;
                  }
                }

                WalletTokenStatus walletTokenStatus = WalletTokenStatus()
                  ..walletId = WalletsControl.getInstance().currentWallet().id
                  ..chainType = WalletsControl.getInstance().currentChainType().toEnumString()
                  ..tokenId = displayDigitsList[index].tokenId;
                if (displayDigitsList[index].isVisible) {
                  walletTokenStatus.isShow = false.toInt(); // change to invisible
                  bool isChangeOk = WalletsControl.getInstance().changeTokenStatus(walletTokenStatus);
                  if (!isChangeOk) {
                    Fluttertoast.showToast(msg: translate("hide_token_model_failure"));
                    return;
                  }
                  setState(() {
                    displayDigitsList[index].isVisible = false;
                  });
                } else {
                  walletTokenStatus.isShow = true.toInt(); // change to visible
                  bool isChangeOk = WalletsControl.getInstance().changeTokenStatus(walletTokenStatus);
                  if (!isChangeOk) {
                    Fluttertoast.showToast(msg: translate("show_token_model_failure"));
                    return;
                  }
                  setState(() {
                    displayDigitsList[index].isVisible = true;
                  });
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

  pushToDisplayDigitList() {
    int targetLength = 0;
    if (onePageOffSet < (allDigitsList.length - displayDigitsList.length)) {
      targetLength = onePageOffSet;
    } else {
      targetLength = allDigitsList.length - displayDigitsList.length;
    }
    List<TokenM> tempList = [];
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
  addToAllDigitsList(List<TokenM> newDigitList) {
    if (newDigitList == null || newDigitList.length == 0) {
      return;
    }
    for (num i = 0; i < newDigitList.length; i++) {
      var element = newDigitList[i];
      if (element.contractAddress != null && element.contractAddress.isNotEmpty) {
        //erc20
        bool isExistErc20 = false;
        for (num index = 0; index < allDigitsList.length; index++) {
          var digit = allDigitsList[index];
          if ((digit.contractAddress != null) &&
              (element.contractAddress != null) &&
              (digit.contractAddress.trim().toLowerCase() == element.contractAddress.trim().toLowerCase())) {
            isExistErc20 = true;
            break;
          }
        }
        if (!isExistErc20) {
          allDigitsList.add(element);
        }
      } else {
        bool isExistDigit = false;
        for (num index = 0; index < allDigitsList.length; index++) {
          var digit = allDigitsList[index];
          if ((digit.shortName != null) && (element.shortName != null) && (digit.shortName == element.shortName)) {
            isExistDigit = true;
            break;
          }
        }
        if (!isExistDigit) {
          allDigitsList.add(element);
        }
      }
    }
  }
}
