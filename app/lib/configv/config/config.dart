import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

//  生成对应的config.g.dart文件，  执行命令 flutter packages pub run build_runner build

@JsonSerializable()
class Config extends Object {
  Config();

  bool isInitedConfig;
  int lastTimeConfigCheck;
  int intervalMilliseconds;
  String currency;
  String locale;
  List<Language> languages;
  String serverAppVersion;
  String diamondCa; //diamond Dapp contractAddress

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

  double ethGasLimit;
  double erc20GasLimit;

  factory MaxGasLimit.fromJson(Map<String, dynamic> json) => _$MaxGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasLimitToJson(this);
}

@JsonSerializable()
class MinGasLimit extends Object {
  MinGasLimit();

  double ethGasLimit;
  double erc20GasLimit;

  factory MinGasLimit.fromJson(Map<String, dynamic> json) => _$MinGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasLimitToJson(this);
}

@JsonSerializable()
class DefaultGasLimit extends Object {
  DefaultGasLimit();

  double ethGasLimit;
  double erc20GasLimit;

  factory DefaultGasLimit.fromJson(Map<String, dynamic> json) => _$DefaultGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasLimitToJson(this);
}

@JsonSerializable()
class MaxGasPrice extends Object {
  MaxGasPrice();

  double ethGasPrice;
  double erc20GasPrice;

  factory MaxGasPrice.fromJson(Map<String, dynamic> json) => _$MaxGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasPriceToJson(this);
}

@JsonSerializable()
class MinGasPrice extends Object {
  MinGasPrice();

  double ethGasPrice;
  double erc20GasPrice;

  factory MinGasPrice.fromJson(Map<String, dynamic> json) => _$MinGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasPriceToJson(this);
}

@JsonSerializable()
class DefaultGasPrice extends Object {
  DefaultGasPrice();

  double ethGasPrice;
  double erc20GasPrice;

  factory DefaultGasPrice.fromJson(Map<String, dynamic> json) => _$DefaultGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasPriceToJson(this);
}

@JsonSerializable()
class Token extends Object {
  Token();

  String contractAddress;
  String shortName;
  String fullName;
  String urlImg;
  String id;
  String decimal;
  String chainType;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class PrivateConfig {
  PrivateConfig();

  String serverConfigIp;
  String serverApkVersion;
  String configVersion;
  String downloadAppUrl;
  String downloadLatestAppUrl;
  String rateUrl;
  String authDigitVersion;
  List<String> authDigitIpList;
  String defaultDigitVersion;
  List<String> defaultDigitIpList;
  List<Token> defaultTokens;
  String scryXIp;
  String publicIp;
  String nowDbVersion;
  String etherscanKey;
  String dddMainNetCA;
  String dddTestNetCA;
  String d2eMainNetEthAddress;
  String d2eTestNetEthAddress;
  String dappOpenUrl;

  factory PrivateConfig.fromJson(Map<String, dynamic> json) => _$PrivateConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateConfigToJson(this);
}
