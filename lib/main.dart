import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:units/login.dart';
import 'main_screen.dart';
import 'api/firebase_api.dart'; // notifications

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
  //runApp(Loginpage());
  runApp(Home());
}

