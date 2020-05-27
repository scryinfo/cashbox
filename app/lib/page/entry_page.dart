import 'package:app/demo/dapp_webview_demo.dart';
import 'package:app/demo/tx_demo.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/global_config/global_config.dart';
import 'package:app/page/eee_page/eee_page.dart';
import 'package:app/page/transaction_history_page/transaction_history_page.dart';
import 'package:app/provide/wallet_manager_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/widgets/restart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eth_page/eth_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
  String languageTextValue = "";
  List<String> languageList = [];
  Map<String, String> languageMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    future = _checkIsContainWallet();
    initWalletBasicData(); //case : 删除钱包后，没钱包，回到entryPage，每次检查一下
  }

  void initWalletBasicData() async {
    languageList = [];
    languageList = GlobalConfig.globalLanguageList;
    languageMap = {};
    languageMap.addAll(GlobalConfig.globalLanguageMap);
    /*  初始化 到 本地文件
        1、接口ip、版本信息等 到本地文件保存
        2、数据库信息等
        3、应用语言类型（中、英文）
        */
    await Wallets.instance.initWalletBasicData();
  }

  Future<bool> _checkIsContainWallet() async {
    var spUtil = await SharedPreferenceUtil.instance;
    print("initData  _checkIsContainWallet GlobalConfig.savedLocaleKey===>" + spUtil.getString(GlobalConfig.savedLocaleKey));
    languageTextValue = languageMap[spUtil.getString(GlobalConfig.savedLocaleKey)];
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
                  translate('wallet_load_error'),
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            if (snapshot.hasData) {
              bool isContainWallet = snapshot.data;
              if (isContainWallet) {
                //return DappPage(); // todo 版本说明，直接进入到Dapp diamond页面处
                //return TransactionDemo();
                return EthPage();
                //return DAppWebViewDemo();
                //return EeePage();    //版本说明：提供eee界面，可以看账户信息address，和切换钱包
              } else {
                return _buildProtocolLayout(context);
              }
            }
            return Container(
              child: Text(""),
            );
          }),
    );
  }

  Widget _buildProtocolLayout(context) {
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
              Gaps.scaleVGap(10),
              _buildChangeLanguageWidget(context),
              Gaps.scaleVGap(20),
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

  Widget _buildChangeLanguageWidget(context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.instance.setWidth(50)),
      width: ScreenUtil.instance.setWidth(25),
      color: Color.fromRGBO(0, 0, 0, 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            languageTextValue ?? "",
            style: TextStyle(color: Colors.lightBlue),
          ),
          PopupMenuButton<String>(
            color: Colors.black12,
            icon: Icon(Icons.keyboard_arrow_down),
            itemBuilder: (BuildContext context) => _makePopMenuList(),
            onSelected: (String value) async {
              setState(() {
                this.languageTextValue = languageMap[value];
              });
              print("changeLocale===>" + value);
              changeLocale(context, value);
              var spUtil = await SharedPreferenceUtil.instance;
              spUtil.setString(GlobalConfig.savedLocaleKey, value);
            },
          )
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> _makePopMenuList() {
    List<PopupMenuItem<String>> popMenuList = List.generate(languageList.length, (index) {
      return PopupMenuItem<String>(
          value: languageList[index] ?? "",
          child: new Text(
            languageMap[languageList[index]] ?? "",
            style: new TextStyle(color: Colors.white54),
          ));
    });
    return popMenuList;
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
            Fluttertoast.showToast(msg: translate('make_sure_service_protocol'));
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
              translate('add_wallet'),
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
            Fluttertoast.showToast(msg: translate('make_sure_service_protocol'));
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
              translate('import_wallet'),
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
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: translate('agree_service_prefix'),
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil.instance.setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('service_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil.instance.setSp(3),
                          fontStyle: FontStyle.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(context, Routes.serviceAgreementPage);
                        }),
                  TextSpan(
                    text: "、",
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil.instance.setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('privacy_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white70,
                          fontSize: ScreenUtil.instance.setSp(3),
                          fontStyle: FontStyle.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(context, Routes.privacyStatementPage);
                        }),
                ]),
              )),
        ],
      ),
    );
  }
}
