import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../notification_screen.dart';
import '../main.dart';
import 'package:timezone/standalone.dart' as tz; // timed notifications

final location = tz.getLocation('America/Chicago');
tz.TZDateTime currentTime = tz.TZDateTime.now(location);

int convertHour(pmOrAm, hour) {
  int newHour = int.parse(hour);

  if (pmOrAm == 1 && newHour != 12) {
    newHour += 12;
  } else if (pmOrAm == 0 && newHour == 12) {
    newHour = 0;
  }

  return newHour;
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/os_iconsleep');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        if (payload != null && payload.isNotEmpty) {
          try {
            final message = RemoteMessage.fromMap(jsonDecode(payload!));
            handleMessage(message);
          }
          catch (e) {
            print("Error processing JSON: $e");
          }
        }
        else {
          navigatorKey.currentState?.pushNamed(
            NotificationScreen.route,
          );
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/os_iconsleep',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });

  }

  Future scheduleNotification(int pmOrAm, String month, String day, String hour, String minute, String notes) async {
    var scheduledNotificationDateTime = tz.TZDateTime(
      location,
      currentTime.year,
      int.parse(month),
      int.parse(day),
      convertHour(pmOrAm, hour),
      int.parse(minute),
    );

    await _localNotifications.zonedSchedule(
        0,
        'Reminder Message',
        notes,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          location,
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/os_iconsleep',
          ),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true
    );

  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token:  $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }

}