import '../views/dreams_view.dart';
import '../viewmodel/dreams_viewmodel.dart';
import '../utils/dreams_constant.dart';
import '../utils/dreams_utils.dart';

class UNITSPresenter {
  /*
  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString){

  }
  */
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString}) {

  }
  void onTimeOptionChanged(int value) {

  }
  set unitsView(UNITSView value){}

  void onSleepHourSubmitted(String sleepHour){}
  void onSleepMinuteSubmitted(String sleepMinute){}
  void onWakeMinuteSubmitted(String wakeMinute){}
  void onWakeHourSubmitted(String wakeHour){}
  void onDateSubmitted(int month, int day, int year){}
  void onSleepQualitySubmitted(int sleepQuality){}
  void onNotesSubmitted(String notes){}

}


class BasicPresenter implements UNITSPresenter{
  UNITSViewModel _viewModel = UNITSViewModel();
  UNITSView _view = UNITSView();

  BasicPresenter() {
    this._viewModel = _viewModel;
    _loadUnit();
  }

  void _loadUnit() async{
    _viewModel.value = await loadValue();
    _viewModel.valueTime = await loadValue();
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }

  @override
  set unitsView(UNITSView value) {
    _view = value;
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }
  /*
  @override
  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString) {
    var hour = 0.0;
    var minute = 0.0;
    var sleepHour = 0.0;
    var sleepMinute = 0.0;
    try {
      hour = double.parse(hourString);
    } catch (e){

    }
    try {
      minute = double.parse(minuteString);
    } catch (e){

    }
    try {
      sleepHour = double.parse(sleepHourString);
    } catch (e){

    }
    try {
      sleepMinute = double.parse(sleepMinuteString);
    } catch (e) {

    }

    List temp = new List.filled(3, null, growable: false);
    _viewModel.hour = hour;
    _viewModel.minute = minute;
    _viewModel.sleepHour = sleepHour;
    _viewModel.sleepMinute = sleepMinute;
    temp = calculator(hour,minute,sleepHour, sleepMinute, _viewModel.unitType, _viewModel.unitTypeTime);
    //  temp returns a List of the time, AM or PM, and WAKE or BED.
    //  The time that is returned is in the format of a double ex) 12.30 is 12:30.

    _viewModel.units = temp[0];
    UnitType tempTime = temp[1];
    UnitType tempMessage = temp[2];

    if(tempTime == UnitType.AM) {
      _viewModel.timeType = "AM";
    } else if (tempTime == UnitType.PM) {
      _viewModel.timeType = "PM";
    }

    if(tempMessage == UnitType.BED) {
      _viewModel.message = "You should wake up at";
    } else if (tempMessage == UnitType.WAKE) {
      _viewModel.message = "You should go to bed at";
    }
    _view.updateMessage(_viewModel.message);
    _view.updateTimeString(_viewModel.timeType);
    _view.updateResultValue(_viewModel.resultInString);
  }
  */
  @override
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString})  {

    if (value != _viewModel.value) {
      _viewModel.value = value;
      saveValue(_viewModel.value);
      var curOdom = 0.0;
      var fuelUsed = 0.0;
      if (!isEmptyString(sleepHourString)) {
        try {
          curOdom = double.parse(sleepHourString);
        } catch (e) {
        }
      }
      if (!isEmptyString(sleepMinuteString)) {
        try {
          fuelUsed = double.parse(sleepMinuteString);
        } catch (e) {

        }
      }
      _view.updateUnit(_viewModel.value);
      _view.updateSleepHour(sleepHour: _viewModel.sleepHourInString);
      _view.updateSleepMinute(sleepMinute: _viewModel.sleepMinuteInString);
    }
  }

  @override
  void onTimeOptionChanged(int value)  {

    if (value != _viewModel.valueTime) {
      _viewModel.valueTime = value;
      saveValue(_viewModel.valueTime);

      _view.updateTimeUnit(_viewModel.valueTime);
    }
  }


  @override
  void onSleepHourSubmitted(String sleepHour) {
      _viewModel.sleepHour = double.parse(sleepHour);
  }

  @override
  void onSleepMinuteSubmitted(String sleepMinute) {
      _viewModel.sleepMinute = double.parse(sleepMinute);
  }

  @override
  void onWakeHourSubmitted(String wakeHour) {
    // TODO: implement onWakeHourSubmitted
    _viewModel.wakeHour = double.parse(wakeHour);
  }

  @override
  void onWakeMinuteSubmitted(String wakeMinute) {
    // TODO: implement onWakeMinuteSubmitted
    _viewModel.wakeMinute = double.parse(wakeMinute);
  }

  @override
  void onDateSubmitted(int month, int day, int year) {
    // TODO: implement onDateSubmitted
    _viewModel.month = month;
    _viewModel.day = day;
    _viewModel.year = year;
  }

  @override
  void onSleepQualitySubmitted(int sleepQuality) {
    // TODO: implement onSleepQualitySubmitted
    _viewModel.sleepQuality = sleepQuality;
  }

  @override
  void onNotesSubmitted(String notes) {
    // TODO: implement onNotesSubmitted
    _viewModel.sleepNotes = notes;
  }

}