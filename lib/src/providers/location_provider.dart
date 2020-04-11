import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  LocationData _location;
  double _hospitalDistance;

  LocationData get getLocation {
    return _location;
  }

  set setLocation(LocationData data) {
    _location = data;
    notifyListeners();
  }

  set setHospitalDistance(double data) {
    _hospitalDistance = data;
    notifyListeners();
  }

  double get getHospitalDistance {
    return _hospitalDistance;
  }
}
