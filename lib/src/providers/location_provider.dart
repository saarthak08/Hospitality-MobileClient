import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  LocationData _location;

  LocationData get getLocation {
    return _location;
  }

  set setLocation(LocationData data){
    _location=data;
    notifyListeners();
  }
}