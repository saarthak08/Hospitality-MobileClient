import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/hospital_home_screen.dart';
import 'package:provider/provider.dart';

class HospitalProfileEditScreen extends StatefulWidget {
  HospitalProfileEditScreen();

  @override
  State<StatefulWidget> createState() {
    return HospitalProfileEditScreenState();
  }
}

class HospitalProfileEditScreenState extends State<HospitalProfileEditScreen> {
  double viewportHeight;
  double viewportWidth;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  LocationProvider locationProvider;
  HospitalUserProvider hospitalUserProvider;
  String fullName = "";
  String phoneNumber = "";
  String address = "";
  String email = "";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      refreshIndicatorKey.currentState.show();
    });
  }

  HospitalProfileEditScreenState();

  @override
  Widget build(BuildContext context) {
    HospitalDashboard.tabIndex = 0;
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalUserProvider = Provider.of<HospitalUserProvider>(context);
    hospitalUserProvider.addListener(() {
      fullNameController.text = hospitalUserProvider.getHospital.getName;
      phoneNumberController.text =
          hospitalUserProvider.getHospital.getContactNo;
      addressController.text = hospitalUserProvider.getHospital.getAddress;
    });

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Edit Hospital Information",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "BalooTamma2",
              fontSize: viewportHeight * 0.03,
            ),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: () async {
              await getHospitalData();
            },
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                    padding: EdgeInsets.only(
                        left: viewportHeight * 0.02,
                        right: viewportHeight * 0.02,
                        top: viewportHeight * 0.02),
                    height: viewportHeight,
                    child: ListView(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
                          controller: TextEditingController()
                            ..text = hospitalUserProvider.getHospital.getEmail,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: viewportWidth * 0.01,
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: viewportHeight * 0.03,
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          readOnly: true,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.022),
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
                          controller: fullNameController,
                          onChanged: (String value) {
                            if (value != null || value.length != 0) {
                              setState(() {
                                this.fullName = value;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                              size: viewportHeight * 0.03,
                            ),
                            labelText: "Full Name",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.022),
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
                          onChanged: (String value) {
                            setState(() {
                              this.phoneNumber = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(Icons.phone,
                                color: Colors.blue,
                                size: viewportHeight * 0.03),
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.022),
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
                          onChanged: (String value) {
                            setState(() {
                              this.address = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(Icons.home,
                                color: Colors.blue,
                                size: viewportHeight * 0.03),
                            labelText: "Address",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.024),
                          controller: addressController,
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0,
                                  viewportWidth * 0.04, viewportWidth * 0.01),
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = hospitalUserProvider
                                      .getHospital.getLatitude
                                      .toString(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: viewportHeight * 0.01,
                                      bottom: viewportHeight * 0.01),
                                  icon: Icon(Icons.my_location,
                                      color: Colors.blue,
                                      size: viewportHeight * 0.03),
                                  labelText: "Latitude",
                                  labelStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: viewportHeight * 0.022),
                                ),
                                readOnly: true,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true, signed: true),
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: viewportHeight * 0.024),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0,
                                  viewportWidth * 0.04, viewportWidth * 0.01),
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = hospitalUserProvider
                                      .getHospital.getLongitude
                                      .toString(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: viewportHeight * 0.01,
                                      bottom: viewportHeight * 0.01),
                                  icon: Icon(Icons.my_location,
                                      color: Colors.blue,
                                      size: viewportHeight * 0.03),
                                  labelText: "Longitude",
                                  labelStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: viewportHeight * 0.022),
                                ),
                                readOnly: true,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true, signed: true),
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: viewportHeight * 0.024),
                              ),
                            ))
                          ]),
                      SizedBox(height: viewportHeight * 0.07),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                showLoadingDialog(context: context);
                                await getLocation().then(
                                  (value) async {
                                    if (value != null) {
                                      locationProvider.setLocation = value;
                                      Hospital hospital =
                                          hospitalUserProvider.getHospital;
                                      hospital.setLatitude = value.latitude;
                                      hospital.setLongitude = value.longitude;
                                      await getNetworkRepository
                                          .updateLocation(
                                        latitude: value.latitude,
                                        longitude: value.longitude,
                                      )
                                          .then((value) {
                                        if (value.statusCode == 200) {
                                          Fluttertoast.showToast(
                                            msg: "Location Updated",
                                          );
                                          hospitalUserProvider.setHospital =
                                              hospital;
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg: "Error in updating location",
                                          );
                                          print(
                                              "Update Location: ${value.statusCode.toString() + value.body.toString()}");
                                        }
                                      }).catchError((error) {
                                        Fluttertoast.showToast(
                                          msg: "Error in updating location",
                                        );
                                        print(
                                            "Update Location: ${error.toString()}");
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Error in fetching location!",
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              },
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              splashColor: Colors.white,
                              color: Colors.green,
                              child: Container(
                                  width: viewportWidth * 0.35,
                                  height: viewportHeight * 0.06,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Update Location',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope",
                                      fontSize: viewportHeight * 0.020,
                                    ),
                                  )),
                              textColor: Colors.white,
                            ),
                            RaisedButton(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                splashColor: Colors.white,
                                color: Colors.blue,
                                child: Container(
                                  width: viewportWidth * 0.3,
                                  height: viewportHeight * 0.06,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Save',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope",
                                      fontSize: viewportHeight * 0.020,
                                    ),
                                  ),
                                ),
                                textColor: Colors.white,
                                onPressed: () async {
                                  showLoadingDialog(context: context);
                                  Hospital hospital =
                                      hospitalUserProvider.getHospital;
                                  hospital.setAddress = address.length == 0
                                      ? hospital.getAddress
                                      : address;
                                  hospital.setName = fullName.length == 0
                                      ? hospital.getName
                                      : fullName;
                                  hospital.setContactNo =
                                      phoneNumber.length == 0
                                          ? hospital.getContactNo
                                          : phoneNumber;
                                  print(phoneNumber);
                                })
                          ]),
                      SizedBox(height: viewportHeight * 0.05),
                    ])))));
  }

  Future<void> getHospitalData() async {
    await getNetworkRepository.getHospitalData().then((value) {
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(value.body);
        Hospital hospital = Hospital.fromJSON(responseMap);
        hospitalUserProvider.setHospital = hospital;
      } else {
        print("getUserProfileData: " +
            value.statusCode.toString() +
            " ${value.body.toString()}");
        Fluttertoast.showToast(msg: "Error in fetching user profile data");
      }
    }).catchError((error) {
      print("getUserProfileData: " + " ${error.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching user profile data");
    });
  }
}
