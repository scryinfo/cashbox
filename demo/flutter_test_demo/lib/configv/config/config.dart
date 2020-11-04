import 'package:json_annotation/json_annotation.dart';

// 动态生成的文件
part 'config.g.dart';

//  生成对应的config.g.dart文件，  执行命令 flutter packages pub run build_runner build

@JsonSerializable()
class Config extends Object {
  Config(this.currency, this.locale, this.ethUnit, this.eeeUnit);

  String currency;
  String locale;
  List<Object> languages;
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

  VendorConfig vendorConfig;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class MaxGasLimit extends Object {
  MaxGasLimit(this.ethGasLimit, this.erc20GasLimit);

  int ethGasLimit;
  int erc20GasLimit;

  factory MaxGasLimit.fromJson(Map<String, dynamic> json) => _$MaxGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasLimitToJson(this);
}

@JsonSerializable()
class MinGasLimit extends Object {
  MinGasLimit(this.ethGasLimit, this.erc20GasLimit);

  int ethGasLimit;
  int erc20GasLimit;

  factory MinGasLimit.fromJson(Map<String, dynamic> json) => _$MinGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasLimitToJson(this);
}

@JsonSerializable()
class DefaultGasLimit extends Object {
  DefaultGasLimit(this.ethGasLimit, this.erc20GasLimit);

  int ethGasLimit;
  int erc20GasLimit;

  factory DefaultGasLimit.fromJson(Map<String, dynamic> json) => _$DefaultGasLimitFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasLimitToJson(this);
}

@JsonSerializable()
class MaxGasPrice extends Object {
  MaxGasPrice(this.ethGasPrice, this.erc20GasPrice);

  int ethGasPrice;
  int erc20GasPrice;

  factory MaxGasPrice.fromJson(Map<String, dynamic> json) => _$MaxGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MaxGasPriceToJson(this);
}

@JsonSerializable()
class MinGasPrice extends Object {
  MinGasPrice(this.ethGasPrice, this.erc20GasPrice);

  int ethGasPrice;
  int erc20GasPrice;

  factory MinGasPrice.fromJson(Map<String, dynamic> json) => _$MinGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$MinGasPriceToJson(this);
}

@JsonSerializable()
class DefaultGasPrice extends Object {
  DefaultGasPrice(this.ethGasPrice, this.erc20GasPrice);

  int ethGasPrice;
  int erc20GasPrice;

  factory DefaultGasPrice.fromJson(Map<String, dynamic> json) => _$DefaultGasPriceFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultGasPriceToJson(this);
}

@JsonSerializable()
class VendorConfig {
  VendorConfig();

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

  factory VendorConfig.fromJson(Map<String, dynamic> json) => _$VendorConfigFromJson(json);

  Map<String, dynamic> toJson() => _$VendorConfigToJson(this);
}
