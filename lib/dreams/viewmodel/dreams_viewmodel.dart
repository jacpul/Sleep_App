import '../utils/dreams_constant.dart';

class UNITSViewModel {

  UnitType _unitTypeWake = UnitType.AM;
  UnitType _unitTypeSleep = UnitType.AM;

  String _message = "";


  double sleepHour = 0.0;
  double sleepMinute = 0.0;
  double wakeHour = 0.0;
  double wakeMinute = 0.0;
  int month = 0;
  int day = 0;
  int year = 0;
  int sleepQuality = -1;
  String sleepNotes = "";

  String get message => _message;
  set message(String outResult){
    _message = outResult;
  }

  UnitType get unitTypeSleep => _unitTypeSleep;
  set unitTypeTime(UnitType setValue){
    _unitTypeSleep = setValue;
  }

  UnitType get unitTypeWake => _unitTypeWake;
  set unitType(UnitType setValue){
    _unitTypeWake = setValue;
  }

  int get wakeValue => _unitTypeWake == UnitType.AM?0 : 1;
  set wakeValue(int value){
    if(value == 0){
      _unitTypeWake = UnitType.AM;
    } else {
      _unitTypeWake = UnitType.PM;
    }
  }

  int get sleepValue => _unitTypeSleep == UnitType.AM?0 : 1;
  set sleepValue(int value){
    if(value == 0){
      _unitTypeSleep = UnitType.AM;
    } else {
      _unitTypeSleep = UnitType.PM;
    }
  }

  String get messageInString => _message;

  UNITSViewModel();
}