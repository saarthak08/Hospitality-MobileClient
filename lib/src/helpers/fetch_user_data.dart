import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchPatientUserData(
    {@required BuildContext context,
    UserProfileProvider userProfileProvider}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String email = preferences.getString("email");
  await getNetworkRepository
      .getPatientUserData(email: email)
      .then((value) async {
    if (value.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(value.body);
      User user = User.fromJSON(responseMap: responseMap);
      userProfileProvider.setUser = user;
    } else if (value.statusCode == 401) {
      print("Get Patient User Data: ${value.statusCode} Unauthorized access");
      User user = User();
      UserProfileProvider userProfileProvider =
          Provider.of<UserProfileProvider>(context);
      userProfileProvider.setUser = user;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/auth", (Route<dynamic> route) => false);
    } else {
      print("getUserProfileData: " +
          value.statusCode.toString() +
          " ${value.body.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching profile data");
    }
  }).catchError((error) {
    print("getUserProfileData: " + " ${error.toString()}");
    Fluttertoast.showToast(msg: "Error in fetching profile data");
  });
}

Future<void> fetchHospitalUserData(
    {@required BuildContext context,
    @required HospitalUserProvider hospitalUserProvider}) async {
  await getNetworkRepository.getHospitalData().then((value) async {
    if (value.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(value.body);
      Hospital hospital = Hospital.fromJSON(responseMap);
      hospitalUserProvider.setHospital = hospital;
    } else if (value.statusCode == 401) {
      print("Get Hospital Data: ${value.statusCode} Unauthorized access");
      Hospital hospital = Hospital();
      hospitalUserProvider = Provider.of<HospitalUserProvider>(context);
      hospitalUserProvider.setHospital = hospital;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/auth", (Route<dynamic> route) => false);
    } else {
      print("Get Hospital Profile Data: " +
          value.statusCode.toString() +
          " ${value.body.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching profile data");
    }
  }).catchError((error) {
    print("Get Hospital Profile Data: " + " ${error.toString()}");
    Fluttertoast.showToast(msg: "Error in fetching profile data");
  });
}
