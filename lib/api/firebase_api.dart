import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../notification_screen.dart';
import '../main.dart';
import 'package:timezone/standalone.dart' as tz; // timed notifications

// Timezone variables so we can use TZDateTime
final location = tz.getLocation('America/Chicago');
tz.TZDateTime currentTime = tz.TZDateTime.now(location);

/**
 * Helper function that converts a given hour and pm/am into a 24 hour format
 * @param pmOrAm, 0 = am | 1 = pm
 * @param hour, the hour of the date in 12 hour format
 * @return int, the newly formatted hour in a 24 hour format
 */
int convertHour(pmOrAm, hour) {
  int newHour = int.parse(hour);

  if (pmOrAm == 1 && newHour != 12) {
    newHour += 12;
  } else if (pmOrAm == 0 && newHour == 12) {
    newHour = 0;
  }

  return newHour;
}

/**
 * Handles messages when the app is opened but in the background of the users phone
 */
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  // Used for access to the firebase database
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Creates an Android Notification Channel for the app to use and send notifications
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  // _localNotifications is used as FlutterLocalNotificationsPlugin()
  final _localNotifications = FlutterLocalNotificationsPlugin();

  /**
   * Handles a message sent by the notifications
   * @pre message is not empty
   * @post the user is sent to the notification screen
   */
  void handleMessage(RemoteMessage? message) {
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  /**
   * This sets up local push notifications
   */
  Future initLocalNotifications() async {
    // Settings for the different phone types
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/os_iconsleep');
    const settings = InitializationSettings(android: android, iOS: iOS);

    // initialize the local notifications using the settings provided
    await _localNotifications.initialize(
      settings,
      // Process what happens when the user clicks the local notification
      onSelectNotification: (payload) async {
        if (payload != null && payload.isNotEmpty) {
          try {
            // This handles firebase cloud notification messages
            final message = RemoteMessage.fromMap(jsonDecode(payload));
            handleMessage(message);
          }
          catch (e) {
            print("Error processing JSON: $e");
          }
        }
        else {
          // else we go to the notification screen when the notification is clicked
          navigatorKey.currentState?.pushNamed(
            NotificationScreen.route,
          );
        }
      },
    );

    // Create the notification channel so it can be used
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  /**
   * This sets up push notifications from firebase and firebase cloud message
   */
  Future initPushNotifications() async {
    // Used to set how the notification is sent in the foreground
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // These handle how the notification is processed based on the different states of the app
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handles how the notification is sent to the users phone
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

  /**
   * Schedules a local push notification for the reminder screen that gets sent to the user based on the date entered
   * @post A local push notification is scheduled for the time entered by the user
   * @param pmOrAm, 0 = am | 1 = pm
   * @param hour, hour of the date
   * @param minute, minute of the date
   * @param month, month of the date
   * @param day, day of the date
   * @param notes, notes for the reminder message to send the user through the notification
   */
  Future scheduleNotification(int pmOrAm, String month, String day, String hour, String minute, String notes) async {
    // We need a TZDateTime for a zonedSchedule
    // This creates one based on the users input
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

  /**
   * Sets up the push and local notifications for the app when it is first started
   * @post Push and local notifications are initialized for the app to use
   * (The users token for their phone is printed and accessible for cloud notifications)
   */
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token:  $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }

}