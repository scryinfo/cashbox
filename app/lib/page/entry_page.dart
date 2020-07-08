import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/net/net_util.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:app/page/eth_page/eth_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  var allWalletList = List();
  bool _agreeServiceProtocol = true;
  bool _isContainWallet = false;
  Future future;
  String _languageTextValue = "";
  List<String> languagesKeyList = [];
  Map<String, String> languageMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initAppConfigInfo(); //case: After deleting the wallet, there is no wallet, return to entryPage, check every time
    var spUtil = await SharedPreferenceUtil.instance;
    _languageTextValue = languageMap[spUtil.getString(GlobalConfig.savedLocaleKey)];
    future = _checkIsContainWallet();
    //_checkUpdateAppConfig();
  }

  initAppConfigInfo() async {
    languagesKeyList = [];
    languagesKeyList = GlobalConfig.globalLanguageMap.keys.toList();
    languageMap = {};
    languageMap.addAll(GlobalConfig.globalLanguageMap);
    /*  Initialize to local file
        1. Interface ip, version information, etc. Save to local file
        2. Database information, etc.
        3. Application language type (Chinese and English)
        */
    await Wallets.instance.initAppConfig();
  }

  _checkUpdateAppConfig() async {
    try {
      var result = await requestWithDeviceId(VendorConfig.appServerConfigKey);
      print("_checkServerAppConfig result.code=>" + result.toString());
      // todo 举例：检查默认代币列表，更新默认代币列表，后续创建钱包是后，会默认创建
      // 保存各个配置接口的最新地址，到本地。
    } catch (e) {
      print("_checkServerAppConfig error is ===>" + e.toString());
    }
  }

  //Check if a wallet has been created
  Future<bool> _checkIsContainWallet() async {
    _isContainWallet = await Wallets.instance.isContainWallet();
    return _isContainWallet;
  }

  @override
  Widget build(BuildContext context) {
    ///Initialize the screen aspect ratio, based on the cashbox cut-out, marked with XXXHDPI@4x
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
                return EthPage();
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
            this._languageTextValue ?? "",
            style: TextStyle(color: Colors.lightBlue),
          ),
          PopupMenuButton<String>(
            color: Colors.black12,
            icon: Icon(Icons.keyboard_arrow_down),
            itemBuilder: (BuildContext context) => _makePopMenuList(),
            onSelected: (String value) async {
              setState(() {
                this._languageTextValue = languageMap[value];
              });
              print("changeLocale===>" + value);
              {
                changeLocale(context, value);
                var spUtil = await SharedPreferenceUtil.instance;
                spUtil.setString(GlobalConfig.savedLocaleKey, value);
              }
            },
          )
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> _makePopMenuList() {
    List<PopupMenuItem<String>> popMenuList = List.generate(languagesKeyList.length, (index) {
      return PopupMenuItem<String>(
          value: languagesKeyList[index] ?? "",
          child: new Text(
            languageMap[languagesKeyList[index]] ?? "",
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
