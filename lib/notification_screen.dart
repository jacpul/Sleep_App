import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'package:units/resources_screen.dart';
import 'calendar_screen.dart';
import 'splash_screen.dart';
import 'main_screen.dart';
import 'Icons/sleep_icons_icons.dart';

class NotificationScreen extends StatefulWidget {
  static const route = '/notification_screen';

  @override
  _NotificationScreen createState() => _NotificationScreen();

  /**
   *  Helper function used to display Month rather than a number.
   *  Uses database input constraints to verify number is between 1 and 12.
   *
   *  Inputs: a string which is 1-12
   *  Output: a string month corresponding to the month number.
   */
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

  /**
   * Helper function to display AM or PM rather than a number
   * Uses database input constraints to verify num is either 1 or 0
   *
   * Input; number that is either 1 for PM, or 0 for AM
   * Output: Outputs string corresponding to the time
   */
  String AMorPM(int num) {
    String timeOfDay;
    if(num == 1) timeOfDay = 'PM';
    else timeOfDay = 'AM';
    return timeOfDay;
  }
}

/// TextStyle class used to define header and body text styles
/// Used for display in build function
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
  /// Creates instance of notification screen for access to helper functions
  NotificationScreen notificationScreen = new NotificationScreen();

  /// Validates what user is logged in for access to their specific database info
  late String currentUser = FirebaseAuth.instance.currentUser!.uid;

  /**
   * Helper function to delete all notifications for a desired user
   */
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

      /**
       * Button that clears all notifications for user
       * On pressed, calls deleteNotification() function
       */
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_rounded),
        tooltip: "Clear Notifications",
        onPressed: () { deleteNotifications(); },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          actions: [ //appbar functions

            /**
             * Appbar button that opens the home screen when pressed
             */
            IconButton(
              icon:const Icon(SleepIcons.os_homewhitesvg),
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

            /**
             * Appbar button that opens the log screen when pressed
             */
            IconButton(
              icon: const Icon(SleepIcons.os_log2whitesvg),
              tooltip: 'Log',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
                }));
              },
            ),

            /**
             * Appbar button that opens the calendar screen when pressed
             */
            IconButton(
              icon: const Icon(SleepIcons.os_calendarwhitesvg),
              tooltip: 'Calendar',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
                {
                  return CalendarScreen();
                }));
              },
            ),

            /**
             * Appbar button that opens notification screen when pressed
             * Has not action on this page
             */
            IconButton(
              icon: const Icon(SleepIcons.os_notif2svg),
              tooltip: 'Notifications',
              onPressed: ()  {
                  // returns nothing, already in notifications
              },
            ),

            /**
             * Appbar button that opens the reminders screen when pressed
             */
            IconButton(
              icon: const Icon(SleepIcons.os_remindsvg),
              tooltip: 'Reminders',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return ReminderScreen();
                }));
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
          ],
      ),

      /**
       * Body for build, displays all notifications that have been added by the user
       * Will be empty if no notifications have been added through the reminders page
       */
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
