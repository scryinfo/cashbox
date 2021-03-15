import 'package:app/model/token.dart';

class TokenRate {
  static TokenRate get instance => _getInstance();
  static TokenRate _instance; //private

  static _getInstance() {
    if (_instance == null) {
      _instance = new TokenRate._internal();
      return _instance;
    }
    return _instance;
  }

  TokenRate._internal();

  Map<String, DigitRate> digitRateMap = Map<String, DigitRate>();
  Map legalMap = Map<String, double>();
  String nowLegalCurrency = "USD";
  String symbol = "";
  double price = 0.0;
  double changeDaily = 0.00;

  setDigitRateMap(Map digitRateMap) {
    this.digitRateMap = digitRateMap;
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
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].changeDaily;
  }

  String getName(TokenM digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].name;
  }

  String getSymbol(TokenM digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].symbol;
  }

  double getPrice(TokenM digit) {
    //Unit price corresponding to fiat currency
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].price * instance.legalMap[getNowLegalCurrency()];
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["price"] * instance.legalMap[getNowLegalCurrency()];
  }

  double getMoney(TokenM digit) {
    if (digit.balance == null || digit.balance.trim() == "") {
      return 0.0;
    }
    return getPrice(digit) * double.parse(digit.balance);
  }

  double getHigh(TokenM digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].high;
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["high"];
  }

  double getLow(TokenM digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].low;
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["low"];
  }
}

//API returns the model format is consistent
class DigitRate {
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

  String get getChangeDaily {
    if (changeDaily >= 0) {
      return (changeDaily * 100.0).toStringAsFixed(5) + "%" + "↑";
    }
    return (changeDaily * 100.0).toStringAsFixed(5) + "%" + "↓";
  }
}
