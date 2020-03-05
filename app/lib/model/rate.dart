class Rate {
  static Rate get instance => _getInstance();
  static Rate _instance; //private

  static _getInstance() {
    if (_instance == null) {
      _instance = new Rate._internal();
      return _instance;
    }
    return _instance;
  }

  Rate._internal() {
    // 可初始化参数
  }

  Map digitRateMap = Map<String, DigitRate>();

  setDigitRateMap(Map digitRateMap) {
    this.digitRateMap = digitRateMap;
  }
}

class DigitRate {
  String name = "";
  String symbol = "";
  double price = 0.0;
  double high = 0.0;
  double low = 0.0;
  double histHigh = 0.0;
  double histLow = 0.0;
  int timestamps = 0;
  int volume = 0;
  double changeHourly = 0.00;

  String get getChangeHour {
    if (changeHourly > 0) {
      return (changeHourly * 100.0).toString() + "%" + "↑";
    }
    return (changeHourly * 100.0).toString() + "%" + "↓";
  }
}
