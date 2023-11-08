import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';

import 'main.dart';
import 'notification_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
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

    );
  }
}