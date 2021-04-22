import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/res/styles.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:logger/logger.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:wallets/enums.dart' as EnumKit;

class ChangeNetTypePage extends StatefulWidget {
  @override
  _ChangeNetTypePageState createState() => _ChangeNetTypePageState();
}

class _ChangeNetTypePageState extends State<ChangeNetTypePage> {
  List<NetType> netTypeList = [
    NetType()
      ..enumNetType = EnumKit.NetType.Main.toEnumString()
      ..netTypeName = "正式网络",
    NetType()
      ..enumNetType = EnumKit.NetType.Test.toEnumString()
      ..netTypeName = "测试网络",
    NetType()
      ..enumNetType = EnumKit.NetType.Private.toEnumString()
      ..netTypeName = "私有正式网络",
    NetType()
      ..enumNetType = EnumKit.NetType.PrivateTest.toEnumString()
      ..netTypeName = "私有测试网络",
  ];

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

  Future<bool> _loadNetType() async {
    Config config = await HandleConfig.instance.getConfig();
    for (var i = 0; i < netTypeList.length; i++) {
      var element = netTypeList[i];
      if (config.curNetType != null && element.enumNetType == config.curNetType.enumNetType) {
        element.isCurNet = true;
        netTypeList[i] = element;
        break;
      }
    }
    return true;
  }

  Widget _buildNetTypeListWidget(context) {
    return Container(
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setHeight(160),
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _loadNetType(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("something error happen" + snapshot.error.toString());
              } else if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Gaps.scaleVGap(5),
                  _buildNetItemWidget(context),
                ]);
              } else {
                return Text("no data,please reentry this page");
              }
            }));
  }

  _buildNetItemWidget(context) {
    List<Widget> netTypesWidgetList = List.generate(netTypeList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () async {
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
                      Config config = await HandleConfig.instance.getConfig();
                      netTypeList.forEach((element) {
                        element.isCurNet = false;
                      });
                      netTypeList[index].isCurNet = true;
                      config.curNetType = netTypeList[index];
                      bool isChangeNetOk = WalletsControl.getInstance().changeNetType(EnumKit.NetTypeEx.from(netTypeList[index].enumNetType));
                      if (!isChangeNetOk) {
                        return;
                      }
                      HandleConfig.instance.saveConfig(config);
                      setState(() {
                        this.netTypeList = netTypeList;
                      });
                      if (WalletsControl.getInstance().hasAny()) {
                        NavigatorUtils.push(context, '${Routes.ethHomePage}?isForceLoadFromJni=false', clearStack: true);
                      } else {
                        NavigatorUtils.push(context, '${Routes.createTestWalletPage}', clearStack: true);
                      }
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
                !netTypeList[index].isCurNet
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
}
