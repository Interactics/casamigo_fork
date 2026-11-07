import 'package:flutter_test/flutter_test.dart';
import 'package:hearth/main.dart';

void main() {
  testWidgets('Casamigo opens the house', (tester) async {
    await tester.pumpWidget(const CasamigoApp());
    expect(find.text('Opening the house…'), findsOneWidget);
  });
}
