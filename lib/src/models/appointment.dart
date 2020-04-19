import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
import 'package:intl/intl.dart';

class Appointment {
  String _date="";
  String _time="";
  String _status="";
  String _note="";
  int _timestamp=0;
  User _user=User();
  Hospital _hospital=Hospital();


  int get getTimestamp => _timestamp;

  set setTimestamp(int timestamp) => this._timestamp = timestamp; 

  User get getUser => _user;

  set setUser(User user) => this._user = user;

  Hospital get getHospital => _hospital;

  set setHospital(Hospital hospital) => this._hospital = hospital;

  String get getTime => _time;

  set setTime(String time) => this._time = time;

  String get getNote => _note;

  set setNote(String note) => this._note = note;

  String get getDate => _date;

  set setDate(String date) => this._date = date;

  String get getStatus => _status;

  set setStatus(String status) => this._status = status;

  Appointment.fromJSON(Map<String, dynamic> responseMap) {
    if (responseMap == null) {
      throw FormatException("Null JSON");
    }
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(responseMap["date"]);
    this._timestamp=responseMap["date"];
    this._time = DateFormat('hh:mm a').format(dateTime);
    this._date = DateFormat("EEE, d MMM yyyy").format(dateTime);
    this._status = responseMap["status"];
    this._note = responseMap["note"];
    if (SplashPage.isPatient) {
      this._hospital = Hospital.fromJSON(responseMap);
    } else {
      this._user = User.fromJSON(responseMap: responseMap);
      this._user.setFullName=responseMap["name"];
    }
  }
}
