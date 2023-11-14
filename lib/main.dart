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
import 'main_screen.dart';
import 'splash_screen.dart';

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
  runApp(Loginpage());
  //runApp(Home());
}