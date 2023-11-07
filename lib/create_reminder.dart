import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'notification_screen.dart';
import 'main.dart';

class CreateReminder extends StatefulWidget {
  @override
  _CreateReminder createState() => _CreateReminder();
}

class _CreateReminder extends State<CreateReminder> {
  int currentSelectedTime = 0;

  var _ReminderHourController = TextEditingController();
  var _ReminderMinuteController = TextEditingController();
  var _ReminderNotesController = TextEditingController();
  String _ReminderMinute = "0.0";
  String _ReminderHour = "0.0";
  String _ReminderNotes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Reminder'),
        backgroundColor: Colors.deepOrangeAccent,
          actions: [ // appbar functions

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
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarScreen();
                }));
              },
            ),

            //Notifications Button
            IconButton(
              icon: const Icon(Icons.new_releases_outlined),
              tooltip: 'Notifications',
              onPressed: ()  {
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
                //returns nothing, already in reminders
              },
            )
          ]
      ),

      backgroundColor: Colors.yellow.shade800,

      body: Container(
        color: Colors.yellowAccent.shade100,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio<int>(
                      activeColor: Colors.blueAccent.shade400,
                      value: 0, groupValue: currentSelectedTime, onChanged: (value) {
                        setState(() {
                          currentSelectedTime = value!;
                        });
                      }),
                  Text(
                    'AM',
                    style: TextStyle(color: Colors.blueAccent.shade400),
                  ),
                  Radio<int>(
                      activeColor: Colors.blueAccent.shade400,
                      value: 1, groupValue: currentSelectedTime, onChanged: (value) {
                        setState(() {
                          currentSelectedTime = value!;
                        });
                      }),
                  Text(
                    'PM',
                    style: TextStyle(color: Colors.blueAccent.shade400),
                  ),
                ],
              ),
              TextFormField(
                controller: _ReminderHourController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
                    return ('Hour between 1 - 12');
                  }
                  },
                onSaved: (value) {
                  _ReminderHour = value!;
                  },
                decoration: InputDecoration(
                  hintText: "e.g.) 7",
                  labelText: "Hour",
                  icon: Icon(Icons.access_time_rounded),
                  fillColor: Colors.white,
                ),
              ),
              TextFormField(
                controller: _ReminderMinuteController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
                    return ('Minute between 0 - 59');
                  }
                  },
                onSaved: (value) {
                  _ReminderMinute = value!;
                  },
                decoration: InputDecoration(
                    hintText: 'e.g.) 40',
                    labelText: 'Minute',
                    icon: Icon(Icons.access_time_rounded),
                    fillColor: Colors.white
                ),
              ),
              TextFormField(
                controller: _ReminderNotesController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 20,
                onSaved: (value){
                  _ReminderNotes = value!;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Message Here',
                  labelText: 'Reminder Message',
                  icon: Icon(Icons.book_outlined),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
      ),
    );
  }

}