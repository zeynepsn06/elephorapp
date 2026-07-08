import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:elephorapp/app.dart';

void main() {
  testWidgets('Elephor+ smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ElePhorApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
