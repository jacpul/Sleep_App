import 'package:flutter/material.dart';
//import 'package:units/dreams/utils/dreams_constant.dart';
import 'dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

double calculator(double wakeHour, double wakeMinute, double sleepHour, double sleepMinute, UnitType wake, UnitType sleep) {

  //List result = new List.filled(3, null, growable: false);
  double tempHour = 0.0;
  double tempMinute = 0.00;
  double result = 0.0;
  print(sleepHour);
  print(sleepMinute);
  print(sleep);
  print(wakeHour);
  print(wakeMinute);
  print(wake);

  //sleep at night, wake at morning
  if(sleep == UnitType.PM && wake == UnitType.AM) {
    tempHour = 12.0 - sleepHour;
    tempHour = tempHour + wakeHour;
    tempMinute = wakeMinute + sleepMinute;
    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
    result = tempHour + (tempMinute/100);
    return result;
  }
  //sleep in morning, wake at night
  if(sleep == UnitType.AM && wake == UnitType.PM) {
    tempHour = 12.0 - sleepHour;
    tempHour = tempHour + wakeHour;
    tempMinute = wakeMinute + sleepMinute;
    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
    result = tempHour + (tempMinute/100);
    return result;
  }
  //sleep at night, wake at night
  if(sleep == UnitType.PM && wake == UnitType.PM) {
    tempHour = wakeHour - sleepHour;
    tempMinute = wakeMinute - sleepMinute;
    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
    result = tempHour + (tempMinute/100);
    return result;
  }
  //sleep at morning, wake at morning
  if(sleep == UnitType.AM && wake == UnitType.AM) {
    tempHour = wakeHour - sleepHour;
    print(tempHour);
    tempMinute = wakeMinute - sleepMinute;
    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
    result = tempHour + (tempMinute/100);
    return result;
  }

  /*if(wake == UnitType.AM) {
    tempHour = hour + sleepHour;
    tempMinute = minute + sleepMinute;

    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
  }
  if (wake == UnitType.PM) {
    tempHour = hour - sleepHour;
    tempMinute = minute - sleepMinute;

    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
  }

  if(tempHour > 12 || tempHour < 0) {
    switch(sleep) {
      case UnitType.AM: { sleep = UnitType.PM; }
      break;
      case UnitType.PM: { sleep = UnitType.AM; }
      break;
      default: {}
      break;
    }

    tempHour %= 12;
  }
  if(tempHour ==0){
    tempHour = 12;
  }

  //result = tempHour + (tempMinute/100);
  result[0] = (tempHour + (tempMinute/100));

  return result[0];*/
  return result;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }

}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}