import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';

import 'calendar_screen.dart';
import 'main.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [

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
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
                {
                  return CalendarScreen();
                }));
              },
            ),

            //Notifications Button
            IconButton(
              icon: const Icon(Icons.new_releases_outlined),
              tooltip: 'Notifications',
              onPressed: ()  {
                  // returns nothing, already in notifications
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