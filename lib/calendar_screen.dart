import 'dart:collection';
import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'splash_screen.dart';
import 'main_screen.dart';

import 'main.dart';
import 'notification_screen.dart';
import 'calendar_model.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  late String currentUser;
  late CollectionReference logCollection;
  LinkedHashMap<DateTime, List<Event>>? _eventStorage;
  bool _initialized = false; // Flag to track initialization

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    initialize();
  }


  void initialize() async {
    currentUser = FirebaseAuth.instance.currentUser!.uid;
    logCollection = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Logs');
    var logData = await logCollection.get();
    debugPrint("currentuser: $currentUser, log: ${logCollection.id}, event: ${_eventStorage?.length}");
    _eventStorage = await populateLogList(logData);
    _selectedEvents = ValueNotifier(await _getEventsForDay(_selectedDay!));
    setState(() {
      _initialized = true; // Set the initialization flag
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    if (_initialized) {
      return _eventStorage?[day] ?? [];
    } else {
      return [];
    }
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay) as List<Event>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text("Calendar"),
            backgroundColor: Colors.deepOrangeAccent,
            actions: [ //appbar functions

              //Home button
              IconButton(
                icon:const Icon(Icons.add_home_outlined),
                tooltip: "Home",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Home();
                      }));
                },
              ),

              //log button
              IconButton(
                icon: const Icon(Icons.mode_edit_outlined),
                tooltip: 'Log',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return SplashScreen();
                  }));
                },
              ),

              // Calendar Button
              IconButton(
                icon: const Icon(Icons.calendar_month),
                tooltip: 'Calendar',
                onPressed: () {
                  // returns nothing, already in calendar
                },
              ),

              //Notifications Button
              IconButton(
                icon: const Icon(Icons.new_releases_outlined),
                tooltip: 'Notifications',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return NotificationScreen();
                  }));
                },
              ),

              //Calendar Button

              //Reminder Button
              IconButton(
                icon: const Icon(Icons.add_alert_outlined),
                tooltip: 'Reminders',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return ReminderScreen();
                  }));
                },
              )
            ]
        ),
        backgroundColor: Colors.yellow.shade800,

        body: Column(
            children: [
              _initialized ? TableCalendar<Event>(
                firstDay: eventFirstDay,
                lastDay: eventLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ): Text("Populating Data..."),
              const SizedBox(height: 7.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ]
        )
    );
  }
}
