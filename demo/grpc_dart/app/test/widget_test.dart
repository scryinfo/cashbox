import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    //在单元测试的情况下，如果界面的事件函数有调用grpc时，程序不会正常工作
    return;
    // {
    //   final channel = ClientChannel(
    //     '192.168.2.5',
    //     port: 50061,
    //     options: const ChannelOptions(credentials: ChannelCredentials.insecure(), connectionTimeout: Duration(minutes: 1)),
    //   );
    //   final stub = GreeterClient(channel);
    //   final name = 'world';
    //   try {
    //     await tester.runAsync(()async {
    //       var response = await stub.sayHello(HelloRequest()..name = name);
    //       print('Greeter client received: ${response.message}');
    //     });
    //   } catch (e) {
    //     print('Caught error: $e');
    //   }
    //   channel.shutdown();
    // }
    // Build our app and trigger a frame.
    var app = MyApp();
    await tester.pumpWidget(app);

    // Verify that our counter starts at 0.
    expect(find.text('0: '), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    // await clickDone!;
    // clickDone = null;
    // expect(find.text('1: dart'), findsOneWidget);
  });
}
