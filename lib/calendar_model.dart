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

int getHashCode(DateTime key) {
return key.day * 1000000 + key.month * 10000 + key.year;
}

Future<LinkedHashMap<DateTime, List<Event>>> populateLogList(var logData) async {
  var tempLinkedMap = <DateTime, List<Event>> {};
  logData.docs.forEach((element) {
    print(element.id);
    int day = element['Day'];
    int month = element['Month'];
    int year = element['Year'];
    String strDay = day.toString();
    String strMonth = month.toString();
    String strYear = year.toString();
    DateTime eventDay = DateTime(year, month, day);
    //String wake = element['Wake Time'];
    String hours = element['Hours_Slept'];
    //String title = "$month/$day/$year: woke up at $wake, with $hours of sleep";
    String title = "$month/$day/$year: with $hours of sleep";
    tempLinkedMap.putIfAbsent(eventDay, () => []);
    tempLinkedMap[eventDay]?.add(Event(title, strDay, strMonth, strYear));
    debugPrint('title: $title Length of Map: ${tempLinkedMap.length}');
  });
  return LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode
  )..addAll(tempLinkedMap);
}



