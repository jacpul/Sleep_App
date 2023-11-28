import '../views/dreams_view.dart';
import '../viewmodel/dreams_viewmodel.dart';
import '../utils/dreams_utils.dart';

class UNITSPresenter {

  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString){

  }

  void onWakeTimeOptionChanged(int value) {

  }
  void onSleepTimeOptionChanged(int value) {

  }
  set unitsView(UNITSView value){}

  void onSleepHourSubmitted(String sleepHour){}
  void onSleepMinuteSubmitted(String sleepMinute){}
  void onWakeMinuteSubmitted(String wakeMinute){}
  void onWakeHourSubmitted(String wakeHour){}
  void onDateSubmitted(String month, String day, String year){}
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
    _viewModel.wakeValue = await loadValue();
    _viewModel.sleepValue = await loadValue();
    _view.updateWakeTimeRadio(_viewModel.wakeValue);
    _view.updateSleepTimeRadio(_viewModel.sleepValue);
  }

  @override
  set unitsView(UNITSView value) {
    _view = value;
    _view.updateWakeTimeRadio(_viewModel.wakeValue);
    _view.updateSleepTimeRadio(_viewModel.sleepValue);
  }

  @override
  void onCalculateClicked(String wakeHourString, String wakeMinuteString, String sleepHourString, String sleepMinuteString) {
    var wakeHour = 0.0;
    var wakeMinute = 0.0;
    var sleepHour = 0.0;
    var sleepMinute = 0.0;

    wakeHour = double.parse(wakeHourString);
    wakeMinute = double.parse(wakeMinuteString);
    sleepHour = double.parse(sleepHourString);
    sleepMinute = double.parse(sleepMinuteString);

    /*List temp = new List.filled(3, null, growable: false);
    _viewModel.hour = hour;
    _viewModel.minute = minute;
    _viewModel.sleepHour = sleepHour;
    _viewModel.sleepMinute = sleepMinute;*/
    double temp = calculator(wakeHour, wakeMinute,sleepHour, sleepMinute, _viewModel.unitTypeWake, _viewModel.unitTypeSleep);
    //  temp returns a List of the time, AM or PM, and WAKE or BED.
    //  The time that is returned is in the format of a double ex) 12.30 is 12:30.

    _viewModel.message = temp.toString();

    /*UnitType tempTime = temp[1];
    UnitType tempMessage = temp[2];*/

    /*if(tempTime == UnitType.AM) {
      _viewModel.timeType = "AM";
    } else if (tempTime == UnitType.PM) {
      _viewModel.timeType = "PM";
    }

    if(tempMessage == UnitType.BED) {
      _viewModel.message = "You should wake up at";
    } else if (tempMessage == UnitType.WAKE) {
      _viewModel.message = "You should go to bed at";
    }*/
    //print(_viewModel.messageInString);
    _view.updateMessage(_viewModel.message);

    _view.updateSleepType(_viewModel.unitTypeSleep);
    _view.updateWakeType(_viewModel.unitTypeWake);
    /*_view.updateTimeString(_viewModel.timeType);
    _view.updateResultValue(_viewModel.resultInString);*/
  }

  @override
  void onWakeTimeOptionChanged(int value)  {
      print("onOptionChanged");
    if (value != _viewModel.wakeValue) {
      _viewModel.wakeValue = value;
      saveValue(_viewModel.wakeValue);

      _view.updateWakeTimeRadio(_viewModel.wakeValue);
    }
  }

  @override
  void onSleepTimeOptionChanged(int value)  {
    print("onTimeOptionChanged");
    print(value);
    if (value != _viewModel.sleepValue) {

      _viewModel.sleepValue = value;
      saveValue(_viewModel.sleepValue);

      _view.updateSleepTimeRadio(_viewModel.sleepValue);
    }
  }


  @override
  void onSleepHourSubmitted(String sleepHour) {
    print("submitted sleepHour");
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
  void onDateSubmitted(String month, String day, String year) {
    // TODO: implement onDateSubmitted
    _viewModel.month = int.parse(month);
    _viewModel.day = int.parse(day);
    _viewModel.year = int.parse(year);
  }

  @override
  void onSleepQualitySubmitted(int sleepQuality) {
    // TODO: implement onSleepQualitySubmitted
    _viewModel.sleepQuality = sleepQuality;
  }

  @override
  void onNotesSubmitted(String notes) {
    print("submitted notes");

    // TODO: implement onNotesSubmitted
    _viewModel.sleepNotes = notes;
  }

}