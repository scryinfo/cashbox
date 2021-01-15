import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/net/net_util.dart';
import 'package:app/model/server_config_model.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;
import 'home.dart';
import 'package:app/net/scryx_net_util.dart';

class EntrancePage extends StatefulWidget {
  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  var allWalletList = List();
  bool _agreeServiceProtocol = true;
  bool _isContainWallet = false;
  String _languageTextValue = "";
  List<String> languagesKeyList = [];
  Map<String, String> languageMap = {};
  int checkConfigInterval = 1000 * 5; //every 5 seconds allow to check config Ip

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initAppConfigInfo(); //case: After deleting the wallet, there is no wallet, return to EntrancePage, check every time
    Config config = await HandleConfig.instance.getConfig();
    _languageTextValue = languageMap[config.locale];
    _checkAndUpdateAppConfig();
  }

  initAppConfigInfo() async {
    languagesKeyList = [];
    languageMap = {};
    Config config = await HandleConfig.instance.getConfig();
    config.languages.forEach((element) {
      languageMap[element.localeKey] = element.localeValue;
      languagesKeyList.add(element.localeKey);
    });
    /*  Initialize to local file
        1. Interface ip, version information, etc. Save to local file
        2. Database information, etc.
        3. Default digits
        4. Application language type (Chinese and English)
        */
    await Wallets.instance.initAppConfig();
  }

  _checkAndUpdateAppConfig() async {
    // handle case : DB upgrade.   DB initial installation already finish in func -> initAppConfigInfo()->initDatabaseAndDefaultDigits()
    Config config = await HandleConfig.instance.getConfig();

    Map resultMap = await Wallets.instance.updateWalletDbData(config.dbVersion);
    if (resultMap != null && (resultMap["isUpdateDbData"] == true)) {
      LogUtil.instance.i("_checkAndUpdateAppConfig is ok =====>", config.dbVersion.toString());
    }
    int lastTimeConfigCheck = config.lastTimeConfigCheck;
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    // handle case : Config upgrade.
    try {
      if (lastTimeConfigCheck == null || ((nowTimeStamp - lastTimeConfigCheck) - config.intervalMilliseconds * 1000 > 0)) {
        var configVersionObj = await requestWithConfigVersion(config.privateConfig.serverConfigIp);
        ServerConfigModel serverConfigModel = ServerConfigModel.fromJson(configVersionObj);
        print("serverConfigModel--->" + serverConfigModel.toString());
        if (serverConfigModel.code != 0) {
          LogUtil.instance.i("_checkServerAppConfig(), serverConfigModel.code error is =======>", serverConfigModel.code.toString());
          return;
        }

        ///check and update  EeeChain txVersion and runtimeVersion
        try {
          ScryXNetUtil scryXNetUtil = new ScryXNetUtil();
          Map getSubChainMap = await Wallets.instance.getSubChainBasicInfo("", 0, 0); // get local default Eee chain info
          if (getSubChainMap == null || !getSubChainMap.containsKey("status") || getSubChainMap["status"] != 200) {
            Map map = await scryXNetUtil.updateSubChainBasicInfo(""); // needless save txVersion info to config
            LogUtil.instance.i("updateSubChainBasicInfo  ", "empty case!");
          } else if (serverConfigModel.data.latestConfig.eeeRuntimeV == null ||
              getSubChainMap["runtimeVersion"] == null ||
              serverConfigModel.data.latestConfig.eeeTxV == null ||
              getSubChainMap["txVersion"] == null ||
              serverConfigModel.data.latestConfig.eeeRuntimeV.toString() != getSubChainMap["runtimeVersion"].toString() ||
              serverConfigModel.data.latestConfig.eeeTxV != getSubChainMap["txVersion"].toString()) {
            Map map = await scryXNetUtil.updateSubChainBasicInfo(""); // needless save txVersion info to config
            LogUtil.instance.i("updateSubChainBasicInfo  ", " finish do updateSubChainBasicInfo");
          }
        } catch (e) {
          LogUtil.instance.e("updateSubChainBasicInfo error is ---> ", e.toString());
        }
        {
          config.lastTimeConfigCheck = nowTimeStamp;
          config.serverAppVersion = serverConfigModel.data.latestConfig.appConfigVersion;
          config.privateConfig.authDigitVersion = serverConfigModel.data.latestConfig.authTokenListVersion;
          config.privateConfig.defaultDigitVersion = serverConfigModel.data.latestConfig.defaultTokenListVersion;
          config.privateConfig.serverApkVersion = serverConfigModel.data.latestConfig.apkVersion;
          config.privateConfig.rateUrl = serverConfigModel.data.latestConfig.tokenToLegalTenderExchangeRateIp;
          config.privateConfig.scryXIp = serverConfigModel.data.latestConfig.scryXChainUrl;
          config.privateConfig.downloadLatestAppUrl = serverConfigModel.data.latestConfig.apkDownloadLink;
          config.privateConfig.publicIp = serverConfigModel.data.latestConfig.announcementUrl;
          config.privateConfig.dappOpenUrl = serverConfigModel.data.latestConfig.dappOpenUrl;
          if (serverConfigModel.data.latestConfig.authTokenUrl != null && serverConfigModel.data.latestConfig.authTokenUrl.length > 0) {
            config.privateConfig.authDigitIpList = [];
            serverConfigModel.data.latestConfig.authTokenUrl.forEach((element) {
              config.privateConfig.authDigitIpList.add(element);
            });
          }
          if (serverConfigModel.data.latestConfig.defaultTokenUrl != null && serverConfigModel.data.latestConfig.defaultTokenUrl.length > 0) {
            config.privateConfig.defaultDigitIpList = [];
            serverConfigModel.data.latestConfig.defaultTokenUrl.forEach((element) {
              config.privateConfig.defaultDigitIpList.add(element);
            });
            //update defaultDigitList to native
            try {
              var defaultDigitParam = await requestWithDeviceId(config.privateConfig.defaultDigitIpList[0].toString());
              if (defaultDigitParam["code"] != null && defaultDigitParam["code"] == 0) {
                String paramString = convert.jsonEncode(defaultDigitParam["data"]);
                var updateMap = await Wallets.instance.updateDefaultDigitList(paramString);
                LogUtil.instance.i("updateDefaultDigitList=====>", updateMap["status"].toString() + updateMap["isUpdateDefaultDigit"].toString());
              }
            } catch (e) {
              LogUtil.instance.e("updateDefaultDigitList error =====>", e.toString());
            }
          }
          config.privateConfig.configVersion = serverConfigModel.data.latestConfig.appConfigVersion;
        }
        // save changed config
        HandleConfig.instance.saveConfig(config);
      } else {
        LogUtil.instance.i("_checkAndUpdateAppConfig() time is not ok, nowTimeStamp=>", (nowTimeStamp - lastTimeConfigCheck).toString());
      }
    } catch (e) {
      LogUtil.instance.e("_checkServerAppConfig(), error is =======>", e.toString());
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
    ScreenUtil.init(context, designSize: Size(90, 160), allowFontScaling: false);

    return Container(
      child: FutureBuilder(
          future: _checkIsContainWallet(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              LogUtil.instance.e("EntrancePage future snapshot.hasError is +>", snapshot.error.toString());
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
                return HomePage();
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
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
      width: ScreenUtil().setWidth(25),
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
              {
                changeLocale(context, value);
                Config config = await HandleConfig.instance.getConfig();
                config.locale = value;
                HandleConfig.instance.saveConfig(config);
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
              style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
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
              style: TextStyle(decoration: TextDecoration.none, color: Colors.blue, fontSize: ScreenUtil().setSp(4), fontStyle: FontStyle.normal),
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
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('service_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigatorUtils.push(context, Routes.serviceAgreementPage);
                        }),
                  TextSpan(
                    text: "、",
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
                  ),
                  TextSpan(
                      text: translate('privacy_protocol_tag'),
                      style: TextStyle(
                          decoration: TextDecoration.underline, color: Colors.white70, fontSize: ScreenUtil().setSp(3), fontStyle: FontStyle.normal),
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
