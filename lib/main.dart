import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:units/login.dart';
import 'api/firebase_api.dart';
import 'notification_screen.dart'; // notifications


// Used for navigating between notifications
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Coding-Omega',
    options: FirebaseOptions(
      apiKey: 'AIzaSyA3h5VlDHhZjS5i9KN3eleCTBkw-1yjqu0',
      projectId: 'codingomega-a0d98',
      appId: '1:497916766002:android:b06f1a063ef1e4c187592b',
      messagingSenderId: '497916766002',
    ),
  );
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

// Run MyApp so we are able to use the navigator everywhere in the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        NotificationScreen.route: (context) => NotificationScreen()
      },
      home: Loginpage(),
    );
  }
}
