import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:units/api/firebase_api.dart';
import 'splash_screen.dart';
import 'calendar_screen.dart';
import 'notification_screen.dart';
import 'package:timezone/standalone.dart' as tz; // timed notifications

// Timezone variables so we can use TZDateTime
final location = tz.getLocation('America/Chicago');
tz.TZDateTime currentTime = tz.TZDateTime.now(location);

// Used so we can access the current user that is logged in
late String currentUser;

class CreateReminder extends StatefulWidget {
  @override
  _CreateReminder createState() => _CreateReminder();
}

class _CreateReminder extends State<CreateReminder> {
  /**
   * Disposes the text editing controllers used in the reminder screen
   */
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _reminderHourController.dispose();
    _reminderMinuteController.dispose();
    _reminderMonthController.dispose();
    _reminderDayController.dispose();
    _reminderNotesController.dispose();

    super.dispose();
  }

  /**
   * Helper function used to decide which alert dialog to show when a user
   * enters a reminder date
   * @param dialogType a string if the dialog has valid input or not
   * @param context the context from where we came from
   * @post an alert dialog will appear on the screen
   */
  void _showDialog(BuildContext context, String dialogType) {
    if (dialogType == 'validInput') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Reminder Submitted"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
          contentPadding: const EdgeInsets.all(20.0),
          content: const Text("The reminder has been added"),
        ),
      );
    }
    else if (dialogType == 'invalidInput') {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Reminder Not Submitted"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: const Text("Please enter a valid date in the future."),
            ),
      );
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Reminder Not Submitted"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
          contentPadding: const EdgeInsets.all(20.0),
          content: const Text("Please enter information into all fields."),
        ),
      );
    }

  }

  /**
   * Helper function used to validate the date that the user entered for the reminders
   * @param pmOrAm, 0 = am | 1 = pm
   * @param hour, hour of the date
   * @param minute, minute of the date
   * @param month, month of the date
   * @param day, day of the date
   * @return false if the date is not in the future | true otherwise
   */
  bool validateDate(int pmOrAm, String month, String day, String hour, String minute) {
    var scheduledNotificationDateTime = tz.TZDateTime(
      location,
      currentTime.year,
      int.parse(month),
      int.parse(day),
      convertHour(pmOrAm, hour),
      int.parse(minute),
    );

    if (scheduledNotificationDateTime.difference(currentTime) < Duration(seconds: 5)) {
      return false;
    }

    return true;

  }

  // 0 = am | 1 = pm
  int amOrPmSelected = 0;

  final _reminderHourController = TextEditingController();
  final _reminderMinuteController = TextEditingController();
  final _reminderMonthController = TextEditingController();
  final _reminderDayController = TextEditingController();
  final _reminderNotesController = TextEditingController();

  String _reminderHour = "";
  String _reminderMinute = "";
  String _reminderMonth = "";
  String _reminderDay = "";
  String _reminderNotes = "";
  int errorValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('New Reminder'),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            // appbar functions
            //log button
            IconButton(
              icon: const Icon(Icons.mode_edit_outlined),
              tooltip: 'Log',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
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
            //Calendar Button

            //Reminder Button
            IconButton(
              icon: const Icon(Icons.add_alert_outlined),
              tooltip: 'Reminders',
              onPressed: () {
                //returns nothing, already in reminders
              },
            )
          ]),
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
                    activeColor: Colors.deepOrangeAccent,
                    value: 0,
                    groupValue: amOrPmSelected,
                    onChanged: (value) {
                      setState(() {
                        amOrPmSelected = value!;
                      });
                    }),
                Text(
                  'AM',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                Radio<int>(
                    activeColor: Colors.deepOrangeAccent,
                    value: 1,
                    groupValue: amOrPmSelected,
                    onChanged: (value) {
                      setState(() {
                        amOrPmSelected = value!;
                      });
                    }),
                Text(
                  'PM',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ],
            ),
            TextFormField(
              controller: _reminderHourController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.length == 0 ||
                    (double.parse(value) < 1 || double.parse(value) > 12)) {
                  return ('Hour between 1 - 12');
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _reminderHour = value;
                });
              },
              decoration: InputDecoration(
                hintText: "e.g.) 7",
                labelText: "Hour",
                icon: Icon(Icons.access_time_rounded),
                fillColor: Colors.white,
              ),
            ),
            TextFormField(
              controller: _reminderMinuteController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.length == 0 ||
                    (double.parse(value) < 0 || double.parse(value) > 59)) {
                  return ('Minute between 0 - 59');
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _reminderMinute = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'e.g.) 40',
                  labelText: 'Minute',
                  icon: Icon(Icons.access_time_rounded),
                  fillColor: Colors.white),
            ),
            TextFormField(
              controller: _reminderMonthController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.length == 0 ||
                    (double.parse(value) < 1 || double.parse(value) > 12)) {
                  errorValue = 1;
                  return ('Month between 1 - 12');
                }
                errorValue = 0;
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _reminderMonth = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'e.g.) 11',
                labelText: 'Month',
                icon: Icon(Icons.date_range),
              ),
            ),
            TextFormField(
              controller: _reminderDayController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.length == 0 ||
                    (double.parse(value) < 1 || double.parse(value) > 31)) {
                  errorValue = 1;
                  return ('Day between 1 - 31');
                }
                errorValue = 0;
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _reminderDay = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'e.g.) 27',
                labelText: 'Day',
                icon: Icon(Icons.date_range),
              ),
            ),
            TextFormField(
              controller: _reminderNotesController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLength: 20,
              onChanged: (value) {
                setState(() {
                  _reminderNotes = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Message Here',
                labelText: 'Reminder Message',
                icon: Icon(Icons.book_outlined),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: EdgeInsets.all(10.0),
              ),
              onPressed: () {
                createReminderNotification(
                    amOrPmSelected,
                    _reminderHour,
                    _reminderMinute,
                    _reminderMonth,
                    _reminderDay,
                    _reminderNotes);
              },
              child: Text('Submit Reminder'),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  /**
   * Adds a reminder notification to the app, from the current user, this will add the info
   * to the database and also call the function scheduleNotification, which will schedule a local
   * push notification to be sent to the user
   * @pre Date entered is a valid date in the future
   * @post User data is entered to the database, scheduleNotification is called
   * @param pmOrAm, 0 = am | 1 = pm
   * @param hour, hour of the date
   * @param minute, minute of the date
   * @param month, month of the date
   * @param day, day of the date
   * @param notes, notes for the reminder message to send the user through the notification
   */
  void createReminderNotification(int pmOrAm, String hour, String minute,
      String month, String day, String notes) {
    if (hour == "" || minute == "" || month == "" || day == "" || notes == "") {
        _showDialog(context, 'noInput');
        return;
    }

    if(validateDate(pmOrAm, month, day, hour, minute) == false) {
      _showDialog(context, 'invalidInput');
      return;
    }

    currentUser = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference dataRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .collection('Notifications');

    dataRef.add({
      'PmOrAm': pmOrAm,
      'Hour': hour,
      'Minute': minute,
      'Month': month,
      'Day': day,
      'Notes': notes,
    });

    FirebaseApi().scheduleNotification(pmOrAm, month, day, hour, minute, notes);

    _showDialog(context, 'validInput');
  }
}
