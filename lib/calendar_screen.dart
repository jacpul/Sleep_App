import 'dart:collection';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:units/resources_screen.dart';
import 'Icons/sleep_icons_icons.dart';
import 'splash_screen.dart';
import 'main_screen.dart';
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
  late ValueNotifier<List<Event>> _selectedEvents;
  late String currentUser;
  late CollectionReference logCollection;
  LinkedHashMap<DateTime, List<Event>>? _eventStorage;
  bool _initialized = false; // Flag to track initialization

  @override
  void initState() {
    super.initState();

    _selectedEvents = ValueNotifier([]);
    _selectedDay = _focusedDay;
    initialize();
  }

  /**
   * async initialize function for firestore communication and parsing
   */
  void initialize() async {
    currentUser = FirebaseAuth.instance.currentUser!.uid; // gets the current user
    logCollection = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Logs'); // gets an instance of the logs documents from the current user
    var logData = await logCollection.get(); // puts log docs into the logData
    debugPrint("currentuser: $currentUser, log: ${logCollection.id}, event: ${_eventStorage?.length}");
    _eventStorage = await populateLogList(logData); // calls populateLogList from calendar_model and waits for it to return
    //sets state once everything is finished, to update the app
    setState(() {
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      _initialized = true; // Set the initialization flag
    });
  }

  /**
   * gets all events stored on a day
   * @param DateTime day
   * @return A list of events for DateTime
   */
  List<Event> _getEventsForDay(DateTime day) {
    if (_initialized) {
      return _eventStorage?[day] ?? [];
    } else {
      return [];
    }
  }

  /**
   * called by the table calendar, sets the selected and focused day
   * @param DateTime selectedDay
   * @param DateTime focusedDay
   */
  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  /**
   * Deletes a selected Event and reloads the calendar
   * @param selected DateTime day
   * @param index of the Event in the List<Event>
   */
  void deleteEvent(DateTime day, int index) async {
    var listData = await logCollection.get();
    if (_eventStorage!.containsKey(day)) {
      List<Event>? events = _eventStorage?[day];
      listData.docs.forEach((element) {
        if(element.id.toString() == events?[index].toString()) {
          logCollection.doc(element.id).delete();
        }
      });
    }
    setState(() {
      _initialized = false;
      initialize();
    });
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
                icon:const Icon(SleepIcons.os_homewhitesvg),
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
                icon: const Icon(SleepIcons.os_log2whitesvg),
                tooltip: 'Log',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return SplashScreen();
                  }));
                },
              ),

              // Calendar Button
              IconButton(
                icon: const Icon(SleepIcons.os_calendarwhitesvg),
                tooltip: 'Calendar',
                onPressed: () {
                  // returns nothing, already in calendar
                },
              ),

              //Notifications Button
              IconButton(
                icon: const Icon(SleepIcons.os_notif2svg),
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
                icon: const Icon(SleepIcons.os_remindsvg),
                tooltip: 'Reminders',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return ReminderScreen();
                  }));
                },
              ),

              //Resources Button
              IconButton(
                icon: const Icon(SleepIcons.os_resourceswhitesvg),
                tooltip: 'Resources',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return ResourcesScreen();
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
              ): CircularProgressIndicator(),
              const SizedBox(height: 7.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (_selectedEvents.value == null) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Card(
                              color: Colors.yellow.shade800,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(Icons.list_alt_outlined),
                                ),
                                title: Row(
                                  children: [

                                    Text('${value[index].month}-${value[index].day}-${value[index].year}  Hours Slept: ${value[index].hours}'
                                    )
                                  ],
                                ),
                                subtitle:
                                Text('Sleep Quality: ${value[index].quality}  Notes: ${value[index].notes}'
                                ),
                                trailing:
                                Icon(Icons.delete),onTap: () {
                                showDialog(context: context, builder: (context) =>
                                    AlertDialog(
                                      title: Text("Would You Like Delete This Log?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text('NO')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              deleteEvent(_selectedDay!, index);
                                            },
                                            child: Text('YES')),
                                      ],
                                    ));
                              },
                              )
                          );
                        },
                      );}},
                ),
              ),
            ]
        )
    );
  }
}
