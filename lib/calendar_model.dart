import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final eventToday = DateTime.now();
final eventFirstDay = DateTime(eventToday.year, eventToday.month - 5, eventToday.day);
final eventLastDay = DateTime(eventToday.year, eventToday.month + 5, eventToday.day);

class Event {
  final String title;
  final String day;
  final String month;
  final String year;

  Event(this.title, this.day, this.month, this.year);

  @override
  String toString() => title;
}

/**
 * returns a custom hashcode for the hashmap
 * @param DateTime key
 * @return a value corresponding to the DateTime
 */
int getHashCode(DateTime key) {
return key.day * 1000000 + key.month * 10000 + key.year;
}

/**
 * populates a LinkedHashMap of DateTime and List of Events
 * @param logData this a collection refrence
 * @return LinkedHashMap<DateTime, List<Event>>
 */
Future<LinkedHashMap<DateTime, List<Event>>> populateLogList(var logData) async {
  var tempLinkedMap = <DateTime, List<Event>> {};
  logData.docs.forEach((element) {
    int day = -1;
    int month = -1;
    int year = -1;
    String strDay = "Day Not Found";
    String strMonth = "Month Not Found";
    String strYear = "Year Not Found";
    String wake = "Wake Time Not Found";
    String hours = "Hours Slept Not Found";
    print(element.id);
    if (element['Day']) {
      day = element['Day'];
      strDay = day.toString();
    }
    if (element['Month']) {
      month = element['Month'];
      strMonth = month.toString();
    }
    if (element['Year']) {
      year = element['Year'];
      strYear = year.toString();
    }
    DateTime eventDay = DateTime(year, month, day);
    tempLinkedMap.putIfAbsent(eventDay, () => []);
    if (element['Wake Time']) {
      wake = element['Wake Time'];
    }
    if (element['Hours_Slept']) {
      hours = element['Hours_Slept'];
    }
    String title = "$month/$day/$year: woke up at $wake, with $hours of sleep";
    tempLinkedMap[eventDay]?.add(Event(title, strDay, strMonth, strYear));
    debugPrint('title: $title Length of Map: ${tempLinkedMap.length}');
  });
  return LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode
  )..addAll(tempLinkedMap);
}



