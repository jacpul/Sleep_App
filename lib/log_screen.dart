import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:units/reminder_screen.dart';
import 'package:units/resources_screen.dart';
import 'calendar_screen.dart';
import 'main_screen.dart';
import 'splash_screen.dart';
import 'notification_screen.dart';
import 'Icons/sleep_icons_icons.dart';


class LogScreen extends StatefulWidget {

  @override
  _LogScreen createState() => _LogScreen();
}

class _LogScreen extends State<LogScreen> {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  late var logCollection = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Logs');
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;
  ///Updates the list of logs while sorting them by date
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
  ///Deletes any log the user wishes
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
          backgroundColor: Colors.deepOrangeAccent,
          actions: [ // appbar functions

            /// Button that opens up home screen
            IconButton(
              icon:const Icon(SleepIcons.os_homewhitesvg),
              tooltip: "Home",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Home();
                    }));
              }),

            /// Button that opens up log screen
            /// In this case has no actions
            IconButton(
              icon: const Icon(SleepIcons.os_log2whitesvg),
               tooltip: 'Log',
               onPressed: () {
                  // do nothing, already at page
              }),

            /// Button that opens up calendar screen
            IconButton(
              icon: const Icon(SleepIcons.os_calendarwhitesvg),
              tooltip: 'Calendar',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarScreen();
                }));
              }),

            /// Button that opens up notification screen
            IconButton(
              icon: const Icon(SleepIcons.os_notif2svg),
              tooltip: 'Notifications',
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return NotificationScreen();
                }));
              }),

           /// Button that opens up reminders screen
           IconButton(
               icon: const Icon(SleepIcons.os_remindsvg),
               tooltip: 'Reminders',
               onPressed: () {
                 Navigator.of(context).push(
                     MaterialPageRoute(builder: (BuildContext context) {
                       return ReminderScreen();
                     }));
                }),

            /// Resources Button
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


      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Logs",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 2,)
              ),

            /// Button that on pressed Enters a new log
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

            /// Lists off logs
            Expanded(
              child: isLoaded?_ListOfLogs:Text("** NO DATA **"),
              )
          ],
        ),
      ),
    );
  }

  /**
   * Function used to list logs entered
   */
  late var _ListOfLogs = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
                tileColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.white, // Set the color of the border here
                    width: 3.5,
                  ),
                ),
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(SleepIcons.os_log2whitesvg,
                      color: Colors.white),
                ),
            title: Row(
              children: [
                Text(items[index]["Month"].toString() + "-",
                    style: TextStyle(color: Colors.white)
                ),
                Text(items[index]["Day"].toString() + "-",
                    style: TextStyle(color: Colors.white)
                ),
                Text(items[index]["Year"].toString(),
                    style: TextStyle(color: Colors.white)
                ),
                Text("  Hours Slept: " + items[index]["Hours_Slept"].toString(),
                    style: TextStyle(color: Colors.white)
                )
              ],
            ),
            subtitle:
              Text("Sleep Quality: " + items[index]["Sleep_Quality"] +
              "  Notes: " + items[index]["Notes"],
                  style: TextStyle(color: Colors.white)
              ),
            trailing:
              Icon(Icons.delete,
                  color: Colors.white),
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

