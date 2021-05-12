import 'package:app/control/wallets_control.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:wallets/enums.dart' as EnumKit;

class ChangeNetTypePage extends StatefulWidget {
  @override
  _ChangeNetTypePageState createState() => _ChangeNetTypePageState();
}

class NetType extends Object {
  String enumNetType; // EnumKit.NetType
  String netTypeName;
}

class _ChangeNetTypePageState extends State<ChangeNetTypePage> {
  var curNetTypeString = EnumKit.NetType.Main.toEnumString();
  List<NetType> netTypeList = [
    NetType()
      ..enumNetType = EnumKit.NetType.Main.toEnumString()
      ..netTypeName = translate("main_net"),
    NetType()
      ..enumNetType = EnumKit.NetType.Test.toEnumString()
      ..netTypeName = translate("test_net"),
    /*NetType()
      ..enumNetType = EnumKit.NetType.Private.toEnumString()
      ..netTypeName = translate("private_main_net"),
    NetType()
      ..enumNetType = EnumKit.NetType.PrivateTest.toEnumString()
      ..netTypeName = translate("private_test_net"),*/
  ];

  @override
  void initState() {
    super.initState();
    curNetTypeString = WalletsControl.getInstance().getCurrentNetType().toEnumString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('net_change'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
          ),
          child: _buildNetTypeListWidget(context),
        ),
      ),
    );
  }

  Widget _buildNetTypeListWidget(context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        Gaps.scaleVGap(5),
        _buildNetItemWidget(context),
      ]),
    );
  }

  _buildNetItemWidget(context) {
    List<Widget> netTypesWidgetList = List.generate(netTypeList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () async {
            {
              // get back to main net,let it do directly
              if (netTypeList[index].enumNetType == EnumKit.NetType.Main.toEnumString()) {
                bool isChangeNetOk = WalletsControl.getInstance().changeNetType(EnumKit.NetType.Main);
                if (!isChangeNetOk) {
                  return;
                }
                if (WalletsControl.getInstance().hasAny()) {
                  // loadAll，and use first wallet as default
                  bool isSaveOk = WalletsControl.getInstance()
                      .saveCurrentWalletChain(WalletsControl.getInstance().walletsAll().first.walletId, EnumKit.ChainType.ETH);
                  if (!isSaveOk) {
                    Fluttertoast.showToast(msg: translate('failure_to_change_wallet'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
                    return;
                  }
                  NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
                } else {
                  NavigatorUtils.push(context, '${Routes.entrancePage}', clearStack: true);
                }
                return;
              }
            }
            // hint about test net
            Dialogs.materialDialog(
                msg: translate('make_sure_net_change_hint'),
                title: translate('net_change'),
                color: Colors.white,
                msgStyle: TextStyle(fontSize: ScreenUtil().setSp(3)),
                context: context,
                actions: [
                  IconsOutlineButton(
                    onPressed: () {
                      NavigatorUtils.goBack(context);
                    },
                    text: translate('cancel'),
                    iconData: Icons.cancel_outlined,
                    textStyle: TextStyle(color: Colors.grey),
                    iconColor: Colors.grey,
                  ),
                  IconsButton(
                    onPressed: () async {
                      bool isChangeNetOk = WalletsControl.getInstance().changeNetType(EnumKit.NetTypeEx.from(netTypeList[index].enumNetType));
                      if (!isChangeNetOk) {
                        return;
                      }
                      _navigateToNextPage();
                    },
                    text: translate('confirm'),
                    iconData: Icons.delete,
                    color: Colors.red,
                    textStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                ]);
          },
          child: Container(
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(13.5),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                  child: Text(
                    netTypeList[index].netTypeName ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(3.5),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                netTypeList[index].enumNetType != curNetTypeString
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(7),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset("assets/images/ic_checked.png"),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });

    return Column(
      children: netTypesWidgetList,
    );
  }

  _navigateToNextPage() {
    if (WalletsControl.getInstance().hasAny()) {
      // loadAll，and use first wallet as default
      bool isSaveOk = false;
      var curNetType = WalletsControl.getInstance().getCurrentNetType();
      switch (curNetType) {
        case EnumKit.NetType.Main:
          isSaveOk =
              WalletsControl.getInstance().saveCurrentWalletChain(WalletsControl.getInstance().walletsAll().first.walletId, EnumKit.ChainType.ETH);
          break;
        case EnumKit.NetType.Test:
          isSaveOk = WalletsControl.getInstance()
              .saveCurrentWalletChain(WalletsControl.getInstance().walletsAll().first.walletId, EnumKit.ChainType.EthTest);
          break;
        default:
          Fluttertoast.showToast(msg: translate('verify_failure_to_mnemonic'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
          return;
          break;
      }
      if (!isSaveOk) {
        Fluttertoast.showToast(msg: translate('failure_to_change_wallet'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
        return;
      }
      NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
    } else {
      NavigatorUtils.push(context, '${Routes.createTestWalletPage}', clearStack: true);
    }
  }
}
