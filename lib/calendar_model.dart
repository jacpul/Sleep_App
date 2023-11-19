import 'dart:collection';
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