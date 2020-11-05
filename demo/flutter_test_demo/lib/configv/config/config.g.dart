// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    json['currency'] as String,
    json['locale'] as String,
    json['ethUnit'] == null ? null : BigInt.parse(json['ethUnit'] as String),
    json['eeeUnit'] == null ? null : BigInt.parse(json['eeeUnit'] as String),
  )
    ..languages = json['languages'] as List
    ..serverAppVersion = json['serverAppVersion'] as String
    ..maxGasLimit = json['maxGasLimit'] == null
        ? null
        : MaxGasLimit.fromJson(json['maxGasLimit'] as Map<String, dynamic>)
    ..minGasLimit = json['minGasLimit'] == null
        ? null
        : MinGasLimit.fromJson(json['minGasLimit'] as Map<String, dynamic>)
    ..defaultGasLimit = json['defaultGasLimit'] == null
        ? null
        : DefaultGasLimit.fromJson(
            json['defaultGasLimit'] as Map<String, dynamic>)
    ..maxGasPrice = json['maxGasPrice'] == null
        ? null
        : MaxGasPrice.fromJson(json['maxGasPrice'] as Map<String, dynamic>)
    ..minGasPrice = json['minGasPrice'] == null
        ? null
        : MinGasPrice.fromJson(json['minGasPrice'] as Map<String, dynamic>)
    ..defaultGasPrice = json['defaultGasPrice'] == null
        ? null
        : DefaultGasPrice.fromJson(
            json['defaultGasPrice'] as Map<String, dynamic>)
    ..dbVersion = json['dbVersion'] as String
    ..systemSymbol = json['systemSymbol'] as String
    ..accountSymbol = json['accountSymbol'] as String
    ..tokenXSymbol = json['tokenXSymbol'] as String
    ..balanceSymbol = json['balanceSymbol'] as String
    ..eeeSymbol = json['eeeSymbol'] as String
    ..vendorConfig = json['vendorConfig'] == null
        ? null
        : VendorConfig.fromJson(json['vendorConfig'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'currency': instance.currency,
      'locale': instance.locale,
      'languages': instance.languages,
      'serverAppVersion': instance.serverAppVersion,
      'maxGasLimit': instance.maxGasLimit,
      'minGasLimit': instance.minGasLimit,
      'defaultGasLimit': instance.defaultGasLimit,
      'maxGasPrice': instance.maxGasPrice,
      'minGasPrice': instance.minGasPrice,
      'defaultGasPrice': instance.defaultGasPrice,
      'dbVersion': instance.dbVersion,
      'ethUnit': instance.ethUnit?.toString(),
      'eeeUnit': instance.eeeUnit?.toString(),
      'systemSymbol': instance.systemSymbol,
      'accountSymbol': instance.accountSymbol,
      'tokenXSymbol': instance.tokenXSymbol,
      'balanceSymbol': instance.balanceSymbol,
      'eeeSymbol': instance.eeeSymbol,
      'vendorConfig': instance.vendorConfig,
    };

MaxGasLimit _$MaxGasLimitFromJson(Map<String, dynamic> json) {
  return MaxGasLimit(
    json['ethGasLimit'] as int,
    json['erc20GasLimit'] as int,
  );
}

Map<String, dynamic> _$MaxGasLimitToJson(MaxGasLimit instance) =>
    <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

MinGasLimit _$MinGasLimitFromJson(Map<String, dynamic> json) {
  return MinGasLimit(
    json['ethGasLimit'] as int,
    json['erc20GasLimit'] as int,
  );
}

Map<String, dynamic> _$MinGasLimitToJson(MinGasLimit instance) =>
    <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

DefaultGasLimit _$DefaultGasLimitFromJson(Map<String, dynamic> json) {
  return DefaultGasLimit(
    json['ethGasLimit'] as int,
    json['erc20GasLimit'] as int,
  );
}

Map<String, dynamic> _$DefaultGasLimitToJson(DefaultGasLimit instance) =>
    <String, dynamic>{
      'ethGasLimit': instance.ethGasLimit,
      'erc20GasLimit': instance.erc20GasLimit,
    };

MaxGasPrice _$MaxGasPriceFromJson(Map<String, dynamic> json) {
  return MaxGasPrice(
    json['ethGasPrice'] as int,
    json['erc20GasPrice'] as int,
  );
}

Map<String, dynamic> _$MaxGasPriceToJson(MaxGasPrice instance) =>
    <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

MinGasPrice _$MinGasPriceFromJson(Map<String, dynamic> json) {
  return MinGasPrice(
    json['ethGasPrice'] as int,
    json['erc20GasPrice'] as int,
  );
}

Map<String, dynamic> _$MinGasPriceToJson(MinGasPrice instance) =>
    <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

DefaultGasPrice _$DefaultGasPriceFromJson(Map<String, dynamic> json) {
  return DefaultGasPrice(
    json['ethGasPrice'] as int,
    json['erc20GasPrice'] as int,
  );
}

Map<String, dynamic> _$DefaultGasPriceToJson(DefaultGasPrice instance) =>
    <String, dynamic>{
      'ethGasPrice': instance.ethGasPrice,
      'erc20GasPrice': instance.erc20GasPrice,
    };

VendorConfig _$VendorConfigFromJson(Map<String, dynamic> json) {
  return VendorConfig()
    ..serverConfigIp = json['serverConfigIp'] as String
    ..configVersion = json['configVersion'] as String
    ..downloadAppUrl = json['downloadAppUrl'] as String
    ..downloadLatestAppUrl = json['downloadLatestAppUrl'] as String
    ..rateUrl = json['rateUrl'] as String
    ..authDigitVersion = json['authDigitVersion'] as String
    ..authDigitIp = json['authDigitIp'] as String
    ..defaultDigitVersion = json['defaultDigitVersion'] as String
    ..defaultDigitIp = json['defaultDigitIp'] as String
    ..defaultDigitContent = json['defaultDigitContent'] as String
    ..scryXIp = json['scryXIp'] as String
    ..publicIp = json['publicIp'] as String
    ..nowDbVersion = json['nowDbVersion'] as String
    ..etherscanKey = json['etherscanKey'] as String
    ..dddMainNetCA = json['dddMainNetCA'] as String
    ..dddTestNetCA = json['dddTestNetCA'] as String
    ..dappOpenUrl = json['dappOpenUrl'] as String;
}

Map<String, dynamic> _$VendorConfigToJson(VendorConfig instance) =>
    <String, dynamic>{
      'serverConfigIp': instance.serverConfigIp,
      'configVersion': instance.configVersion,
      'downloadAppUrl': instance.downloadAppUrl,
      'downloadLatestAppUrl': instance.downloadLatestAppUrl,
      'rateUrl': instance.rateUrl,
      'authDigitVersion': instance.authDigitVersion,
      'authDigitIp': instance.authDigitIp,
      'defaultDigitVersion': instance.defaultDigitVersion,
      'defaultDigitIp': instance.defaultDigitIp,
      'defaultDigitContent': instance.defaultDigitContent,
      'scryXIp': instance.scryXIp,
      'publicIp': instance.publicIp,
      'nowDbVersion': instance.nowDbVersion,
      'etherscanKey': instance.etherscanKey,
      'dddMainNetCA': instance.dddMainNetCA,
      'dddTestNetCA': instance.dddTestNetCA,
      'dappOpenUrl': instance.dappOpenUrl,
    };
