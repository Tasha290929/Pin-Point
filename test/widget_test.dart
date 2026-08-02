import 'package:flutter_test/flutter_test.dart';

import 'package:pin_point/main.dart';
import 'package:pin_point/splash_screen.dart';

void main() {
  testWidgets('App starts and shows the splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Pin Point'), findsOneWidget);
  });
}
