import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/main.dart';
import 'package:school_app/base/routes/app_route_config.dart';  // Import your Approuter here

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create an instance of Approuter
    final appRouter = Approuter();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(appRouter: appRouter));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
