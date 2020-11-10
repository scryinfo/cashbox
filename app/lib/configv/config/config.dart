import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

//  生成对应的config.g.dart文件，  执行命令 flutter packages pub run build_runner build

@JsonSerializable()
class Config extends Object {
  Config();

  bool isInitializedDB;
  String currency;
  String locale;
  List<Language> languages;
  String serverAppVersion;

  MaxGasLimit maxGasLimit;
  MinGasLimit minGasLimit;
  DefaultGasLimit defaultGasLimit;

  MaxGasPrice maxGasPrice;
  MinGasPrice minGasPrice;
  DefaultGasPrice defaultGasPrice;

  String dbVersion;
  BigInt ethUnit;
  BigInt eeeUnit;
  String systemSymbol;
  String accountSymbol;
  String tokenXSymbol;
  String balanceSymbol;
  String eeeSymbol;

  PrivateConfig privateConfig;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class Language extends Object {
  Language();

  String localeKey;
  String localeValue;

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class MaxGasLimit extends Object {
  MaxGasLimit();

  int ethGasLimit;
  int erc20GasLimit;

  factory MaxGasLimit.fromJson(Map<String, dynamic> json) => _$MaxGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasLimitToJson(this);
}

@JsonSerializable()
class MinGasLimit extends Object {
  MinGasLimit();

  int ethGasLimit;
  int erc20GasLimit;

  factory MinGasLimit.fromJson(Map<String, dynamic> json) => _$MinGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasLimitToJson(this);
}

@JsonSerializable()
class DefaultGasLimit extends Object {
  DefaultGasLimit();

  int ethGasLimit;
  int erc20GasLimit;

  factory DefaultGasLimit.fromJson(Map<String, dynamic> json) => _$DefaultGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasLimitToJson(this);
}

@JsonSerializable()
class MaxGasPrice extends Object {
  MaxGasPrice();

  int ethGasPrice;
  int erc20GasPrice;

  factory MaxGasPrice.fromJson(Map<String, dynamic> json) => _$MaxGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasPriceToJson(this);
}

@JsonSerializable()
class MinGasPrice extends Object {
  MinGasPrice();

  int ethGasPrice;
  int erc20GasPrice;

  factory MinGasPrice.fromJson(Map<String, dynamic> json) => _$MinGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasPriceToJson(this);
}

@JsonSerializable()
class DefaultGasPrice extends Object {
  DefaultGasPrice();

  int ethGasPrice;
  int erc20GasPrice;

  factory DefaultGasPrice.fromJson(Map<String, dynamic> json) => _$DefaultGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasPriceToJson(this);
}

@JsonSerializable()
class PrivateConfig {
  PrivateConfig();

  String serverConfigIp;
  String configVersion;
  String downloadAppUrl;
  String downloadLatestAppUrl;
  String rateUrl;
  String authDigitVersion;
  String authDigitIp;
  String defaultDigitVersion;
  String defaultDigitIp;
  String defaultDigitContent;
  String scryXIp;
  String publicIp;
  String nowDbVersion;
  String etherscanKey;
  String dddMainNetCA;
  String dddTestNetCA;
  String dappOpenUrl;

  factory PrivateConfig.fromJson(Map<String, dynamic> json) => _$PrivateConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateConfigToJson(this);
}
