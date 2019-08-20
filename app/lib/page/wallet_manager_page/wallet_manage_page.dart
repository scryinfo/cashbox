import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';
import '../../widgets/list_item.dart';
import '../../widgets/pwd_dialog.dart';

class WalletManagerPage extends StatefulWidget {
  @override
  _WalletManagerPageState createState() => _WalletManagerPageState();
}

class _WalletManagerPageState extends State<WalletManagerPage> {
  List funcList = ["重置密码", "备份钱包"]; //todo 2.0 "编辑链",
  List funcRouter = [Routes.resetPwdPage, Routes.recoverWalletPage];
  static const String DELETE_WALLET = "删除钱包";
  TextEditingController _walletNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _walletNameController.text = "666"; //todo init walletName
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: ""
              "钱包管理",
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            //todo 更改钱包名
          },
          child: Container(
              width: ScreenUtil().setWidth(90),
              height: ScreenUtil().setHeight(160),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/bg_graduate.png"),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Gaps.scaleVGap(5),
                  Container(
                    alignment: Alignment.topLeft,
                    width: ScreenUtil().setWidth(80),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(3)),
                    child: Text(
                      "钱包名",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Gaps.scaleVGap(2),
                  Container(
                    width: ScreenUtil().setWidth(75),
                    alignment: Alignment.center,
                    child: TextField(
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(2),
                            top: ScreenUtil().setHeight(8)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(1.0),
                          ),
                        ),
                      ),
                      controller: _walletNameController,
                    ),
                  ),
                  Wrap(
                    children: _buildWalletFuncList(),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PwdDialog(
                              "删除钱包",
                              "提示：请保存好您的助记词。钱包删除后，cashbox不会再私自记录该钱包的任何信息",
                              "请输入钱包密码");
                        },
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Gaps.scaleVGap(5),
                        Container(
                          child: ItemOfListWidget(
                            leftText: DELETE_WALLET,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  List<Widget> _buildWalletFuncList() {
    List<Widget> walletFuncList = List.generate(funcList.length, (index) {
      return Container(
        child: GestureDetector(
          onTap: () {
            NavigatorUtils.push(context, funcRouter[index]);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Gaps.scaleVGap(5),
                Container(
                  child: ItemOfListWidget(
                    leftText: funcList[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return walletFuncList;
  }
}
