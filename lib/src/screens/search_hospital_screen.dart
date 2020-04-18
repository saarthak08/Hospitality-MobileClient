import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/user_home_screen.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_screen.dart';

class SearchHospitalScreen extends StatefulWidget {
  final ScrollController controller;
  final GlobalKey<FormState> formKey;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  SearchHospitalScreen(
      {@required this.formKey,
      @required this.controller,
      @required this.refreshIndicatorKey});
  @override
  State<StatefulWidget> createState() {
    return _SearchHospitalScreenState(
        formKey: formKey,
        controller: controller,
        refreshIndicatorKey: refreshIndicatorKey);
  }
}

class _SearchHospitalScreenState extends State<SearchHospitalScreen> {
  double viewportHeight;
  double viewportWidth;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  LocationProvider locationProvider;
  HospitalListProvider hospitalListProvider;
  bool isButtonEnabled = false;
  ScrollController controller;
  GlobalKey<FormState> formKey;
  double distance = 0;
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  _SearchHospitalScreenState(
      {@required this.formKey,
      @required this.controller,
      @required this.refreshIndicatorKey});

  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    UserHomeScreen.tabIndex = 0;
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          controller.animateTo(
            0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: SingleChildScrollView(
          controller: controller,
          child: Container(
            height: viewportHeight,
            width: viewportWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.blue.shade300]),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: viewportHeight * 0.05),
                  height: viewportHeight * 0.25,
                  width: viewportWidth * 0.8,
                  child: Image.asset('assets/img/hosp_doc.png'),
                ),
                SizedBox(
                  height: viewportHeight * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    SizedBox(width: viewportWidth * 0.03),
                    Text(
                      'Input distance for nearby hospital',
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: viewportWidth * 0.04,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: viewportHeight * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        onTap: () {
                          controller.animateTo(
                            viewportHeight * 0.2,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        cursorColor: Theme.of(context).primaryColor,
                        style: dropdownMenuItem,
                        decoration: InputDecoration(
                          hintText: "Search by distance in km",
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: viewportWidth * 0.045),
                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                _submitForm(context);
                                formKey.currentState.reset();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: viewportWidth * 0.05,
                              vertical: viewportHeight * 0.02),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (String value) {
                          if (value.length == 0) {
                            setState(() {
                              isButtonEnabled = false;
                            });
                          } else {
                            setState(() {
                              isButtonEnabled = true;
                            });
                          }
                          distance = double.parse(value);
                        },
                        onFieldSubmitted: (String value) {
                          controller.animateTo(
                            0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        onSaved: (String value) {
                          if (value.length == 0) {
                            setState(() {
                              isButtonEnabled = false;
                            });
                          } else {
                            setState(() {
                              isButtonEnabled = true;
                            });
                          }
                          distance = double.parse(value);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: viewportHeight * 0.06),
                RaisedButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.blue, width: 1)),
                  splashColor: isButtonEnabled ? Colors.blue : null,
                  color: isButtonEnabled ? Colors.white : Colors.grey.shade400,
                  child: Container(
                    width: viewportWidth * 0.35,
                    height: viewportHeight * 0.06,
                    alignment: Alignment.center,
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        fontFamily: "Manrope",
                        fontSize: viewportHeight * 0.025,
                      ),
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    if (isButtonEnabled) {
                      _submitForm(context);
                      formKey.currentState.reset();
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void _submitForm(BuildContext context) async {
    controller.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    formKey.currentState.save();
    setState(() {
      isButtonEnabled = false;
    });
    showLoadingDialog(context: context);
    getLocation().then((value) {
      if (value != null) {
        locationProvider.setLocation = value;
        getNetworkRepository
            .sendCurrentLocationAndGetHospitalLists(
                latitude: value.latitude,
                longitude: value.longitude,
                range: distance)
            .then((value) async {
          if (value.statusCode == 200) {
            List<dynamic> response = json.decode(value.body);
            List<Hospital> hospitals = new List<Hospital>();
            hospitalListProvider.setHospitalLists = hospitals;
            print(response);
            for (int i = 0; i < response.length; i++) {
              Map<String, dynamic> data = response[i].cast<String, dynamic>();
              Hospital h = Hospital.fromJSON(data);
              hospitals.add(h);
            }
            if (hospitals.length == 0) {
              Fluttertoast.showToast(
                  msg:
                      "No nearby hospitals found! Try again or change the distance limit!",
                  toastLength: Toast.LENGTH_SHORT);
              Navigator.pop(context);
            } else {
              hospitalListProvider.setHospitalLists = hospitals;
              Navigator.pop(context);
              Navigator.push(
                  context,
                  BouncyPageRoute(
                      widget: MapView(
                    inputDistance: distance.toInt(),
                  )));
            }
          } else if (value.statusCode == 404) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg:
                    "No nearby hospitals found! Try again or change the distance limit!",
                toastLength: Toast.LENGTH_SHORT);
            print("Get Hospitals List: " + value.statusCode.toString());
          } else if (value.statusCode == 401) {
            print("Get Hospitals List: ${value.statusCode} Unauthorized access");
            User user=User();
            UserProfileProvider userProfileProvider=Provider.of<UserProfileProvider>(context);
            userProfileProvider.setUser=user;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/auth", (Route<dynamic> route) => false);
          } else {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Error fetching hospitals! Try again!",
                toastLength: Toast.LENGTH_SHORT);
            print("Get Hospitals List: " + value.statusCode.toString());
          }
        }).catchError((error) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Error fetching hospitals! Try again!",
              toastLength: Toast.LENGTH_SHORT);
          print("Get Hospitals List: " + error.toString());
        });
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Error in getting location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Error in getting location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      print("Get Hospitals List: " + error.toString());
    });
  }
}
