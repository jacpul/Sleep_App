import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReminder extends StatefulWidget {
  @override
  _CreateReminder createState() => _CreateReminder();
}

class _CreateReminder extends State<CreateReminder> {
  int currentSelectedTime = 0;

  var _ReminderHourController = TextEditingController();
  var _ReminderMinuteController = TextEditingController();
  String _ReminderMinute = "0.0";
  String _ReminderHour = "0.0";

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
              Container(
                  color: Colors.yellowAccent.shade100,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: reminderHourFormField(context),
                            ),
                            Expanded(
                              child: reminderMinuteFormField(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
      ),
    );
  }

  TextFormField reminderHourFormField(BuildContext context) {
    return TextFormField(
      controller: _ReminderHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _ReminderHour = value!;
      },
      decoration: InputDecoration(
        hintText: "e.g.) 7",
        labelText: "Hour",
        icon: Icon(Icons.access_time_rounded),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField reminderMinuteFormField(BuildContext context) {
    return TextFormField(
      controller: _ReminderMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _ReminderMinute = value!;
      },
      decoration: InputDecoration(
          hintText: 'e.g.) 40',
          labelText: 'Minute',
          icon: Icon(Icons.access_time_rounded),
          fillColor: Colors.white
      ),
    );
  }

}