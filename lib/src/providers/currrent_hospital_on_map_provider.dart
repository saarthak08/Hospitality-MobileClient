import 'package:flutter/material.dart';
import 'package:hospitality/src/models/hospital.dart';

class CurrentHospitalOnMapProvider extends ChangeNotifier {
  Hospital _hospital;

  Hospital get getHospital {
    return _hospital;
  }

  set setHospital(Hospital hospital) {
    _hospital = hospital;
    notifyListeners();
  }
}
