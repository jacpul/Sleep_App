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
        backgroundColor: Colors.amber,

        body: Column(
            children: [
              _initialized ? TableCalendar<Event>(
                headerStyle: const HeaderStyle(
                  titleTextStyle:
                  TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.only()),
                  formatButtonTextStyle:
                  TextStyle(color: Colors.deepOrangeAccent, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.blueAccent)
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.blue),
                  weekNumberTextStyle: TextStyle(color: Colors.black),
                  outsideTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: Colors.amberAccent,
                    shape: BoxShape.circle,
                  ),
                ),

                firstDay: eventFirstDay,
                lastDay: eventLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,
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
                              child: ListTile(
                                tileColor: Colors.deepOrangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.white, // Set the color of the border here
                                    width: 3.5,
                                  ),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(SleepIcons.os_log2whitesvg,
                                      color: Colors.white),
                                ),
                                title: Row(
                                  children: [
                                    Text('${value[index].month}-${value[index].day}-${value[index].year}  Hours Slept: ${value[index].hours}',
                                      style: TextStyle(color: Colors.white)
                                    )
                                  ],
                                ),
                                subtitle:
                                Text('Sleep Quality: ${value[index].quality}  Notes: ${value[index].notes}',
                                    style: TextStyle(color: Colors.white)
                              ),
                                trailing:
                                Icon(Icons.delete,
                                    color: Colors.white),
                                onTap: () {
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
