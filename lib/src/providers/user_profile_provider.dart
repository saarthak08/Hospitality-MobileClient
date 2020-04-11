import 'package:flutter/material.dart';
import 'package:hospitality/src/models/user.dart';

class UserProfileProvider extends ChangeNotifier {
  User _user;
  bool _isPatient;

  bool get getIsPatient => _isPatient;

  set isPatient(bool value) {
    _isPatient = value;
    notifyListeners();
  }

  User get getUser {
    return _user;
  }

  set setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
