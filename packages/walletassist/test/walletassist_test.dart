import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletassist/wallet_assist.dart';

void main() {
  const MethodChannel channel = MethodChannel('walletassist');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//  test('getPlatformVersion', () async {
//    expect(await Walletassist.platformVersion, '42');
//  });
}
