import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String findMonth(String num) {
    String month = "";
    if (num == "1") {month = "January";}
    else if (num == "2") {month = "February";}
    else if (num == "3") {month = "March";}
    else if (num == "4") {month = "April";}
    else if (num == "5") {month = "May";}
    else if (num == "6") {month = "June";}
    else if (num == "7") {month = "July";}
    else if (num == "8") {month = "August";}
    else if (num == "9") {month = "September";}
    else if (num == "10") {month = "October";}
    else if (num == "11") {month = "November";}
    else if (num == "12") {month = "December";}
    return month;
  }

  String AMorPM(int num) {
    String timeOfDay;
    if(num == 1) timeOfDay = 'PM';
    else timeOfDay = 'AM';
    return timeOfDay;
  }
}

class MyTextStyle {
  static const TextStyle textStyleHeader = TextStyle(
    color: Colors.blueAccent,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyleBody = TextStyle(
    color: Colors.black,
    fontSize: 18,
  );
}

class _NotificationScreen extends State<NotificationScreen> {

  NotificationScreen notificationScreen = new NotificationScreen();

  late String currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<void> deleteNotifications() async {
    var dataRef = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Notifications');

    var snapshots = await dataRef.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

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

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_rounded),
        tooltip: "Clear Notifications",
        onPressed: () { deleteNotifications(); },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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

            //Reminder Button
            IconButton(
              icon: const Icon(Icons.add_alert_outlined),
              tooltip: 'Reminders',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return ReminderScreen();
                }));
              },
            ),
          ],
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(currentUser).collection("Notifications").snapshots(),
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
                      height: MediaQuery.of(context).size.height/10,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(notificationScreen.findMonth(document["Month"]), style: MyTextStyle.textStyleHeader),
                                  Text(", ", style: MyTextStyle.textStyleHeader),
                                  Text(document["Day"], style: MyTextStyle.textStyleHeader),
                                  Text("   ", style: MyTextStyle.textStyleHeader),
                                  Text(document["Hour"], style: MyTextStyle.textStyleHeader),
                                  Text(":", style: MyTextStyle.textStyleHeader),
                                  Text(document["Minute"], style: MyTextStyle.textStyleHeader),
                                  Text(notificationScreen.AMorPM(document["PmOrAm"]), style: MyTextStyle.textStyleHeader)]),
                            Text(document["Notes"], style: MyTextStyle.textStyleBody),
                            Divider(
                              color: Colors.yellow.shade600,
                              thickness: 1,
                            ),
                          ]
                      ),
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
