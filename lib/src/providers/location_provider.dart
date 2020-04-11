import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  LocationData _location;
  int _hospitalDistance;

  LocationData get getLocation {
    return _location;
  }

  set setLocation(LocationData data) {
    _location = data;
    notifyListeners();
  }

  set setHospitalDistance(int data) {
    _hospitalDistance = data;
    notifyListeners();
  }
}
