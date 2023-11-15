import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'calendar_screen.dart';
import 'splash_screen.dart';
import 'main_screen.dart';
import 'main.dart';

class NotificationScreen extends StatefulWidget {
  static const route = '/notification_screen';

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationMessage;
    String notificationTitle = "";
    String notificationBody = "";
    String notificationData = "";

    if (ModalRoute.of(context)!.settings.arguments != null) {
      notificationMessage = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
      notificationTitle = '${notificationMessage.notification?.title}';
      notificationBody = '${notificationMessage.notification?.body}';
      notificationData = '${notificationMessage.data}';
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [ //appbar functions

            //Home button
            IconButton(
              icon:const Icon(Icons.add_home_outlined),
              tooltip: "Home",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Builder(
                        builder: (context) => Home(),
                      ),
                  ),
                );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(notificationTitle),
            Text(notificationBody),
            Text(notificationData),
          ],
        ),
      ),
      backgroundColor: Colors.yellow.shade800,
    );
  }

}
