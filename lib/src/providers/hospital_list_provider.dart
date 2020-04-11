import 'package:flutter/material.dart';
import 'package:hospitality/src/models/hospital.dart';

class HospitalListProvider extends ChangeNotifier{
  List<Hospital> _hospitals;

   List<Hospital> get getHospitalsList {
    return _hospitals;
  }

  set setHospitalLists(List<Hospital> _hospitals){
    this._hospitals=_hospitals;
    notifyListeners();
  }
}