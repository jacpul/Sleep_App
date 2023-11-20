// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/login.dart';
import '../lib/dreams/presenter/dreams_presenter.dart';
import '../lib/dreams/viewmodel/dreams_viewmodel.dart';



void main() {
  /*testWidgets('Test Sleep Log', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Loginpage());

    await tester.enterText(find.textContaining(AutofillHints.username), 'gabe3@gmail.com');
    await tester.enterText(find.textContaining(AutofillHints.password), '123456');

    await tester.tap(find.byType(InkWell));
    await tester.pump();



  });*/
  testWidgets('Test Sleep Log', (WidgetTester tester) async {
    UNITSPresenter testP = new UNITSPresenter();
    testP.onWakeHourSubmitted("7");
    testP.onWakeMinuteSubmitted("30");
    testP.onSleepHourSubmitted("10");
    testP.onWakeMinuteSubmitted("30");
    testP.onCalculateClicked("7", "30", "10", "30");

    UNITSViewModel testVM = new UNITSViewModel();

    expect(testVM.messageInString, "9");
  });

}

