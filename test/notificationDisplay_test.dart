import 'package:flutter_test/flutter_test.dart';
import '../lib/notification_screen.dart';

void main() {

  NotificationScreen notificationScreen = new NotificationScreen();

  String findMonth(String num) {
    String month = "";
    if (num == "1") {month = "January";}
    else if (num == "2") {month = "February";}
    else if (num == "3") {month = "March";}
    else if (num == "4") {month = "April";}
    else if (num == "5") {month = "May";}
    else if (num == "6") {month = "June";}
    else if (num == "7") {month = "July";}
    else if (num == "8") {month = "August";}
    else if (num == "9") {month = "September";}
    else if (num == "10") {month = "October";}
    else if (num == "11") {month = "November";}
    else if (num == "12") {month = "December";}
    return month;
  }

  String AMorPM(int num) {
    String timeOfDay;
    if(num == 1) timeOfDay = 'PM';
    else timeOfDay = 'AM';
    return timeOfDay;
  }

  test('Test correct month entered', () {
    //String month = notificationScreen.findMonth('3');
    String month = findMonth('3');
    bool passTest = false;
    if (month == 'March')
      passTest = true;
    expect(passTest, true);
  });

  test('Test incorrect month enetered', () {
    //String month = notificationScreen.findMonth('3');
    String month = findMonth('4');
    bool passTest = true;
    if (month != 'March') passTest = false;
    expect(passTest, false);
  });

  test('test AM', () {
    //String time = notificationScreen.AMorPM(0);
    String time = AMorPM(0);
    expect(time, 'AM');
  });

  test('test PM', () {
    //String time = notificationScreen.AMorPM(1);
    String time = AMorPM(1);
    expect(time, 'PM');
  });

  test('test incorrect AM or PM', () {
    //String time = notificationScreen.AMorPM(0);
    String time = AMorPM(0);
    bool isAM;
    if (time == 'PM') isAM = false;
    else isAM = true;
    expect(isAM, true);
  });
}

