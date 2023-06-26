import 'package:json_annotation/json_annotation.dart';

part 'server_config_model.g.dart';
//  生成对应的config.g.dart文件，  执行命令 flutter packages pub run build_runner build

@JsonSerializable()
class ServerConfigModel extends Object {
  ServerConfigModel();

  int code;
  String message;
  String detail;
  Data data;

  factory ServerConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ServerConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServerConfigModelToJson(this);
}

@JsonSerializable()
class Data extends Object {
  Data();

  LatestConfig latestConfig;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LatestConfig extends Object {
  LatestConfig();

  String tokenToLegalTenderExchangeRateIp;
  int authTokenListVersion;
  int defaultTokenListVersion;
  List<String> authTokenUrl;
  List<String> defaultTokenUrl;
  String announcementUrl;
  String scryXChainUrl;
  String apkVersion;
  String apkDownloadLink;
  String dappOpenUrl;
  String eeeTxV;
  String eeeRuntimeV;

  factory LatestConfig.fromJson(Map<String, dynamic> json) =>
      _$LatestConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LatestConfigToJson(this);
}
