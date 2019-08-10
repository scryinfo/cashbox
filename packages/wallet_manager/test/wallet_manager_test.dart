import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_manager/wallet_manager.dart';

void main() {
  const MethodChannel channel = MethodChannel('wallet_manager');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

/*  test('getPlatformVersion', () async {
    expect(await WalletManager.platformVersion, '42');
  });*/
}
