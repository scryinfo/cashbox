class Rate {
  DigitRate getDigitRate() {
    var digitRate = DigitRate();
    return digitRate;
  }
}

class DigitRate {
  String name;
  String symbol;
  double price;
  double high;
  double low;
  double histHigh;
  double histLow;
  double timestamps;
  double volume;
  double changeHourly;

  String getShortName() {
    return symbol;
  }

  String getFullName() {
    return name;
  }
}
