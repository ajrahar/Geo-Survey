import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/main.dart';

void main() {
  testWidgets('GeoSurvey app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: GeoSurveyApp()));

    // Verify that welcome text is shown
    expect(find.text('Selamat Datang di GeoSurvey Pro'), findsOneWidget);
    expect(find.text('Mulai Survey Baru'), findsOneWidget);
  });
}
