// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config()
  ..lastTimeConfigCheck = json['lastTimeConfigCheck'] as int
  ..intervalMilliseconds = json['intervalMilliseconds'] as int
  ..currency = json['currency'] as String
  ..locale = json['locale'] as String
  ..languages = (json['languages'] as List<dynamic>).map((e) => Language.fromJson(e as Map<String, dynamic>)).toList()
  ..diamondCa = json['diamondCa'] as String
  ..maxGasLimit = MaxGasLimit.fromJson(json['maxGasLimit'] as Map<String, dynamic>)
  ..minGasLimit = MinGasLimit.fromJson(json['minGasLimit'] as Map<String, dynamic>)
  ..defaultGasLimit = DefaultGasLimit.fromJson(json['defaultGasLimit'] as Map<String, dynamic>)
  ..maxGasPrice = MaxGasPrice.fromJson(json['maxGasPrice'] as Map<String, dynamic>)
  ..minGasPrice = MinGasPrice.fromJson(json['minGasPrice'] as Map<String, dynamic>)
  ..defaultGasPrice = DefaultGasPrice.fromJson(json['defaultGasPrice'] as Map<String, dynamic>)
  ..ethUnit = BigInt.parse(json['ethUnit'] as String)
  ..eeeUnit = BigInt.parse(json['eeeUnit'] as String)
  ..systemSymbol = json['systemSymbol'] as String
  ..accountSymbol = json['accountSymbol'] as String
  ..tokenXSymbol = json['tokenXSymbol'] as String
  ..balanceSymbol = json['balanceSymbol'] as String
  ..eeeSymbol = json['eeeSymbol'] as String
  ..privateConfig = PrivateConfig.fromJson(json['privateConfig'] as Map<String, dynamic>);

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'lastTimeConfigCheck': instance.lastTimeConfigCheck,
      'intervalMilliseconds': instance.intervalMilliseconds,
      'currency': instance.currency,
      'locale': instance.locale,
      'languages': instance.languages,
      'diamondCa': instance.diamondCa,
      'maxGasLimit': instance.maxGasLimit,
      'minGasLimit': instance.minGasLimit,
      'defaultGasLimit': instance.defaultGasLimit,
      'maxGasPrice': instance.maxGasPrice,
      'minGasPrice': instance.minGasPrice,
      'defaultGasPrice': instance.defaultGasPrice,
      'ethUnit': instance.ethUnit.toString(),
      'eeeUnit': instance.eeeUnit.toString(),
      'systemSymbol': instance.systemSymbol,
      'accountSymbol': instance.accountSymbol,
      'tokenXSymbol': instance.tokenXSymbol,
      'balanceSymbol': instance.balanceSymbol,
      'eeeSymbol': instance.eeeSymbol,
      'privateConfig': instance.privateConfig,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language()
  ..localeKey = json['localeKey'] as String
  ..localeValue = json['localeValue'] as String;

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'localeKey': instance.localeKey,
      'localeValue': instance.localeValue,
    };

MaxGasLimit _$MaxGasLimitFromJson(Map<String, dynamic> json) => MaxGasLimit()
  ..ethGasLimit = (json['ethGasLimit'] as num).toDouble()
  ..erc20GasLimit = (json['erc20GasLimit'] as num).toDouble();

Map<String, dynamic> _$MaxGasLimitToJson(MaxGasLimit instance) => <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

MinGasLimit _$MinGasLimitFromJson(Map<String, dynamic> json) => MinGasLimit()
  ..ethGasLimit = (json['ethGasLimit'] as num).toDouble()
  ..erc20GasLimit = (json['erc20GasLimit'] as num).toDouble();

Map<String, dynamic> _$MinGasLimitToJson(MinGasLimit instance) => <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

DefaultGasLimit _$DefaultGasLimitFromJson(Map<String, dynamic> json) => DefaultGasLimit()
  ..ethGasLimit = (json['ethGasLimit'] as num).toDouble()
  ..erc20GasLimit = (json['erc20GasLimit'] as num).toDouble();

Map<String, dynamic> _$DefaultGasLimitToJson(DefaultGasLimit instance) => <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

MaxGasPrice _$MaxGasPriceFromJson(Map<String, dynamic> json) => MaxGasPrice()
  ..ethGasPrice = (json['ethGasPrice'] as num).toDouble()
  ..erc20GasPrice = (json['erc20GasPrice'] as num).toDouble();

