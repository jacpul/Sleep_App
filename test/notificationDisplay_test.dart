import 'package:flutter_test/flutter_test.dart';
import '../lib/notification_screen.dart';

void main() {

  /// Creates notification screen instance to use functions tested
  NotificationScreen notificationScreen = new NotificationScreen();

  test('Test correct month entered', () {
    String month = notificationScreen.findMonth('3');
    //String month = findMonth('3');
    bool passTest = false;
    if (month == 'March')
      passTest = true;
    expect(passTest, true);
  });

  test('Test incorrect month entered', () {
    String month = notificationScreen.findMonth('4');
    //String month = findMonth('4');
    bool passTest = true;
    if (month != 'March') passTest = false;
    expect(passTest, false);
  });

  test('test AM', () {
    String time = notificationScreen.AMorPM(0);
    //String time = AMorPM(0);
    expect(time, 'AM');
  });

  test('test PM', () {
    String time = notificationScreen.AMorPM(1);
    //String time = AMorPM(1);
    expect(time, 'PM');
  });

  test('test incorrect AM or PM', () {
    String time = notificationScreen.AMorPM(0);
    //String time = AMorPM(0);
    bool isAM;
    if (time == 'PM') isAM = false;
    else isAM = true;
    expect(isAM, true);
  });
}

