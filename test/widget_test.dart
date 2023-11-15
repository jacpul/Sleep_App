// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/login.dart';
import '../lib/main_screen.dart';
import '../lib/main.dart';
import '../lib/notification_screen.dart';


void main() {
  testWidgets('Test Sleep Log', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Loginpage());

    await tester.enterText(find.textContaining(AutofillHints.username), 'user7@gmail.com');
    await tester.enterText(find.textContaining(AutofillHints.password), '123456');
    await tester.



  });


}
