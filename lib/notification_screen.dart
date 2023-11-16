import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'calendar_screen.dart';
import 'splash_screen.dart';
import 'main_screen.dart';

class NotificationScreen extends StatefulWidget {
  static const route = '/notification_screen';

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {

  late String currentUser = FirebaseAuth.instance.currentUser!.uid;

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(currentUser).collection("Reminders").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                  child: Text("No Data Available")
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document){
                return Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width /1.2,
                      height: MediaQuery.of(context).size.height/5,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Text("Notification From" + document["Day"], style: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 22,
                            )),
                            Text(document["note"], style: const TextStyle(fontSize: 18)),
                            Divider(
                              color: Colors.blueAccent,
                              thickness: 3,
                            )
                          ]
                      )
                  ),
                );
              }).toList(),
            );
          }
      ),
      backgroundColor: Colors.yellow.shade800,
    );
  }

}
