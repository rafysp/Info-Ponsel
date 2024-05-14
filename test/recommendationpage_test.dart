import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_ponsel/screens/recommendation/recommendation_page.dart';

void main() {
  testWidgets('Test UI Recommendation Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RecommendationPage(),
    ));

    expect(find.text('Rekomendasi Ponsel'), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(1));
    

    
  });
}
