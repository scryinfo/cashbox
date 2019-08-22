import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';

class CreateWalletNamePage extends StatefulWidget {
  @override
  _CreateWalletNamePageState createState() => _CreateWalletNamePageState();
}

class _CreateWalletNamePageState extends State<CreateWalletNamePage> {
  bool _eeeChainChoose = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pwdController.addListener(_listenWalletName); //监听密码 输入框
    _confirmPwdController.addListener(_listenPwd); //监听确认密码 输入框
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
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
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(10),
            _buildWalletNameLayout(),
            Gaps.scaleVGap(8),
            _buildWalletPwdLayout(),
            Gaps.scaleVGap(8),
            _buildConfirmPwdLayout(),
            Gaps.scaleVGap(8),
            _buildChainChooseLayout(),
            Gaps.scaleVGap(8),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  if (_verifyToCreateWallet()) {
                    NavigatorUtils.push(
                        context, Routes.createWalletMnemonicPage);
                  }
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
    );
  }

  Widget _buildWalletNameLayout() {
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
          Gaps.scaleVGap(2),
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
              controller: _nameController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletPwdLayout() {
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
          Gaps.scaleVGap(2),
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
              controller: _pwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPwdLayout() {
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
          Gaps.scaleVGap(2),
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
              controller: _confirmPwdController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChainChooseLayout() {
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
                  value: _eeeChainChoose,
                  onChanged: (newValue) {
                    setState(
                      () {
                        _eeeChainChoose = newValue;
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

  void _listenWalletName() {
    String name = _nameController.text;
    if (name.isEmpty || name.length < 1) {
      Fluttertoast.showToast(msg: "钱包名不能为空");
      return;
    }
  }

  void _listenPwd() {
    String pwd = _pwdController.text;
    if (pwd.isEmpty || pwd.length < 1) {
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }
  }

  bool _verifyToCreateWallet() {
    //验证：数据不为空
    if (_nameController.text.isEmpty ||
        _nameController.text.length < 1 ||
        _pwdController.text.isEmpty ||
        _pwdController.text.length < 1 ||
        _confirmPwdController.text.isEmpty ||
        _confirmPwdController.text.length < 1) {
      Fluttertoast.showToast(msg: "有信息为空，请补全信息");
      return false;
    }
    //验证：两次密码一致
    if (_confirmPwdController.text.compareTo(_pwdController.text) != 0) {
      Fluttertoast.showToast(msg: "确认密码不一致，请重新输入");
      return false;
    }
    //验证：勾选 链
    if (!_eeeChainChoose) {
      Fluttertoast.showToast(msg: "请确认勾选创建EEE链");
      return false;
    }
    return true;
  }
}
