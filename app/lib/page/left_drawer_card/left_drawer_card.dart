import 'package:app/generated/i18n.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/util/qr_scan_util.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';

class LeftDrawerCard extends StatefulWidget {
  @override
  _LeftDrawerCardState createState() => _LeftDrawerCardState();
}

class _LeftDrawerCardState extends State<LeftDrawerCard> {
  List<Wallet> walletList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    walletList = [];
    walletList = await Wallets.instance.loadAllWalletList(); //在首页加载后，已经掉过接口了,拿缓存就行
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
                  String qrInfo = await QrScanUtil.instance.qrscan();
                  QrScanUtil.instance.checkByScryCityTransfer(qrInfo, context);
                }),
          ),
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
                color: walletList[index].isNowWallet ? Color.fromRGBO(60, 72, 88, 0.5) : Colors.transparent,
                child: GestureDetector(
                  onTap: () async {
                    print("wallet index is===> " + walletList[index].walletId + "|| isNowWallet===>" + walletList[index].isNowWallet.toString());
                    bool isSuccess = await Wallets.instance.setNowWallet(walletList[index].walletId);
                    if (isSuccess) {
                      //NavigatorUtils.push(context, '${Routes.ethPage}?isForceLoadFromJni=false', clearStack: true);
                      NavigatorUtils.push(context, Routes.eeePage, clearStack: true);
                    } else {
                      Fluttertoast.showToast(msg: translate('failure_to_change_wallet'), timeInSecForIos: 8);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gaps.scaleVGap(1),
                      Container(
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setWidth(13),
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
                                    style: TextStyle(color: Colors.black87, fontSize: ScreenUtil.instance.setSp(3)),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(18),
                                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(3)),
                                  child: Text(
                                    walletList[index].accountMoney ?? "0",
                                    style: TextStyle(color: Colors.grey, fontSize: ScreenUtil.instance.setSp(3)),
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
    List<Widget> chainsList = List.generate(wallet.chainList.length, (index) {
      Chain nowChain = wallet.chainList[index];
      //todo 2.0 目前diamond项目，hard code 只加载EEE链,不显示加载ETH链
      if (nowChain.chainType == ChainType.EEE || nowChain.chainType == ChainType.EEE_TEST) {
        /*
          if (nowChain.chainType == ChainType.ETH_TEST || nowChain.chainType == ChainType.ETH) {
            todo 2.0 手动写死，只加载eth链,不显示加载EEE链
        */
        return Container(
          alignment: Alignment.centerLeft,
          height: ScreenUtil().setHeight(7.5),
          width: ScreenUtil().setWidth(15),
          child: Text(
            Chain.chainTypeToValue(nowChain.chainType),
            style: TextStyle(color: Colors.black54, fontSize: ScreenUtil.instance.setSp(3)),
          ),
        );
      }
      return Container();
    });
    return chainsList;
  }
}
