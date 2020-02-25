import 'package:app/generated/i18n.dart';
import 'package:app/page/transaction_history_page/transaction_history_page.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eth_page/eth_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dapp_page/dapp_page.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  var allWalletList = List();
  bool _agreeServiceProtocol = true;
  bool isContainWallet = false;
  Future future;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initData(); //case 删除钱包后，没钱包，回到entryPage
  }

  void _initData() async {
    future = _checkIsContainWallet();
  }

  Future<bool> _checkIsContainWallet() async {
    isContainWallet = await Wallets.instance.isContainWallet();
    return isContainWallet;
  }

  @override
  Widget build(BuildContext context) {
    ///初始化屏幕 宽高比 ，以 cashbox切图中，标注XXXHDPI@4x 为准
    ScreenUtil.instance = ScreenUtil(width: 90, height: 160)..init(context);

    return Container(
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("entryPage snapshot.error==>" + snapshot.error.toString());
              LogUtil.e("entryPage future snapshot.hasError is +>", snapshot.error.toString());
              return Center(
                child: Text(
                  S.of(context).wallet_load_error,
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            if (snapshot.hasData) {
              bool isContainWallet = snapshot.data;
              if (isContainWallet) {
                //return DappPage(); // todo  标记，先版本，直接进入到Dapp diamond页面处
                return EthPage();
                // return TransactionHistoryPage();
              } else {
                return _buildProtocolLayout();
              }
            }
            return TransactionHistoryPage();
            /*return Container(
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setHeight(160),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg_loading.png"), fit: BoxFit.fill),
              ),
              child: null,
            );*/
          }),
    );
  }

  Widget _buildProtocolLayout() {
    return Material(
      child: Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_loading.png"), fit: BoxFit.fill),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(30),
              _buildLogoWidget(),
              //Gaps.scaleVGap(2.5),
              _buildLogoTextWidget(),
              Gaps.scaleVGap(28.5),
              _buildCreateWalletWidget(),
              Gaps.scaleVGap(6.5),
              _buildImportWalletWidget(),
              Gaps.scaleVGap(10),
              _buildProtocolCheckBoxWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoWidget() {
    return Container(
      child: Image.asset("assets/images/ic_logo.png"),
    );
  }

  Widget _buildLogoTextWidget() {
    return Container(
      child: Image.asset("assets/images/ic_logotxt.png"),
    );
  }

  Widget _buildCreateWalletWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (!_agreeServiceProtocol) {
            Fluttertoast.showToast(msg: S.of(context).make_sure_service_protocol);
            return;
          }
          NavigatorUtils.push(context, Routes.createWalletNamePage);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/ic_add.png"),
            ),
            Gaps.scaleHGap(2.5),
            Text(
              "添加钱包",
              style:
                  TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil.instance.setSp(4), fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportWalletWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (!_agreeServiceProtocol) {
            Fluttertoast.showToast(msg: S.of(context).make_sure_service_protocol);
            return;
          }
          NavigatorUtils.push(context, Routes.importWalletPage);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/ic_import.png"),
            ),
            Gaps.scaleHGap(2.5),
            Text(
              "导入钱包",
              style:
                  TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil.instance.setSp(4), fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolCheckBoxWidget() {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              value: _agreeServiceProtocol,
              onChanged: (newValue) {
                setState(
                  () {
                    _agreeServiceProtocol = newValue;
                  },
                );
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(14),
              width: ScreenUtil().setWidth(70),
              child: Row(
                children: <Widget>[
                  Text(
                    S.of(context).agree_service_prefix,
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil.instance.setSp(3), fontStyle: FontStyle.normal),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigatorUtils.push(context, Routes.serviceAgreementPage);
                    },
                    child: Text(
                      S.of(context).service_protocol_tag,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil.instance.setSp(3),
                          fontStyle: FontStyle.normal),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    "、",
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil.instance.setSp(3), fontStyle: FontStyle.normal),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigatorUtils.push(context, Routes.privacyStatementPage);
                    },
                    child: Text(
                      S.of(context).privacy_protocol_tag,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil.instance.setSp(3),
                          fontStyle: FontStyle.normal),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
