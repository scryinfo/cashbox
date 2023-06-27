import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

//  生成对应的config.g.dart文件，  执行命令 flutter packages pub run build_runner build

@JsonSerializable()
class Config extends Object {
  Config();

  int lastTimeConfigCheck = 0;
  int intervalMilliseconds = 0;
  String currency = "";
  String locale = "";
  List<Language> languages = [];
  String diamondCa = ""; //diamond Dapp contractAddress

  MaxGasLimit maxGasLimit = MaxGasLimit();
  MinGasLimit minGasLimit = MinGasLimit();
  DefaultGasLimit defaultGasLimit = DefaultGasLimit();

  MaxGasPrice maxGasPrice = MaxGasPrice(); // 注意：配置文件中的单位 gwei
  MinGasPrice minGasPrice = MinGasPrice(); // 注意：配置文件中的单位 gwei
  DefaultGasPrice defaultGasPrice = DefaultGasPrice(); // 注意：配置文件中的单位 gwei

  BigInt ethUnit = BigInt.zero;
  BigInt eeeUnit = BigInt.zero;
  String systemSymbol = "";
  String accountSymbol = "";
  String tokenXSymbol = "";
  String balanceSymbol = "";
  String eeeSymbol = "";

  PrivateConfig privateConfig = PrivateConfig();

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class Language extends Object {
  Language();

  String localeKey = "";
  String localeValue = "";

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class MaxGasLimit extends Object {
  MaxGasLimit();

  double ethGasLimit = 0;
  double erc20GasLimit = 0;

  factory MaxGasLimit.fromJson(Map<String, dynamic> json) => _$MaxGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasLimitToJson(this);
}

@JsonSerializable()
class MinGasLimit extends Object {
  MinGasLimit();

  double ethGasLimit = 0;
  double erc20GasLimit = 0;

  factory MinGasLimit.fromJson(Map<String, dynamic> json) => _$MinGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasLimitToJson(this);
}

@JsonSerializable()
class DefaultGasLimit extends Object {
  DefaultGasLimit();

  double ethGasLimit = 0;
  double erc20GasLimit = 0;

  factory DefaultGasLimit.fromJson(Map<String, dynamic> json) => _$DefaultGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasLimitToJson(this);
}

@JsonSerializable()
class MaxGasPrice extends Object {
  MaxGasPrice();

  double ethGasPrice = 0;
  double erc20GasPrice = 0;

  factory MaxGasPrice.fromJson(Map<String, dynamic> json) => _$MaxGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasPriceToJson(this);
}

@JsonSerializable()
class MinGasPrice extends Object {
  MinGasPrice();

  double ethGasPrice = 0;
  double erc20GasPrice = 0;

  factory MinGasPrice.fromJson(Map<String, dynamic> json) => _$MinGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasPriceToJson(this);
}

@JsonSerializable()
class DefaultGasPrice extends Object {
  DefaultGasPrice();

  double ethGasPrice = 0;
  double erc20GasPrice = 0;

  factory DefaultGasPrice.fromJson(Map<String, dynamic> json) => _$DefaultGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasPriceToJson(this);
}

@JsonSerializable()
class Token extends Object {
  Token();

  String contractAddress = "";
  String shortName = "";
  String fullName = "";
  String urlImg = "";
  String id = "";
  String decimal = "";
  String chainType = "";

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class PrivateConfig {
  PrivateConfig();

  String serverConfigIp = "";
  String serverApkVersion = "";
  String configVersion = "";
  String downloadAppUrl = "";
  String downloadLatestAppUrl = "";
  String rateUrl = "";
  int authDigitVersion = 0;
  List<String> authDigitIpList = [];
  int defaultDigitVersion = 0;
  List<String> defaultDigitIpList = [];
  List<Token> defaultTokens = [];
  String scryXIp = "";
  String publicIp = "";
  String etherscanKey = "";
  String dddMainNetCA = "";
  String dddTestNetCA = "";
  String d2eMainNetEthAddress = "";
  String d2eTestNetEthAddress = "";
  String dappOpenUrl = "";

  factory PrivateConfig.fromJson(Map<String, dynamic> json) => _$PrivateConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateConfigToJson(this);
}
