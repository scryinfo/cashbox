import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var app = MyApp();
    await tester.pumpWidget(app);
    var f = find.text('0: ');
    expect(f, findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    var t = await tester.runAsync(() async {
      return await app.home.callGrpc!.future;
    });
    if (t!) {
      // tester.pump();
      expect(1, app.home.state.counter);
      expect('world', app.home.state.replay);
    } else {
      expect(1, app.home.state.counter);
      expect('', app.home.state.replay);
    }
  });
}
