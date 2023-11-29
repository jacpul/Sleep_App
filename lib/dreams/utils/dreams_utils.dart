import 'package:flutter/material.dart';
//import 'package:units/dreams/utils/dreams_constant.dart';
import 'dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

double calculator(double wakeHour, double wakeMinute, double sleepHour, double sleepMinute, UnitType wake, UnitType sleep) {

  double tempHour = 0.0;
  double tempMinute = 0.00;
  double result = 0.0;

  //sleep at night, wake at morning
  if(sleep == UnitType.PM && wake == UnitType.AM) {
    //Convert to Military Time
    if(sleepHour < 12) {
      sleepHour = sleepHour + 12;
    }
    tempHour = (24 - sleepHour) + wakeHour;
    if(sleepMinute > wakeMinute) {
      tempHour--;
      tempMinute = 60 - (sleepMinute - wakeMinute);
      result = tempHour + (tempMinute/100);
    } else {
      tempMinute = (sleepMinute - wakeMinute).abs();
      result = tempHour + (tempMinute / 100);
    }
    return result;
  }



  //sleep in morning, wake at night
  if(sleep == UnitType.AM && wake == UnitType.PM) {
    //Convert to Military
    if(wakeHour < 12) {
      wakeHour = wakeHour + 12;
    }
    tempHour = wakeHour - sleepHour;
    if(sleepMinute > wakeMinute) {
      tempHour--;
      tempMinute = 60 - (sleepMinute - wakeMinute);
      result = tempHour + (tempMinute/100);
    } else {
      tempMinute = (sleepMinute - wakeMinute).abs();
      result = tempHour + (tempMinute / 100);
    }
    return result;
  }

  //sleep at night, wake at night
  if(sleep == UnitType.PM && wake == UnitType.PM) {
   //Convert to Military
    wakeHour = wakeHour + 12;
    sleepHour = sleepHour + 12;

    if(sleepHour >= wakeHour && sleepMinute >= wakeMinute) {
      //User woke up the next day
      tempHour = 24 - (sleepHour - wakeHour);
      if(sleepMinute > wakeMinute) {
        tempHour--;
        tempMinute = 60 - (sleepMinute - wakeMinute);
        result = tempHour + (tempMinute/100);
      } else {
        tempMinute = (sleepMinute - wakeMinute).abs();
        result = tempHour + (tempMinute / 100);
      }
    } else {
      //User woke up the same day
      tempHour = wakeHour - sleepHour;
      if(sleepMinute > wakeMinute) {
        tempHour--;
        tempMinute = 60 - (sleepMinute - wakeMinute);
        result = tempHour + (tempMinute/100);
      } else {
        tempMinute = (sleepMinute - wakeMinute).abs();
        result = tempHour + (tempMinute / 100);
      }
    }
    return result;
  }

  //sleep at morning, wake at morning
  if(sleep == UnitType.AM && wake == UnitType.AM) {
    if(sleepHour >= wakeHour && sleepMinute >= wakeMinute) {
      //User woke up the next day
      tempHour = 24 - (sleepHour - wakeHour);
      if(sleepMinute > wakeMinute) {
        tempHour--;
        tempMinute = 60 - (sleepMinute - wakeMinute);
        result = tempHour + (tempMinute/100);
      } else {
        tempMinute = (sleepMinute - wakeMinute).abs();
        result = tempHour + (tempMinute / 100);
      }
    } else {
      //User woke up the same day
      tempHour = wakeHour - sleepHour;
      if(sleepMinute > wakeMinute) {
        tempHour--;
        tempMinute = 60 - (sleepMinute - wakeMinute);
        result = tempHour + (tempMinute/100);
      } else {
        tempMinute = (sleepMinute - wakeMinute).abs();
        result = tempHour + (tempMinute / 100);
      }
    }
    return result;
  }

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