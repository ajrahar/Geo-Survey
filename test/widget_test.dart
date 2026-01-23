import 'package:flutter_test/flutter_test.dart';
import 'package:geosurvey/main.dart';

void main() {
  testWidgets('Geo Survey app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GeoSurveyApp());

    // Verify app title
    expect(find.text('Selamat Datang di Geo Survey'), findsOneWidget);
    expect(find.text('Mulai Survey Baru'), findsOneWidget);
  });
}
