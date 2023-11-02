import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_reminder.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreen createState() => _ReminderScreen();
}

class _ReminderScreen extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      backgroundColor: Colors.white,

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),

        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
              child: Text("Reminders",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 2,)
              ,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  padding: EdgeInsets.all(10.0),

              ),
              child: Text('New Reminder'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
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