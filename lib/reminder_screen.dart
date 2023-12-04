import 'package:flutter/material.dart';
import 'package:units/log_screen.dart';
import 'package:units/resources_screen.dart';
import 'calendar_screen.dart';
import 'create_reminder.dart';
import 'main_screen.dart';
import 'notification_screen.dart';
import 'Icons/sleep_icons_icons.dart';

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
              icon: const Icon(SleepIcons.os_homewhitesvg),
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
              icon: const Icon(SleepIcons.os_log2whitesvg),
              tooltip: 'Log',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return LogScreen();
                }));
              },
            ),

            // Calendar Button
            IconButton(
              icon: const Icon(SleepIcons.os_calendarwhitesvg),
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
              icon: const Icon(SleepIcons.os_notif2svg),
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
              icon: const Icon(SleepIcons.os_remindsvg),
              tooltip: 'Reminders',
              onPressed: () {
                //returns nothing, already in reminders
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
                    fontWeight: FontWeight.bold, color: Colors.blue),
                textScaleFactor: 2,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
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
