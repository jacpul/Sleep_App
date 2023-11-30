import '../views/dreams_view.dart';
import '../viewmodel/dreams_viewmodel.dart';
import '../utils/dreams_utils.dart';

class UNITSPresenter {
  ///sends value to calculator code
  void onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString){

  }
  /// updates radio for bed time
  void onWakeTimeOptionChanged(int value) {

  }
  /// updates radio for sleep time
  void onSleepTimeOptionChanged(int value) {

  }
  /// sets the units needed for calculation
  set unitsView(UNITSView value){}

  /// sends value to model
  void onSleepHourSubmitted(String sleepHour){}

  /// sends value to model
  void onSleepMinuteSubmitted(String sleepMinute){}

  /// sends value to model
  void onWakeMinuteSubmitted(String wakeMinute){}

  /// sends value to model
  void onWakeHourSubmitted(String wakeHour){}

  /// sends value to model
  void onDateSubmitted(String month, String day, String year){}

  /// sends value to model
  void onSleepQualitySubmitted(int sleepQuality){}

  /// sends value to model
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

    double temp = calculator(wakeHour, wakeMinute,sleepHour, sleepMinute, _viewModel.unitTypeWake, _viewModel.unitTypeSleep);

    _viewModel.message = temp.toString();


    _view.updateMessage(_viewModel.message);

    _view.updateSleepType(_viewModel.unitTypeSleep);
    _view.updateWakeType(_viewModel.unitTypeWake);

  }

  @override
  void onWakeTimeOptionChanged(int value)  {

    if (value != _viewModel.wakeValue) {
      _viewModel.wakeValue = value;
      saveValue(_viewModel.wakeValue);

      _view.updateWakeTimeRadio(_viewModel.wakeValue);
    }
  }

  @override
  void onSleepTimeOptionChanged(int value)  {

    if (value != _viewModel.sleepValue) {

      _viewModel.sleepValue = value;
      saveValue(_viewModel.sleepValue);

      _view.updateSleepTimeRadio(_viewModel.sleepValue);
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

    _viewModel.wakeHour = double.parse(wakeHour);
  }

  @override
  void onWakeMinuteSubmitted(String wakeMinute) {

    _viewModel.wakeMinute = double.parse(wakeMinute);
  }

  @override
  void onDateSubmitted(String month, String day, String year) {

    _viewModel.month = int.parse(month);
    _viewModel.day = int.parse(day);
    _viewModel.year = int.parse(year);
  }

  @override
  void onSleepQualitySubmitted(int sleepQuality) {

    _viewModel.sleepQuality = sleepQuality;
  }

  @override
  void onNotesSubmitted(String notes) {

    _viewModel.sleepNotes = notes;
  }

}