import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_mp2/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Materi'), findsWidgets);
    expect(find.text('Profile'), findsWidgets);
  });
}
