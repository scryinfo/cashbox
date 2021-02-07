import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

void main() {
  test('adds one to input values', () {
    Logger logger = Logger();
    logger.e("tag", "message");

    logger.setLogLevel(LogLevel.Info);
    logger.d("d tag", "d message");
    logger.i("i tag", "i message");
  });
  group("logger test 1", () {
    test("case LogLevel.Debug", () {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Debug);
      logger.d("tag d ", "LogLevel.Debug d message");
      logger.i("tag i ", "LogLevel.Debug i message");
      logger.w("tag w ", "LogLevel.Debug w message");
      logger.e("tag e ", "LogLevel.Debug e message");
      logger.f("tag f ", "LogLevel.Debug f message");
    });
    test("case LogLevel.Info", () {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Info);
      logger.d("tag d ", "LogLevel.Info d message");
      logger.i("tag i ", "LogLevel.Info i message");
      logger.w("tag w ", "LogLevel.Info w message");
      logger.e("tag e ", "LogLevel.Info e message");
      logger.f("tag f ", "LogLevel.Info f message");
    });
    test("case LogLevel.Warn", () {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Warn);
      logger.d("tag d ", "LogLevel.Warn d message");
      logger.i("tag i ", "LogLevel.Warn i message");
      logger.w("tag w ", "LogLevel.Warn w message");
      logger.e("tag e ", "LogLevel.Warn e message");
      logger.f("tag f ", "LogLevel.Warn f message");
    });
    test("case LogLevel.Error", () {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Error);
      logger.d("tag d ", "LogLevel.Error d message");
      logger.i("tag i ", "LogLevel.Error i message");
      logger.w("tag w ", "LogLevel.Error w message");
      logger.e("tag e ", "LogLevel.Error e message");
      logger.f("tag f ", "LogLevel.Error f message");
    });
    test("case LogLevel.Fatal", () {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Fatal);
      logger.d("tag d ", "LogLevel.Fatal d message");
      logger.i("tag i ", "LogLevel.Fatal i message");
      logger.w("tag w ", "LogLevel.Fatal w message");
      logger.e("tag e ", "LogLevel.Fatal e message");
      logger.f("tag f ", "LogLevel.Fatal f message");
    });
  });
  group("multi thread ", () {
    test("multi Thread 1 ", () async {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Fatal);
      var err = await compute(computeFun, logger);
    });
    test("multi Thread 2 ", () async {
      Logger logger = Logger();
      logger.setLogLevel(LogLevel.Fatal);
      var err = await compute(computeFun, logger);
    });
  });
}

computeFun(Logger logger) {
  Logger logger = Logger();
  logger.setLogLevel(LogLevel.Info);
  logger.d("tag d ", "newThread LogLevel.Info d message");
  logger.i("tag i ", "newThread LogLevel.Info i message");
  logger.w("tag w ", "newThread LogLevel.Info w message");
  logger.e("tag e ", "newThread LogLevel.Info e message");
  logger.f("tag f ", "newThread LogLevel.Info f message");
}
