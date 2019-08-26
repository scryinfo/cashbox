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
          child: _buildWalletManagerWidget(),
        ),
      ),
    );
  }

  Widget _buildWalletManagerWidget() {
    return Container(
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
            _buildWalletNameWidget(),
            _buildResetPwdWidget(),
            _buildRecoverWalletWidget(),
            _buildDeleteWalletWidget(),
          ],
        ));
  }

  Widget _buildDeleteWalletWidget() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PwdDialog(
              title: "删除钱包",
              hintContent: "提示：请保存好您的助记词。钱包删除后，cashbox不会再私自记录该钱包的任何信息。",
              hintInput: "请输入钱包密码",
              onPressed: () {
                //todo
                print("to do verify pwd,delete wallet");
              },
            );
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
    );
  }

  Widget _buildWalletNameWidget() {
    return Container(
      child: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }

  Widget _buildResetPwdWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, Routes.resetPwdPage);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              Container(
                child: ItemOfListWidget(
                  leftText: "重置密码",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecoverWalletWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PwdDialog(
                  title: "恢复钱包",
                  hintContent: "提示：请输入您的密码。     切记，应用不会保存你的助记词等隐私信息，请您自己务必保存好。",
                  hintInput: "请输入钱包密码",
                  onPressed: () {
                    //todo
                    print("to do verify pwd，recover wallet");
                  });
            },
          );
          //NavigatorUtils.push(context, Routes.recoverWalletPage);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Gaps.scaleVGap(5),
              Container(
                child: ItemOfListWidget(
                  leftText: "恢复钱包",
                ),
              ),
            ],
          ),
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
