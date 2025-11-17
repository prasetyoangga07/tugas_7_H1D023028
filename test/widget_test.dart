import 'package:flutter_test/flutter_test.dart';
import 'package:h1d023028_tugas7/main.dart' as app;

void main() {
  testWidgets('Login page shows Student Hub title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const app.MyApp());

    expect(find.text('Student Hub'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}
