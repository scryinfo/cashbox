// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerConfigModel _$ServerConfigModelFromJson(Map<String, dynamic> json) =>
    ServerConfigModel()
      ..code = json['code'] as int
      ..message = json['message'] as String
      ..detail = json['detail'] as String
      ..data = Data.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$ServerConfigModelToJson(ServerConfigModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'detail': instance.detail,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data()
  ..latestConfig =
      LatestConfig.fromJson(json['latestConfig'] as Map<String, dynamic>);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'latestConfig': instance.latestConfig,
    };

LatestConfig _$LatestConfigFromJson(Map<String, dynamic> json) => LatestConfig()
  ..tokenToLegalTenderExchangeRateIp =
      json['tokenToLegalTenderExchangeRateIp'] as String
  ..authTokenListVersion = json['authTokenListVersion'] as int
  ..defaultTokenListVersion = json['defaultTokenListVersion'] as int
  ..authTokenUrl =
      (json['authTokenUrl'] as List<dynamic>).map((e) => e as String).toList()
  ..defaultTokenUrl = (json['defaultTokenUrl'] as List<dynamic>)
      .map((e) => e as String)
      .toList()
  ..announcementUrl = json['announcementUrl'] as String
  ..scryXChainUrl = json['scryXChainUrl'] as String
  ..apkVersion = json['apkVersion'] as String
  ..apkDownloadLink = json['apkDownloadLink'] as String
  ..dappOpenUrl = json['dappOpenUrl'] as String
  ..eeeTxV = json['eeeTxV'] as String
  ..eeeRuntimeV = json['eeeRuntimeV'] as String;

Map<String, dynamic> _$LatestConfigToJson(LatestConfig instance) =>
    <String, dynamic>{
      'tokenToLegalTenderExchangeRateIp':
          instance.tokenToLegalTenderExchangeRateIp,
      'authTokenListVersion': instance.authTokenListVersion,
      'defaultTokenListVersion': instance.defaultTokenListVersion,
      'authTokenUrl': instance.authTokenUrl,
      'defaultTokenUrl': instance.defaultTokenUrl,
      'announcementUrl': instance.announcementUrl,
      'scryXChainUrl': instance.scryXChainUrl,
      'apkVersion': instance.apkVersion,
      'apkDownloadLink': instance.apkDownloadLink,
      'dappOpenUrl': instance.dappOpenUrl,
      'eeeTxV': instance.eeeTxV,
      'eeeRuntimeV': instance.eeeRuntimeV,
    };
