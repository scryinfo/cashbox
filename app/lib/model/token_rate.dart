import 'package:app/model/token.dart';

class TokenRate {
  static TokenRate get instance => _getInstance();
  static late TokenRate _instance; //private

  static _getInstance() {
    if (_instance == null) {
      _instance = new TokenRate._internal();
      return _instance;
    }
    return _instance;
  }

  TokenRate._internal();

  Map<String, TokenRateM> tokenRateMap = Map<String, TokenRateM>();
  Map legalMap = Map<String, double>();
  String nowLegalCurrency = "USD";

  setDigitRateMap(Map<String, TokenRateM> digitRateMap) {
    this.tokenRateMap = digitRateMap;
  }

  setLegalMap(map) {
    this.legalMap = map;
  }

  List<String> getAllSupportLegalCurrency() {
    return List.from(this.legalMap.keys);
  }

  setNowLegalCurrency(String nowLegalCurrency) {
    this.nowLegalCurrency = nowLegalCurrency;
  }

  String getNowLegalCurrency() {
    return this.nowLegalCurrency;
  }

  getNowLegalCurrencyRate() {
    return this.legalMap[this.nowLegalCurrency];
  }

  double getChangeDaily(TokenM digit) {
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    } else {
      return this.tokenRateMap[digit.shortName.trim().toUpperCase()]?.changeDaily??0;
    }
  }

  String decorateChangeDaily(double changeDaily) {
    if (changeDaily >= 0) {
      return changeDaily.toStringAsFixed(5) + "%" + "↑";
    }
    return changeDaily.toStringAsFixed(5) + "%" + "↓";
  }

  String getName(TokenM digit) {
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.tokenRateMap[digit.shortName.trim().toUpperCase()]?.name??"";
  }

  String getSymbol(TokenM digit) {
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.tokenRateMap[digit.shortName.trim().toUpperCase()]?.symbol??"";
  }

  double getPrice(TokenM digit) {
    //Unit price corresponding to fiat currency
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return (instance.tokenRateMap[digit.shortName.trim().toUpperCase()]?.price??0) * instance.legalMap[getNowLegalCurrency()];
  }

  double getMoney(TokenM digit) {
    if (digit.balance == null || digit.balance.trim() == "") {
      return 0.0;
    }
    return getPrice(digit) * double.parse(digit.balance);
  }

  double getHigh(TokenM digit) {
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.tokenRateMap[digit.shortName.trim().toUpperCase()].high;
  }

  double getLow(TokenM digit) {
    if (!tokenRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.tokenRateMap[digit.shortName.trim().toUpperCase()].low;
  }
}

//API returns the model format is consistent
class TokenRateM {
  String name = "";
  String symbol = "";
  double price = 0.0;
  double high = 0.0;
  double low = 0.0;
  double histHigh = 0.0;
  double histLow = 0.0;
  int timestamps = 0;
  double volume = 0;
  double changeDaily = 0.00;
}
