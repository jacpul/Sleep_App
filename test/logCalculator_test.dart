import '../lib/dreams/utils/dreams_constant.dart';
import '../lib/dreams/utils/dreams_utils.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  test('Went to bed PM, woke up AM', () {

    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 8.0;
    double wakeMinute = 15.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.PM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 9.45);

  });

  test('Went to bed AM, woke up PM', () {

    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 15.0;
    double wakeHour = 8.0;
    double wakeMinute = 30.0;
    UnitType wake = UnitType.PM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 10.15);

  });

  test('Went to bed AM, woke up AM the next morning', () {

    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 8.0;
    double wakeMinute = 15.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 21.45);

  });

  test('Went to bed AM, woke up AM the same morning', () {

    //Arrange
    double sleepHour = 8.0;
    double sleepMinute = 30.0;
    double wakeHour = 10.0;
    double wakeMinute = 15.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 1.45);

  });

  test('Went to bed PM, woke up PM the same night', () {

    //Arrange
    double sleepHour = 8.0;
    double sleepMinute = 30.0;
    double wakeHour = 10.0;
    double wakeMinute = 15.0;
    UnitType wake = UnitType.PM;
    UnitType sleep = UnitType.PM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 1.45);

  });

  test('Went to bed PM, woke up PM the next night', () {

    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 8.0;
    double wakeMinute = 15.0;
    UnitType wake = UnitType.PM;
    UnitType sleep = UnitType.PM;
    double calcResult;

    //Act
    calcResult = calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 21.45);

  });

  test('Went to bed and woke up at same time (24hrs)', ()
  {
    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 10.0;
    double wakeMinute = 30.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult =
        calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 24.0);
  });

  test('Sleeping 23.59 hours', ()
  {
    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 10.0;
    double wakeMinute = 29.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult =
        calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 23.59);
  });

  test('Sleeping one minute', ()
  {
    //Arrange
    double sleepHour = 10.0;
    double sleepMinute = 30.0;
    double wakeHour = 10.0;
    double wakeMinute = 31.0;
    UnitType wake = UnitType.AM;
    UnitType sleep = UnitType.AM;
    double calcResult;

    //Act
    calcResult =
        calculator(wakeHour, wakeMinute, sleepHour, sleepMinute, wake, sleep);

    //Assert
    expect(calcResult, 0.01);
  });
}