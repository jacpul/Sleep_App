import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReminder extends StatefulWidget {
  @override
  _CreateReminder createState() => _CreateReminder();
}

class _CreateReminder extends State<CreateReminder> {
  int currentSelectedTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create a Reminder')),
      backgroundColor: Colors.white,

      body: Container(
        color: Colors.yellowAccent.shade100,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio<int>(
                activeColor: Colors.blueAccent.shade400,
                value: 0, groupValue: currentSelectedTime, onChanged: (value) {
                    setState(() {
                      currentSelectedTime = 1;
                    });
                }
              ),
              Text(
                'AM',
                style: TextStyle(color: Colors.blueAccent.shade400),
              ),
              Radio<int>(
                activeColor: Colors.blueAccent.shade400,
                value: 1, groupValue: currentSelectedTime, onChanged: (value) {
                  setState(() {
                    currentSelectedTime = 0;
                  });
                }
              ),
              Text(
                'PM',
                style: TextStyle(color: Colors.blueAccent.shade400),
              ),
            ],
          ),
      ),
    );
  }
}