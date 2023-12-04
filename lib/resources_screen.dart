import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/reminder_screen.dart';
import 'package:units/videoresource_screen.dart';
import 'article_tips.dart';
import 'calendar_screen.dart';
import 'main_screen.dart';
import 'splash_screen.dart';
import 'notification_screen.dart';
import 'audio_screen.dart';
import 'Icons/sleep_icons_icons.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreen createState() => _ResourcesScreen();
}

class _ResourcesScreen extends State<ResourcesScreen> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //title: Text('Reminders'),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [ // appbar functions
            /**
             * When you click on an Icon on the page it will bring
             * you to the page Icon you click on.
             *
             * Input: A click on the Icon
             * Output: Changing your screen to display the screen you clicked on
             *
             **/
            //Home button
            IconButton(
              icon:const Icon(SleepIcons.os_homewhitesvg),
              tooltip: "Home",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Home();
                    }));
              },
            ),

            //log button
            IconButton(
              icon: const Icon(SleepIcons.os_log2whitesvg),
              tooltip: 'Log',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
                }));
              },
            ),

            // Calendar Button
            IconButton(
              icon: const Icon(SleepIcons.os_calendarwhitesvg),
              tooltip: 'Calendar',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarScreen();
                }));
              },
            ),

            //Notifications Button
            IconButton(
              icon: const Icon(SleepIcons.os_notif2svg),
              tooltip: 'Notifications',
              onPressed: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return NotificationScreen();
                }));
              },
            ),

            //Calendar Button

            //Reminder Button
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
          ]
      ),
      backgroundColor: Colors.yellow.shade800,
      body: Column(
        children: <Widget>[
          // Empty space above the title
          SizedBox(height: 60.0),

          // Title
          Text(
            'Helpful Sleeping Resources',
            style: TextStyle(
                fontWeight:
                FontWeight.bold,
                color: Colors.blueAccent),
            textScaleFactor: 2.3,
          ),
          // Buttons
          Container(
            height: (screenHeight * 2 / 3) - 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /**
                 * Takes you to the type of resources that you want to see.
                 *
                 * Inputs: A click on the button
                 * Outputs: Changes the screen that you are on
                 */
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return AudioScreen();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(160, 60),
                  ),
                  child: Text(
                    'White Noise',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Adjust the font size here
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return VideoResource();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(160, 60),
                  ),
                  child: Text(
                    'Videos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Adjust the font size here
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return TipScreen();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(160, 60),
                  ),
                  child: Text(
                    'Articles',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24, // Adjust the font size here
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}