import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/login.dart';
import 'api/firebase_api.dart'; // notifications
import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'calendar_screen.dart';
import 'notification_screen.dart';
import 'reminder_screen.dart';
import 'register_screen.dart';
import 'splash_screen.dart';
import 'resources_screen.dart';
import 'main.dart';

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
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), textScaleFactor: 3,)
                        ,),

                      // Button to bring you to the calculate page
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Log', style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return SplashScreen();
                          }));
                        },
                      ),

                      //padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      // Button to bring you to your calendar page
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Calendar', style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            //return SplashScreen();
                            return new CalendarScreen();
                          }));
                        },
                      ),

                      //padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      // Button to bring you to your notifications page
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Your Notifications',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return NotificationScreen();
                          }));
                        },
                      ),

                      //padding
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      // Button to bring you to your reminders page
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Reminders',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ReminderScreen();
                          }));
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      ),

                      // Button to bring you to your Resources page
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent
                        ),
                        child: Text('Other Resources',  style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
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