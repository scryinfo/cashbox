import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  test('adds one to input values', () {
    Logger logUtil = Logger(logFileName: "testLog");
    logUtil.e("tag", "message");

    // expect(calculator.addOne(2), 3);
  });
}
