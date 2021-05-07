import 'dart:convert';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/control/eee_chain_control.dart';
import 'package:app/control/eth_chain_control.dart';
import 'package:app/control/wallets_control.dart';
import 'package:app/model/server_config_model.dart';
import 'package:app/pages/eee_page.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/app_info_util.dart';
import 'package:logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:app/model/wallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:services/services.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/wallets_c.dc.dart';
import 'eth_page.dart';
import 'package:services/src/rpc_face/base.pb.dart';
import 'package:services/src/rpc_face/cashbox_config_open.pbgrpc.dart';
import 'package:services/src/rpc_face/token_open.pbgrpc.dart';

class EntrancePage extends StatefulWidget {
  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  bool _agreeServiceProtocol = true;
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
    /*  Initialize to local file
        1. Interface ip, version information, etc. Save to local file
        2. Database information, etc.
        3. Default digits
        4. Application language type (Chinese and English)
        */
    await _initAppConfigInfo(); //case: After deleting the wallet, there is no wallet, return to EntrancePage, check every time
    Config config = await HandleConfig.instance.getConfig();
    _languageTextValue = languageMap[config.locale];
    _checkAndUpdateAppConfig();
  }

  _initAppConfigInfo() async {
    languagesKeyList = [];
    languageMap = {};
    Config config = await HandleConfig.instance.getConfig();
    config.languages.forEach((element) {
      languageMap[element.localeKey] = element.localeValue;
      languagesKeyList.add(element.localeKey);
    });
  }

  _checkAndUpdateAppConfig() async {
    Config config = await HandleConfig.instance.getConfig();

    // Interval check config
    var lastCheckTimeDuration = DateTime.now().millisecondsSinceEpoch - config.lastTimeConfigCheck;
    if (config.lastTimeConfigCheck != null && (lastCheckTimeDuration - config.intervalMilliseconds * 1000 < 0)) {
      Logger().i("_checkAndUpdateAppConfig(), nowTimeStamp=>", lastCheckTimeDuration.toString());
      return;
    }

    LatestConfig serverConfigModel;
    final cashBoxType = "GA";
    String signInfo = await AppInfoUtil.instance.getAppSignInfo();
    String deviceId = await AppInfoUtil.instance.getDeviceId();
    String apkVersion = await AppInfoUtil.instance.getAppVersion();
    // String abiPlatform = await AppInfoUtil.instance.getSupportAbi();

    var refresh = RefreshOpen.get(new ConnectParameter("192.168.2.12", 9004), apkVersion, AppPlatformType.any, signInfo, deviceId, cashBoxType);
    BasicClientReq basicClientReq = new BasicClientReq();
    basicClientReq
      ..cashboxType = cashBoxType
      ..cashboxVersion = apkVersion
      ..deviceId = deviceId
      ..platformType = AppPlatformType.any.toEnumString()
      ..signature = signInfo;
    var channel = createClientChannel(refresh.refreshCall);
    final configOpenFaceClient = CashboxConfigOpenFaceClient(channel);
    try {
      CashboxConfigOpen_LatestConfigRes latestConfigRes = await configOpenFaceClient.latestConfig(basicClientReq);
      serverConfigModel = LatestConfig.fromJson(json.decode(latestConfigRes.conf));
    } catch (e) {
      Logger.getInstance().e("configOpenFaceClient.latestConfig() ", e.toString());
      var isUpdateOk = await EeeChainControl.getInstance().updateSubChainBasicInfo("");
      Logger.getInstance().i("updateSubChainBasicInfo", isUpdateOk.toString());
      return;
    }

    _updateEeeInfo(serverConfigModel); // check and update  EeeChain txVersion and runtimeVersion
    _updateLocalConfigInfo(config, serverConfigModel); // handle case : Config upgrade.
    _updateEthDefaultToken(refresh, basicClientReq, serverConfigModel, config);
    _updateEeeDefaultToken(refresh, basicClientReq, serverConfigModel, config);
  }

  _updateLocalConfigInfo(Config config, LatestConfig serverConfigModel) async {
    try {
      config.lastTimeConfigCheck = DateTime.now().millisecondsSinceEpoch;
      // config.privateConfig.authDigitVersion = serverConfigModel.authTokenListVersion; // needless save the value
      config.privateConfig.serverApkVersion = serverConfigModel.apkVersion;
      config.privateConfig.rateUrl = serverConfigModel.tokenToLegalTenderExchangeRateIp;
      config.privateConfig.scryXIp = serverConfigModel.scryXChainUrl;
      config.privateConfig.downloadLatestAppUrl = serverConfigModel.apkDownloadLink;
      config.privateConfig.publicIp = serverConfigModel.announcementUrl;
      config.privateConfig.dappOpenUrl = serverConfigModel.dappOpenUrl;
      if (serverConfigModel.authTokenUrl != null && serverConfigModel.authTokenUrl.length > 0) {
        config.privateConfig.authDigitIpList = [];
        serverConfigModel.authTokenUrl.forEach((element) {
          config.privateConfig.authDigitIpList.add(element);
        });
      }
      config.privateConfig.defaultDigitIpList = [];
      serverConfigModel.defaultTokenUrl.forEach((element) {
        config.privateConfig.defaultDigitIpList.add(element);
      });
      // save changed config
      bool isSaveOk = await HandleConfig.instance.saveConfig(config);
      if (!isSaveOk) {
        Logger().e("saveConfig  is failure---> ", isSaveOk.toString());
      }
    } catch (e) {
      Logger().e("updateConfig error is -----> ", e.toString());
    }
  }

  _updateEeeInfo(LatestConfig serverConfigModel) async {
    try {
      SubChainBasicInfo defaultBasicInfo = EeeChainControl.getInstance().getDefaultBasicInfo();
      if (serverConfigModel == null ||
          defaultBasicInfo == null ||
          defaultBasicInfo.runtimeVersion == null ||
          defaultBasicInfo.txVersion == null ||
          serverConfigModel.eeeRuntimeV == null ||
          serverConfigModel.eeeTxV == null ||
          defaultBasicInfo.runtimeVersion.toString() != serverConfigModel.eeeRuntimeV.toString() ||
          defaultBasicInfo.txVersion.toString() != serverConfigModel.eeeTxV.toString()) {
        await EeeChainControl.getInstance().updateSubChainBasicInfo("");
      }
    } catch (e) {
      Logger().e("updateSubChainBasicInfo error is ---> ", e.toString());
    }
  }

  _updateEthDefaultToken(RefreshOpen refresh, BasicClientReq basicClientReq, LatestConfig serverConfigModel, Config config) async {
    if (serverConfigModel == null || serverConfigModel.defaultTokenUrl == null || serverConfigModel.defaultTokenUrl.length == 0) {
      return;
    }
    if (config.privateConfig.defaultDigitVersion == serverConfigModel.defaultTokenListVersion) {
      return;
    }
    try {
      var channel = createClientChannel(refresh.refreshCall);
      EthTokenOpen_QueryReq openEthQueryReq = new EthTokenOpen_QueryReq();
      PageReq pageReq = PageReq();
      pageReq..page = 0; // 0 mean to load all data. Not divided by several pages
      openEthQueryReq
        ..info = basicClientReq
        ..page = pageReq
        ..isDefault = true;
      final ethTokenClient = EthTokenOpenFaceClient(channel);
      EthTokenOpen_QueryRes ethTokenOpenQueryRes = await ethTokenClient.query(openEthQueryReq);
      if (ethTokenOpenQueryRes == null) {
        return;
      }
      ArrayCEthChainTokenDefault defaultTokens = ArrayCEthChainTokenDefault();
      List<EthChainTokenDefault> ethDefaultTokenList = [];
      for (var i = 0; i < ethTokenOpenQueryRes.tokens.length; i++) {
        var element = ethTokenOpenQueryRes.tokens[i];
        EthChainTokenDefault ethChainTokenDefault = EthChainTokenDefault();
        ethChainTokenDefault
          ..ethChainTokenShared.gasLimit = element.gasLimit.toInt()
          ..ethChainTokenShared.gasPrice = element.gasPrice.toString()
          ..netType = element.tokenShared.netType
          ..ethChainTokenShared.tokenType = element.tokenShared.chainType
          ..ethChainTokenShared.tokenShared.name = element.tokenShared.name
          ..ethChainTokenShared.tokenShared.symbol = element.tokenShared.symbol
          ..ethChainTokenShared.tokenShared.logoUrl = element.tokenShared.logoUrl
          ..ethChainTokenShared.tokenShared.logoBytes = element.tokenShared.logoBytes
          ..contractAddress = element.contract ?? ""
          ..ethChainTokenShared.decimal = element.decimal ?? 0
          ..position = element.position.toInt();
        ethDefaultTokenList.add(ethChainTokenDefault);
      }
      if (ethDefaultTokenList == null || ethDefaultTokenList.length == 0) {
        Logger.getInstance().e("updateDefaultTokenList", "ethDefaultTokenList is null --->");
        return;
      }
      defaultTokens.data = ethDefaultTokenList;
      bool isUpdateOk = EthChainControl.getInstance().updateDefaultTokenList(defaultTokens);
      if (!isUpdateOk) {
        Logger.getInstance().e("updateDefaultTokenList", "update not ok,and is --->" + isUpdateOk.toString());
        return;
      }
      // add to wallet
      // if (WalletsControl.getInstance().hasAny()) {
      //   for (var i = 0; i < ethDefaultTokenList.length; i++) {
      //     var element = ethDefaultTokenList[i];
      //     TokenAddress tokenAddress = TokenAddress()
      //       ..tokenId = element.chainTokenSharedId
      //       ..chainType = WalletsControl.getInstance().currentChainType().toEnumString()
      //       ..walletId = WalletsControl.getInstance().currentWallet().id
      //       ..balance = 0.toString()
      //       ..addressId = WalletsControl.getInstance().getTokenAddressId(WalletsControl.getInstance().currentWallet().id, ChainType.ETH) ?? "";
      //     bool isUpdateBalanceOk = WalletsControl.getInstance().updateBalance(tokenAddress);
      //     if (!isUpdateBalanceOk) {
      //       Logger().e("updateBalance error , tokenAddress info is---> ", tokenAddress.toString());
      //     }
      //   }
      // }

      config.privateConfig.defaultDigitVersion = serverConfigModel.defaultTokenListVersion;
      bool isSaveOk = await HandleConfig.instance.saveConfig(config);
      if (!isSaveOk) {
        Logger().e("saveConfig  is failure---> ", isSaveOk.toString());
      }
    } catch (e) {
      Logger.getInstance().e("updateDefaultDigitList error =====>", e.toString());
      return;
    }
  }

  _updateEeeDefaultToken(RefreshOpen refresh, BasicClientReq basicClientReq, LatestConfig serverConfigModel, Config config) async {
    if (serverConfigModel == null || serverConfigModel.defaultTokenUrl == null || serverConfigModel.defaultTokenUrl.length == 0) {
      return;
    }
    if (config.privateConfig.defaultDigitVersion == serverConfigModel.defaultTokenListVersion) {
      return;
    }
    try {
      var channel = createClientChannel(refresh.refreshCall);
      EeeTokenOpen_QueryReq openEeeQueryReq = new EeeTokenOpen_QueryReq();
      PageReq pageReq = PageReq();
      pageReq..page = 0; // 0 mean to load all data. Not divided by several pages
      openEeeQueryReq
        ..info = basicClientReq
        ..page = pageReq
        ..isDefault = true;
      final eeeTokenClient = EeeTokenOpenFaceClient(channel);
      EeeTokenOpen_QueryRes eeeTokenOpenQueryRes = await eeeTokenClient.query(openEeeQueryReq);
      if (eeeTokenOpenQueryRes == null) {
        return;
      }
      ArrayCEeeChainTokenDefault defaultTokens = ArrayCEeeChainTokenDefault();
      List<EeeChainTokenDefault> eeeDefaultTokenList = [];
      for (var i = 0; i < eeeTokenOpenQueryRes.tokens.length; i++) {
        var element = eeeTokenOpenQueryRes.tokens[i];
        EeeChainTokenDefault eeeChainTokenDefault = EeeChainTokenDefault();
        eeeChainTokenDefault
          ..eeeChainTokenShared.gasLimit = element.gasLimit.toInt()
          ..netType = element.tokenShared.netType
          ..eeeChainTokenShared.tokenType = element.tokenShared.chainType
          ..eeeChainTokenShared.tokenShared.name = element.tokenShared.name
          ..eeeChainTokenShared.tokenShared.symbol = element.tokenShared.symbol
          ..eeeChainTokenShared.tokenShared.logoUrl = element.tokenShared.logoUrl
          ..eeeChainTokenShared.tokenShared.logoBytes = element.tokenShared.logoBytes
          ..eeeChainTokenShared.decimal = element.decimal ?? 0
          ..position = element.position.toInt();
        eeeDefaultTokenList.add(eeeChainTokenDefault);
      }
      if (eeeDefaultTokenList == null || eeeDefaultTokenList.length == 0) {
        Logger.getInstance().e("updateDefaultTokenList", "ethDefaultTokenList is null --->");
        return;
      }
      defaultTokens.data = eeeDefaultTokenList;
      bool isUpdateOk = EeeChainControl.getInstance().updateDefaultTokenList(defaultTokens);
      if (!isUpdateOk) {
        Logger.getInstance().e("updateDefaultTokenList", "update not ok,and is --->" + isUpdateOk.toString());
        return;
      }
      // add to wallet
      // if (WalletsControl.getInstance().hasAny()) {
      //   for (var i = 0; i < eeeDefaultTokenList.length; i++) {
      //     var element = eeeDefaultTokenList[i];
      //     TokenAddress tokenAddress = TokenAddress()
      //       ..tokenId = element.chainTokenSharedId
      //       ..chainType = WalletsControl.getInstance().currentChainType().toEnumString()
      //       ..walletId = WalletsControl.getInstance().currentWallet().id
      //       ..balance = 0.toString()
      //       ..addressId = WalletsControl.getInstance().getTokenAddressId(WalletsControl.getInstance().currentWallet().id, ChainType.ETH) ?? "";
      //     bool isUpdateBalanceOk = WalletsControl.getInstance().updateBalance(tokenAddress);
      //     if (!isUpdateBalanceOk) {
      //       Logger().e("updateBalance error , tokenAddress info is---> ", tokenAddress.toString());
      //     }
      //   }
      // }

      // when update token ok,change tokenVersion config info
      config.privateConfig.defaultDigitVersion = serverConfigModel.defaultTokenListVersion;
      bool isSaveOk = await HandleConfig.instance.saveConfig(config);
      if (!isSaveOk) {
        Logger().e("saveConfig  is failure---> ", isSaveOk.toString());
      }
    } catch (e) {
      Logger.getInstance().e("updateDefaultDigitList error =====>", e.toString());
      return;
    }
  }

  //Check if a wallet has been created
  Future<bool> _checkIsContainWallet() async {
    await WalletsControl.getInstance().initWallet();
    return WalletsControl.getInstance().hasAny();
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
              Logger().e("EntrancePage future snapshot.hasError is --->", snapshot.error.toString());
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
                ChainType curChainType = WalletsControl.getInstance().currentChainType();
                switch (curChainType) {
                  case ChainType.ETH:
                  case ChainType.EthTest:
                    return EthPage();
                    break;
                  case ChainType.EEE:
                  case ChainType.EeeTest:
                    return EeePage();
                    break;
                  default:
                    return EthPage();
                    break;
                }
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
