import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/dreams_constant.dart';
import '../../calendar_screen.dart';
import '../../main.dart';
import '../../notification_screen.dart';
import '../../reminder_screen.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'package:units/main_screen.dart';

class HomePage extends StatefulWidget {
  final UNITSPresenter presenter;

  HomePage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements UNITSView {

  var _sleepHourController = TextEditingController();
  var _sleepMinuteController = TextEditingController();
  var _wakeHourController = TextEditingController();
  var _wakeMinuteController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  var yearController = TextEditingController();
  var notesController = TextEditingController();
  String _wakeHour = "0.0";
  String _wakeMinute = "0.0";
  String _sleepMinute = "0.0";
  String _sleepHour = "0.0";
  String month = "0.0";
  String day = "0.0";
  String year = "0.0";
  String notes = "";
  var _message = '';
  var _wakeType = "";
  var _sleepType = "";
  var _valueSleepTime = 0;
  var _valueWakeTime = 0;
  double currentSliderValue = 0;
  int errorValue = 0;
  final String yearNow = DateTime.now().year.toString();

  var _formKey = GlobalKey<FormState>();

  late String currentUser;

  @override
  void initState() {
    super.initState();
    this.widget.presenter.unitsView = this;
    currentUser = FirebaseAuth.instance.currentUser!.uid;
  }

  void handleRadioValueChangedWakeTime(int? value) {
    this.widget.presenter.onWakeTimeOptionChanged(value!);
  }

  void handleRadioValueChangedSleepTime(int? value) {
    this.widget.presenter.onSleepTimeOptionChanged(value!);
  }

  void _logCalculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.widget.presenter.onSleepMinuteSubmitted(_sleepMinute);
      this.widget.presenter.onSleepHourSubmitted(_sleepHour);
      this.widget.presenter.onWakeMinuteSubmitted(_wakeMinute);
      this.widget.presenter.onWakeHourSubmitted(_wakeHour);
      this.widget.presenter.onDateSubmitted(month, day, year);
      this.widget.presenter.onSleepQualitySubmitted(currentSliderValue.toInt());
      this.widget.presenter.onNotesSubmitted(notes);
      this.widget.presenter.onCalculateClicked(_wakeHour, _wakeMinute, _sleepHour, _sleepMinute);

    }
  }

  @override
  void updateMessage(String message){
    _message = message;
    setState(() {
      print(message);
      //_message = message;
    });
  }

  @override
  void updateWakeTimeRadio(int value){
    setState(() {
      _valueWakeTime = value;
    });
  }
  @override
  void updateSleepTimeRadio(int value){
    setState(() {
      _valueSleepTime = value;
    });
  }

  @override
  void updateSleepType(UnitType type) {
    setState(() {
      if(type == UnitType.AM)
        _sleepType = "AM";
      if(type == UnitType.PM)
        _sleepType = "PM";
    });
  }

  @override
  void updateWakeType(UnitType type) {
    setState(() {
      if(type == UnitType.AM)
        _wakeType = "AM";
      if(type == UnitType.PM)
        _wakeType = "PM";
    });
  }

  @override
  Widget build(BuildContext context) {

    var _unitViewTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 0, groupValue: _valueSleepTime, onChanged: handleRadioValueChangedSleepTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 1, groupValue: _valueSleepTime, onChanged: handleRadioValueChangedSleepTime,
        ),
        Text(
          'PM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
      ],
    );
    var _unitViewWakeTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 0, groupValue: _valueWakeTime, onChanged: handleRadioValueChangedWakeTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 1, groupValue: _valueWakeTime, onChanged: handleRadioValueChangedWakeTime,
        ),
        Text(
          'PM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
      ],
    );

    var _mainPartView = Container(
      color: Colors.yellowAccent.shade100,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I went to bed at:",style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: sleepHourFormField(context),
                  ),
                  Expanded(
                    child: sleepMinuteFormField(context),
                  )
                ],
              ),
              _unitViewTime,
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I woke up at:",style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: wakeHourFormField(context),
                  ),
                  Expanded(
                    child: wakeMinuteFormField(context),
                  ),
                ],
              ),
              _unitViewWakeTime,
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Enter Date:",style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5,)
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: monthFormField(context)
                  ),
                  Expanded(
                      child: dayFormField(context)
                  ),
                  Expanded(
                      child: yearFormField(context)
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Select Sleep Quality:",style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5,)
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: sleepQuality(context)
                  ),
                ]
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Enter notes:",style: const TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5,)
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: notesFormField(context),
                    ),
                  ]
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: calculateButton()
                ,),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          //title: Text('Sleep Log'),
          backgroundColor: Colors.deepOrangeAccent,

            actions: [ //appbar functions

              //Home button
              IconButton(
                icon:const Icon(Icons.add_home_outlined),
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
                icon: const Icon(Icons.mode_edit_outlined),
                tooltip: 'Log',
                onPressed: () {
                  //returns nothing, already in log
                },
              ),

              // Calendar Button
              IconButton(
                icon: const Icon(Icons.calendar_month),
                tooltip: 'Calendar',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
                  {
                    return CalendarScreen();
                  }));
                },
              ),

              //Notifications Button
              IconButton(
                icon: const Icon(Icons.new_releases_outlined),
                tooltip: 'Notifications',
                onPressed: ()  {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
                  {
                    return NotificationScreen();
                  }));
                },
              ),

              //Calendar Button

              //Reminder Button
              IconButton(
                icon: const Icon(Icons.add_alert_outlined),
                tooltip: 'Reminders',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return ReminderScreen();
                  }));
                },
              )

            ]
        ),
        backgroundColor: Colors.yellow.shade800,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            Padding(padding: EdgeInsets.all(5.0)),
          ],
        )
    );
  }

  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: () {
        _logCalculator();
        print("wake type is: " + _wakeType);
        print("sleep type is: " + _sleepType);
        if(errorValue == 0) {
          CollectionReference colRef = FirebaseFirestore.instance.collection('users').doc(currentUser).collection('Logs');
          colRef.add({
            'Day': int.parse(dayController.text),
            'Month': int.parse(monthController.text),
            'Year': int.parse(yearController.text),
            'Hours_Slept': _message,
            'Sleep_Quality': currentSliderValue.toString(),
            'Notes': notesController.text,
          });
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text('Time Slept'),
                    content:
                    Text("Amount of time slept: " + _message,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home())),
                          child: Text('OKAY'))
                    ],
                  ));
          clearText();
        }
        clearText();
        //dispose();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrangeAccent,
        textStyle: TextStyle(color: Colors.white70)
      ),
      child: Text(
        'Enter Into Log',
        style: TextStyle(fontSize: 16.9),
      ),
    );
  }

  void clearText() {
    _sleepHourController.clear();
    _sleepMinuteController.clear();
    _wakeHourController.clear();
    _wakeMinuteController.clear();
    monthController.clear();
    dayController.clear();
    yearController.clear();
    notesController.clear();
  }

  TextFormField sleepMinuteFormField(BuildContext context) {
    return TextFormField(
      controller: _sleepMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          errorValue = 1;
          return ('Minute between 0 - 59');
        }
        errorValue = 0;
      },
      onSaved: (value) {
        _sleepMinute = value!;
      },
      decoration: InputDecoration(
          hintText: 'e.g.) 40',
          labelText: 'Minute',
          icon: Icon(Icons.access_time_rounded),
          fillColor: Colors.white
      ),
    );
  }

  TextFormField sleepHourFormField(BuildContext context) {
    return TextFormField(
      controller: _sleepHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          errorValue = 1;
          return ('Hour between 1 - 12');
        }
        errorValue = 0;
      },
      onSaved: (value) {
        _sleepHour = value!;
      },
      decoration: InputDecoration(
        hintText: "e.g.) 7",
        labelText: "Hour",
        icon: Icon(Icons.access_time_rounded),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField wakeHourFormField(BuildContext context) {
    return TextFormField(
      controller: _wakeHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          errorValue = 1;
          return ('Hour between 1 - 12');
        }
        errorValue = 0;
      },
      onSaved: (value) {
        _wakeHour = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        icon: Icon(Icons.access_time_rounded),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField wakeMinuteFormField(BuildContext context) {
    return TextFormField(
      controller: _wakeMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          errorValue = 1;
          return ('Minute between 0 - 59');
        }
        errorValue = 0;
      },
      onSaved: (value) {
        _wakeMinute = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 30',
        labelText: 'Minute',
        icon: Icon(Icons.access_time_rounded),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField monthFormField(BuildContext context) {
    return TextFormField(
      controller: monthController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          errorValue = 1;
          return ('Month between 1 - 12');
        }
        errorValue = 0;
      },
      onSaved: (value){
        month = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 11',
        labelText: 'Month',
        icon: Icon(Icons.date_range),
      ),
    );
  }

  TextFormField dayFormField(BuildContext context) {
    return TextFormField(
      controller: dayController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 31)) {
          errorValue = 1;
          return ('Day between 1 - 31');
        }
        errorValue = 0;
      },
      onSaved: (value){
        day = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 27',
        labelText: 'Day',
        icon: Icon(Icons.date_range),
      ),
    );
  }

  TextFormField yearFormField(BuildContext context) {
    return TextFormField(
      controller: yearController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value != yearNow) {
          errorValue = 1;
          return ("year must be today's year");
        }
        errorValue = 0;
      },
      onSaved: (value){
        year = value!;
      },
      decoration: InputDecoration(
        hintText: '2023',
        labelText: 'Year',
        icon: Icon(Icons.date_range),
      ),
    );
  }

  Slider sleepQuality(BuildContext context) {
    return Slider(
        value: currentSliderValue,
        max: 10,
        divisions: 10,
        label: currentSliderValue.round().toString(),
        onChanged: (value) {
          setState(() {
            print("in slider with value: " + value.toString());
            currentSliderValue = value;
          });
        }
    );
  }

  TextFormField notesFormField(BuildContext context) {
    return TextFormField(
      controller: notesController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 200,
      onSaved: (value){
        notes = value!;
      },
      decoration: InputDecoration(
        hintText: 'Enter Notes Here',
        labelText: 'Sleep Notes',
        icon: Icon(Icons.book_outlined),
      ),
    );
  }


}
