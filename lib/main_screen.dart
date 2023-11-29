import 'package:flutter/material.dart';
import 'package:units/login.dart';
import 'resources_screen.dart';
import 'calendar_screen.dart';
import 'notification_screen.dart';
import 'reminder_screen.dart';
import 'log_screen.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                  title: Text("Omega Dreams"),
                  centerTitle: true,
                  backgroundColor: Colors.deepOrange,
                  actions: [

                    /// Icon button to log out and bring user back to the login screen
                    IconButton(
                        icon: const Icon(Icons.logout_outlined),
                        tooltip: 'Logout',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return Loginpage();
                          }));
                        }
                    )
                  ]
              ),

              /// Container used for design and input of our specific background image
              body: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sun.jpg'),
                      fit: BoxFit.cover,
                    ),

                  ),

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 3,)
                        ,),


                      /**
                       * Button that on pressed opens up the Log screen
                       */
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Log', style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return LogScreen();
                          }));
                        },
                      ),

                      /// padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      /**
                       * Button that when pressed pens up the calendar screen
                       */
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Calendar', style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            //return SplashScreen();
                            return new CalendarScreen();
                          }));
                        },
                      ),

                      /// padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      /**
                       * Button that on pressed brings you to the notification page
                       */
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Notifications',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return NotificationScreen();
                          }));
                        },
                      ),

                      /// padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      /**
                       * Button that when pressed opens the reminders screen
                       */
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Reminders',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ReminderScreen();
                          }));
                        },
                      ),

                      /// padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      /**
                       * Button that when pressed opens resources page
                       */
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Other Resources',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ResourcesScreen();
                          }));
                        },
                      ),
                    ],
                  )
              ),
            )
        )
    );
  }
}