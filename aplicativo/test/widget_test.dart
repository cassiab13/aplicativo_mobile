import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aplicativo/main.dart';

void main() {
  testWidgets('should test login page successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Logout'), findsNothing);

    expect(find.byType(ElevatedButton), findsNWidgets(2));

    await tester.tap(find.text('Login'));
    await tester.pump();
    
    expect(find.text('Login'), findsOneWidget);
    
  });
}