Map<String, dynamic> _$MaxGasPriceToJson(MaxGasPrice instance) => <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

MinGasPrice _$MinGasPriceFromJson(Map<String, dynamic> json) => MinGasPrice()
  ..ethGasPrice = (json['ethGasPrice'] as num).toDouble()
  ..erc20GasPrice = (json['erc20GasPrice'] as num).toDouble();

Map<String, dynamic> _$MinGasPriceToJson(MinGasPrice instance) => <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

DefaultGasPrice _$DefaultGasPriceFromJson(Map<String, dynamic> json) => DefaultGasPrice()
  ..ethGasPrice = (json['ethGasPrice'] as num).toDouble()
  ..erc20GasPrice = (json['erc20GasPrice'] as num).toDouble();

Map<String, dynamic> _$DefaultGasPriceToJson(DefaultGasPrice instance) => <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token()
  ..contractAddress = json['contractAddress'] as String
  ..shortName = json['shortName'] as String
  ..fullName = json['fullName'] as String
  ..urlImg = json['urlImg'] as String
  ..id = json['id'] as String
  ..decimal = json['decimal'] as String
  ..chainType = json['chainType'] as String;

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'contractAddress': instance.contractAddress,
      'shortName': instance.shortName,
      'fullName': instance.fullName,
      'urlImg': instance.urlImg,
      'id': instance.id,
      'decimal': instance.decimal,
      'chainType': instance.chainType,
    };

PrivateConfig _$PrivateConfigFromJson(Map<String, dynamic> json) => PrivateConfig()
  ..serverConfigIp = json['serverConfigIp'] as String
  ..serverApkVersion = json['serverApkVersion'] as String
  ..configVersion = json['configVersion'] as String
  ..downloadAppUrl = json['downloadAppUrl'] as String
  ..downloadLatestAppUrl = json['downloadLatestAppUrl'] as String
  ..rateUrl = json['rateUrl'] as String
  ..authDigitVersion = json['authDigitVersion'] as int
  ..authDigitIpList = (json['authDigitIpList'] as List<dynamic>).map((e) => e as String).toList()
  ..defaultDigitVersion = json['defaultDigitVersion'] as int
  ..defaultDigitIpList = (json['defaultDigitIpList'] as List<dynamic>).map((e) => e as String).toList()
  ..defaultTokens = (json['defaultTokens'] as List<dynamic>).map((e) => Token.fromJson(e as Map<String, dynamic>)).toList()
  ..scryXIp = json['scryXIp'] as String
  ..publicIp = json['publicIp'] as String
  ..etherscanKey = json['etherscanKey'] as String
  ..dddMainNetCA = json['dddMainNetCA'] as String
  ..dddTestNetCA = json['dddTestNetCA'] as String
  ..d2eMainNetEthAddress = json['d2eMainNetEthAddress'] as String
  ..d2eTestNetEthAddress = json['d2eTestNetEthAddress'] as String
  ..dappOpenUrl = json['dappOpenUrl'] as String;

Map<String, dynamic> _$PrivateConfigToJson(PrivateConfig instance) => <String, dynamic>{
      'serverConfigIp': instance.serverConfigIp,
      'serverApkVersion': instance.serverApkVersion,
      'configVersion': instance.configVersion,
      'downloadAppUrl': instance.downloadAppUrl,
      'downloadLatestAppUrl': instance.downloadLatestAppUrl,
      'rateUrl': instance.rateUrl,
      'authDigitVersion': instance.authDigitVersion,
      'authDigitIpList': instance.authDigitIpList,
      'defaultDigitVersion': instance.defaultDigitVersion,
      'defaultDigitIpList': instance.defaultDigitIpList,
      'defaultTokens': instance.defaultTokens,
      'scryXIp': instance.scryXIp,
      'publicIp': instance.publicIp,
      'etherscanKey': instance.etherscanKey,
      'dddMainNetCA': instance.dddMainNetCA,
      'dddTestNetCA': instance.dddTestNetCA,
      'd2eMainNetEthAddress': instance.d2eMainNetEthAddress,
      'd2eTestNetEthAddress': instance.d2eTestNetEthAddress,
      'dappOpenUrl': instance.dappOpenUrl,
    };
