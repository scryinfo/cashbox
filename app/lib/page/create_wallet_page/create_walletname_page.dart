import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routers/application.dart';

class CreateWalletNamePage extends StatefulWidget {
  @override
  _CreateWalletNamePageState createState() => _CreateWalletNamePageState();
}

class _CreateWalletNamePageState extends State<CreateWalletNamePage> {
  bool _EeeChainChoosed = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pwdController.addListener(_verifyWalletName);
    _confirmPwdController.addListener(_verifyPwd);
  }

  void _verifyWalletName() {
    String name = _nameController.text;
    if (name.isEmpty || name.length < 1) {
      Fluttertoast.showToast(msg: "钱包名不能为空");
      return;
    }
  }

  void _verifyPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_loading.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "创建钱包",
          backgroundColor: Colors.transparent,
        ),
        body: _buildCreateWalletWidget(),
      ),
    );
  }

  Widget _buildCreateWalletWidget() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: Container(
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(5),
          right: ScreenUtil().setWidth(5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              _buildWalletNameLayout(this),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              _buildWalletPwdLayout(this),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              _buildConfirmPwdLayout(this),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              _buildChainChooseLayout(this),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: ScreenUtil().setWidth(41),
                height: ScreenUtil().setHeight(9),
                color: Color.fromRGBO(26, 141, 198, 0.20),
                child: FlatButton(
                  onPressed: () {
                    print("clicked the add wallet btn");
                    Application.router.navigateTo(context,"createwalletmnemonicpage");
                  },
                  child: Text(
                    "添加钱包",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildWalletNameLayout(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "钱包名称",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(2),
          ),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                //labelText: "请输入钱包名",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请输入钱包名",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: context._nameController,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildWalletPwdLayout(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "密码",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(2),
          ),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "建议大于8位，英文、数字混合",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: context._pwdController,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildConfirmPwdLayout(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "再次输入密码",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(2),
          ),
          Container(
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(2),
                    top: ScreenUtil().setHeight(8)),
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                hintText: "请确认两次输入密码一致",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: context._confirmPwdController,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildChainChooseLayout(context) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "选择创建链",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: 13,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: context._EeeChainChoosed,
                          onChanged: (newValue) {
                            context.setState(
                                  () {
                                print(" context._EeeChainChoosed=>" +
                                    context._EeeChainChoosed.toString());
                                context._EeeChainChoosed = newValue;
                              },
                            );
                          },
                        ),
                        Text(
                          "EEE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
