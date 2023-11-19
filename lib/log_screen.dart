import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';

import 'calendar_screen.dart';
import 'create_reminder.dart';
import 'main_screen.dart';
import 'splash_screen.dart';
import 'main.dart';
import 'notification_screen.dart';


class LogScreen extends StatefulWidget {

  @override
  _LogScreen createState() => _LogScreen();
}

class _LogScreen extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade800,
        appBar: AppBar(
          //title: Text('Reminders'),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [ // appbar functions
            //Home button
            IconButton(
              icon:const Icon(Icons.add_home_outlined),
              tooltip: "Home",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Home();
                    }));
              }),
            //log button
            IconButton(
              icon: const Icon(Icons.mode_edit_outlined),
               tooltip: 'Log',
               onPressed: () {
                  // do nothing, already at page
              }),

            // Calendar Button
            IconButton(
              icon: const Icon(Icons.calendar_month),
              tooltip: 'Calendar',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarScreen();
                }));
              }),

            //Notifications Button
            IconButton(
              icon: const Icon(Icons.new_releases_outlined),
              tooltip: 'Notifications',
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return NotificationScreen();
                }));
              }),
            //Reminder Button
           IconButton(
               icon: const Icon(Icons.add_alert_outlined),
               tooltip: 'Reminders',
               onPressed: () {
                 Navigator.of(context).push(
                     MaterialPageRoute(builder: (BuildContext context) {
                       return ReminderScreen();
                     }));
                }),
          ]),


      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Logs",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 2,)
              ),
             //New Log Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.all(10.0),
              ),
              child: Text('Enter New Log'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
                }));
              },
            ),
             //Log List
            SizedBox(
              height: 500,
              child: _ListOfLogs,
              )

          ],
        ),
      ),
    );
  }

  var _ListOfLogs = ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
            leading: const CircleAvatar(
            backgroundColor: Colors.blueAccent,
              child: Icon(Icons.list_alt_outlined)
            ),
            title: Row(
              children: [
                Text("Date"),
                Text("Wake Time"),
                Text("Sleep Time")
              ],
            ),
            subtitle:
              Text("Hopefully this will extend downwards, so that it is more visually appleasing")
          )
        );
      }
  );


}

