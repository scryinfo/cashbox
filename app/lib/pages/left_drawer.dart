import 'package:app/control/qr_scan_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/provide/wc_info_provide.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:wallets/enums.dart' as Enum;
import 'package:wallets/enums.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  List<Wallet> walletList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    walletList = [];
    walletList = WalletsControl.getInstance().walletsAll() ?? [];
    setState(() {
      this.walletList = walletList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(160),
      color: Colors.white,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(ScreenUtil().setHeight(1)),
            Container(
              child: _drawerAction(),
            ),
            Gaps.scaleVGap(ScreenUtil().setHeight(1)),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: _drawerWalletList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawerAction() {
    return Container(
      height: ScreenUtil().setHeight(66.75),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_mine.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate('mine'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.minePage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_public.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate('public'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.publicPage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_public.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate('dapp'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.dappPage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_add.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate('create_wallet'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.createWalletNamePage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_import.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate('import_wallet'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.importWalletPage);
                }),
          ),
          /*Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_exchange.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  translate("token_exchange"),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.ddd2eeePage);
                }),
          ),*/
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(11),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_scan_left.png",
                  width: ScreenUtil().setWidth(4.5),
                  height: ScreenUtil().setWidth(4.5),
                ),
                title: new Text(
                  translate('scan'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  String qrInfo = await QrScanControl.instance.qrscan();
                  Logger.getInstance().d("scan qrInfo", qrInfo);
                  if (QrScanControl.instance.checkByWcProtocol(qrInfo, context)) {
                    context.read<WcInfoProvide>()
                      ..setWcInitUrl(qrInfo)
                      ..setSessionId(qrInfo.substring(3, qrInfo.indexOf("@")));
                    NavigatorUtils.push(context, Routes.wcApprovePage, clearStack: true);
                  } else {
                    // todo 提示检查格式 失败
                    Fluttertoast.showToast(msg: "unknown formation");
                  }
                }),
          )
        ],
      ),
    );
  }

  List<Widget> _drawerWalletList() {
    List<Widget> walletListWidget = List.generate(walletList.length, (index) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                color: WalletsControl.getInstance().isCurWallet(walletList[index]) ? Color.fromRGBO(152, 245, 255, 0.5) : Colors.transparent,
                child: GestureDetector(
                  onTap: () async {
                    bool isSaveOk = false;
                    switch (WalletsControl.getInstance().getCurrentNetType()) {
                      case NetType.Main:
                        isSaveOk = WalletsControl.getInstance().saveCurrentWalletChain(walletList[index].walletId, ChainType.ETH);
                        break;
                      case NetType.Test:
                        isSaveOk = WalletsControl.getInstance().saveCurrentWalletChain(walletList[index].walletId, ChainType.EthTest);
                        break;
                      default:
                        Fluttertoast.showToast(msg: translate('failure_to_change_wallet'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
                        return;
                        break;
                    }
                    if (!isSaveOk) {
                      Fluttertoast.showToast(msg: translate('failure_to_change_wallet'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
                      return;
                    }
                    NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gaps.scaleVGap(1),
                      Container(
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setWidth(18),
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(25),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    walletList[index] != null ? walletList[index].walletName : "",
                                    style: TextStyle(color: Colors.black87, fontSize: ScreenUtil().setSp(3)),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(18),
                                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(3)),
                                  child: Text(
                                    walletList[index].accountMoney ?? "0",
                                    style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(3)),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(1)),
                                  child: Image.asset("assets/images/ic_nav_enter.png"),
                                ),
                              ],
                            ),
                            Container(
                              height: ScreenUtil().setHeight(2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: _buildChainListCard(walletList[index]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(52),
                height: ScreenUtil().setHeight(0.05),
                child: CustomPaint(
                  foregroundPainter: MySeparatorLine(
                    lineColor: Colors.blueAccent,
                    width: ScreenUtil().setWidth(52),
                  ),
                ),
              )
            ],
          ));
    });
    return walletListWidget;
  }

  List<Widget> _buildChainListCard(Wallet wallet) {
    List<Chain> visibleChains = wallet.getVisibleChainList();
    List<Widget> chainsList = List.generate(visibleChains.length, (index) {
      return GestureDetector(
        onTap: () {
          Logger().d("check chainType ------->", visibleChains[index].chainType.toEnumString());
          switch (visibleChains[index].chainType) {
            case Enum.ChainType.EthTest:
              WalletsControl.getInstance().saveCurrentWalletChain(wallet.walletId, Enum.ChainType.EthTest);
              NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
              break;
            case Enum.ChainType.ETH:
              WalletsControl.getInstance().saveCurrentWalletChain(wallet.walletId, Enum.ChainType.ETH);
              NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
              break;
            case Enum.ChainType.EeeTest:
              WalletsControl.getInstance().saveCurrentWalletChain(wallet.walletId, Enum.ChainType.EeeTest);
              NavigatorUtils.push(context, '${Routes.eeeHomePage}?isForceLoadFromJni=false', clearStack: true);
              break;
            case Enum.ChainType.EEE:
              WalletsControl.getInstance().saveCurrentWalletChain(wallet.walletId, Enum.ChainType.EEE);
              NavigatorUtils.push(context, '${Routes.eeeHomePage}?isForceLoadFromJni=false', clearStack: true);
              break;
            default:
              break;
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: ScreenUtil().setHeight(7.5),
          width: ScreenUtil().setWidth(15),
          color: Colors.transparent,
          child: Text(
            visibleChains[index].chainType.toEnumString(),
            style: TextStyle(color: Color.fromRGBO(87, 205, 242, 1), fontSize: ScreenUtil().setSp(3)),
          ),
        ),
      );
    });
    return chainsList;
  }
}
