import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scry_webview/scry_webview.dart';

void main() {
  const MethodChannel channel = MethodChannel('scry_webview');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    //expect(await ScryWebview.platformVersion, '42');
  });
}
