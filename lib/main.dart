import 'package:flutter/material.dart';

import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Omega Dreams", style: const TextStyle(color: Colors.blueAccent,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 35)),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
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
                  padding: EdgeInsets.only(top: 20.0, bottom: 60.0),
                  child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold,
                                                                      color: Colors.yellow),
                                                                      textScaleFactor: 3,)
                  ,),

                // Button to bring you to the calculate page
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 50.0),
                      primary: Colors.blueAccent,
                  ),
                  child: Text('Log Your Sleep', style: const TextStyle(fontWeight: FontWeight.bold,
                                                                        fontSize: 18,
                                                                        color: Colors.orange),
                                                                        textAlign: TextAlign.center),

                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return SplashScreen();
                    }));
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),

                // Button to bring you to your calendar page
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 50.0),
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

                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                ),

                // Button to bring you to your notifications page
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 50.0),
                      primary: Colors.blueAccent
                  ),
                  child: Text('Your Notifications', style: const TextStyle(fontWeight: FontWeight.bold,
                                                                            fontSize: 18,
                                                                            color: Colors.orange),
                                                                            textAlign: TextAlign.center),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return NotificationScreen();
                    }));
                  },
                )
              ],
            )
          ),
        )
      )
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new HomePage(new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}

// Call a new screen that brings user to the Calendar screen
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar', style: const TextStyle(color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 35)),
      centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent
      ),
          backgroundColor: Colors.yellow.shade800,
    );
  }
}


// calls new screen that brings user to the notification screen
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications', style: const TextStyle(color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 35)),
      centerTitle: true,
      backgroundColor: Colors.deepOrangeAccent
      ),
      backgroundColor: Colors.yellow.shade800,
    );
  }
}


