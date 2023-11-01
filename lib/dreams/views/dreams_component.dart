import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';

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
  var _hourController = TextEditingController();
  var _minuteController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  var yearController = TextEditingController();
  var notesController = TextEditingController();
  String _hour = "0.0";
  String _minute = "0.0";
  String _sleepMinute = "0.0";
  String _sleepHour = "0.0";
  String month = "0.0";
  String day = "0.0";
  String year = "0.0";
  String notes = "";
  var _resultString = '';
  var _timeString = '';
  var _message = '';
  var _value = 0;
  var _valueSleepTime = 0;
  var _valueWakeTime = 0;
  double currentSliderValue = 0;
  final String yearNow = DateTime.now().year.toString();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.unitsView = this;
  }

  void handleRadioValueChanged(int? value) {
    this.widget.presenter.onOptionChanged(value!, sleepHourString: _sleepHour, sleepMinuteString: _sleepMinute );
  }
  void handleRadioValueChangedTime(int? value) {
    this.widget.presenter.onTimeOptionChanged(value!);
  }

  void _calculator() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      this.widget.presenter.onCalculateClicked(_hour, _minute, _sleepMinute, _sleepHour);
    }
  }

  @override
  void updateResultValue(String resultValue){
    setState(() {
      _resultString = resultValue;
    });
  }
  @override
  void updateTimeString(String timeString){
    setState(() {
      _timeString = timeString;
    });
  }
  @override
  void updateMessage(String message){
    setState(() {
      _message = message;
    });
  }
  @override
  void updateSleepMinute({required String sleepMinute}){
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepMinuteController.text = sleepMinute != null?sleepMinute:'';
    });
  }
  @override
  void updateSleepHour({required String sleepHour}){
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepHourController.text = sleepHour != null?sleepHour:'';
    });
  }
  @override
  void updateHour({required String hour}) {
    setState(() {
      _hourController.text = hour != null ? hour : '';
    });
  }
  @override
  void updateMinute({required String minute}) {
    setState(() {
      _minuteController.text = minute != null ? minute : '';
    });
  }
  @override
  void updateUnit(int value){
    setState(() {
      _value = value;
    });
  }
  @override
  void updateTimeUnit(int value){
    setState(() {
      _valueSleepTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    var _unitViewTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 0, groupValue: _valueSleepTime, onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 1, groupValue: _valueSleepTime, onChanged: handleRadioValueChangedTime,
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
          value: 0, groupValue: _valueWakeTime, onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: Colors.blueAccent.shade400),
        ),
        Radio<int>(
          activeColor: Colors.blueAccent.shade400,
          value: 1, groupValue: _valueWakeTime, onChanged: handleRadioValueChangedTime,
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
                    child: wakeHourFormField(context),
                  ),
                  Expanded(
                    child: wakeMinFormField(context),
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
                    child: sleepHourFormField(context),
                  ),
                  Expanded(
                    child: sleepMinuteFormField(),
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

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            '$_message $_resultString $_timeString',
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Sleep Log'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        backgroundColor: Colors.yellow.shade800,
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5.0)),
            _mainPartView,
            Padding(padding: EdgeInsets.all(5.0)),
            _resultView
          ],
        )
    );
  }

  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: _calculator,
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

  TextFormField sleepMinuteFormField() {
    return TextFormField(
      controller: _sleepMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
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
          return ('Hour between 1 - 12');
        }
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
      controller: _hourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _hour = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        icon: Icon(Icons.access_time_rounded),
        fillColor: Colors.white,
      ),
    );
  }

  TextFormField wakeMinFormField(BuildContext context) {
    return TextFormField(
      controller: _minuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _minute = value!;
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
          return ('Month between 1 - 12');
        }
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
          return ('Day between 1 - 31');
        }
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
          return ("year must be today's year");
        }
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
