import 'package:flutter/material.dart';
import 'package:hospitality/src/models/user.dart';

class UserProfileProvider extends ChangeNotifier {
  User _user=User();

  User get getUser {
    return _user;
  }

  set setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
