import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  late var logCollection = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Logs');
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;

  _functionCounter() async {
    List<Map<String, dynamic>> tempList = [];
    var logData = await logCollection.get();
    logData.docs.forEach((element) {
      tempList.add(element.data());
    });

    tempList.sort((a, b) {
      // Compare years
      var yearComparison = a['Year'].compareTo(b['Year']);
      if (yearComparison != 0) {
        return yearComparison;
      }

      // Compare months if years are equal
      var monthComparison = a['Month'].compareTo(b['Month']);
      if (monthComparison != 0) {
        return monthComparison;
      }

      // Compare days if both years and months are equal
      return a['Day'].compareTo(b['Day']);
    });

    setState(() {
      items = tempList;
      isLoaded = true;
    });

  }
  void deleteItem(int index) async {
    print(items[index]);
    var listData = await logCollection.get();
    listData.docs.forEach((element) {
      if(element.data().toString() == items[index].toString()) {
        logCollection.doc(element.id).delete();
      }
    });
    _functionCounter();
  }
  @override
  Widget build(BuildContext context) {
    _functionCounter();
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
            Expanded(
              child: isLoaded?_ListOfLogs:Text("** NO DATA **"),
              )
          ],
        ),
      ),
    );
  }

  late var _ListOfLogs = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
       return Card(
         color: Colors.yellow.shade800,
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            leading: const CircleAvatar(
            backgroundColor: Colors.blueAccent,
              child: Icon(Icons.list_alt_outlined)
            ),
            title: Row(
              children: [
                Text(items[index]["Month"].toString() + "-"),
                Text(items[index]["Day"].toString() + "-"),
                Text(items[index]["Year"].toString()),
                Text("  Hours Slept: " + items[index]["Hours_Slept"].toString())
              ],
            ),
            subtitle:
              Text("Sleep Quality: " + items[index]["Sleep_Quality"] +
              "  Notes: " + items[index]["Notes"]),
            trailing:
              Icon(Icons.delete),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        title: Text("Would You Like Delete This Log?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home())),
                              child: Text('NO')),
                          TextButton(
                              onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                              deleteItem(index);
                                },
                              child: Text('YES')),
                        ],
                      )
              );
            }
          )
        );
      }
  );

}

