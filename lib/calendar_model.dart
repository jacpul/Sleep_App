import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 5, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 5, kToday.day);

class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

LinkedHashMap<DateTime, List<Event>>kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getHashCode(DateTime key) {
return key.day * 1000000 + key.month * 10000 + key.year;
}

Map<DateTime, List<Event>> _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
  key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  value: (item) => List.generate(
      item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
  kToday: [
    Event('Today\'s Event 1'),
  ],
});