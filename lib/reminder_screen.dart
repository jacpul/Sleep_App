//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/log_screen.dart';
import 'package:units/resources_screen.dart';
import 'calendar_screen.dart';
import 'create_reminder.dart';
import 'main_screen.dart';
import 'splash_screen.dart';
import 'notification_screen.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreen createState() => _ReminderScreen();
}

class _ReminderScreen extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Reminders'),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            // appbar functions
            //Home button
            IconButton(
              icon: const Icon(Icons.add_home_outlined),
              tooltip: "Home",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
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
                  return LogScreen();
                }));
              },
            ),

            // Calendar Button
            IconButton(
              icon: const Icon(Icons.calendar_month),
              tooltip: 'Calendar',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarScreen();
                }));
              },
            ),

            //Notifications Button
            IconButton(
              icon: const Icon(Icons.new_releases_outlined),
              tooltip: 'Notifications',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return NotificationScreen();
                }));
              },
            ),

            //Reminder Button
            IconButton(
              icon: const Icon(Icons.add_alert_outlined),
              tooltip: 'Reminders',
              onPressed: () {
                //returns nothing, already in reminders
              },
            ),

            //Resources Button
            IconButton(
              icon: const Icon(Icons.book_online_outlined),
              tooltip: 'Resources',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return ResourcesScreen();
                }));
              },
            )
      ]),

      backgroundColor: Colors.yellow.shade800,

      body: Container(
        alignment: Alignment.center,
        color: Colors.yellowAccent.shade100,
        padding: const EdgeInsets.all(32),
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
              child: Text(
                "Reminders",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                textScaleFactor: 2,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent,
                padding: EdgeInsets.all(10.0),
              ),
              child: Text('New Reminder'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CreateReminder();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
