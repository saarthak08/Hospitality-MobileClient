import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/helpers/fetch_user_data.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
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
  HospitalUserProvider hospitalUserProvider;
  String fullName = "";
  String phoneNumber = "";
  String website = "";
  String email = "";
  String note = "";
  bool availability = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      if (mounted &&
          refreshIndicatorKey.currentState.mounted &&
          refreshIndicatorKey != null) {
        await refreshIndicatorKey.currentState.show();
      }
    });
  }

  HospitalProfileEditScreenState();

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    hospitalUserProvider = Provider.of<HospitalUserProvider>(context);
    hospitalUserProvider.addListener(() {
      fullNameController.text = hospitalUserProvider.getHospital.getName;
      phoneNumberController.text =
          hospitalUserProvider.getHospital.getPhoneNumber;
      websiteController.text = hospitalUserProvider.getHospital.getWebsite;
      noteController.text = hospitalUserProvider.getHospital.getNote;
      this.availability = hospitalUserProvider.getHospital.getAvailability;
      latitudeController.text =
          hospitalUserProvider.getHospital.getLatitude.toString();
      longitudeController.text =
          hospitalUserProvider.getHospital.getLongitude.toString();
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
              await fetchHospitalUserData(
                  context: context, hospitalUserProvider: hospitalUserProvider);
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
                              this.website = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(Icons.web,
                                color: Colors.blue,
                                size: viewportHeight * 0.03),
                            labelText: "Website",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.024),
                          controller: websiteController,
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
                          onChanged: (String value) {
                            setState(() {
                              this.note = value;
                            });
                          },
                          maxLines: 2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: viewportHeight * 0.01,
                                bottom: viewportHeight * 0.01),
                            icon: Icon(Icons.note,
                                color: Colors.blue,
                                size: viewportHeight * 0.03),
                            labelText: "Note",
                            labelStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: viewportHeight * 0.022),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.024),
                          controller: noteController,
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
                                controller: latitudeController,
                                onChanged: (String value) {
                                  if (value.length != 0) {
                                    setState(() {
                                      this.latitude = double.parse(value);
                                    });
                                  }
                                },
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
                                controller: longitudeController,
                                onChanged: (String value) {
                                  if (value.length != 0) {
                                    setState(() {
                                      this.longitude = double.parse(value);
                                    });
                                  }
                                },
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
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true, signed: true),
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: viewportHeight * 0.024),
                              ),
                            ))
                          ]),
                      SizedBox(height: viewportHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0,
                                      0.0,
                                      viewportWidth * 0.04,
                                      viewportWidth * 0.01),
                                  child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: "Availability: ",
                                          style: TextStyle(
                                              fontSize: viewportHeight * 0.022,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Manrope"),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (this.availability)
                                                  ? "Available"
                                                  : "Not Available",
                                              style: TextStyle(
                                                  fontSize:
                                                      viewportHeight * 0.022,
                                                  color: (this.availability)
                                                      ? Colors.blue
                                                      : Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins"),
                                            )
                                          ])))),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0,
                                  viewportWidth * 0.2, viewportWidth * 0.01),
                              child: CupertinoSwitch(
                                value: this.availability,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.availability = value;
                                  });
                                },
                                activeColor: Colors.blue,
                              )),
                        ],
                      ),
                      SizedBox(height: viewportHeight * 0.07),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                showGeneralDialog(
                                  context: context,
                                  transitionDuration:
                                      Duration(milliseconds: 200),
                                  barrierDismissible: true,
                                  barrierLabel: '',
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return null;
                                  },
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionBuilder: (context, a1, a2, widget) {
                                    return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                            opacity: a1.value,
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  setState) {
                                                return AlertDialog(
                                                  shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                  title: Text(
                                                    'Confirm your decision!',
                                                    style: TextStyle(
                                                      fontFamily: "BalooTamma2",
                                                    ),
                                                  ),
                                                  content: Text(
                                                    'Are you sure you want to update your location?',
                                                    style: TextStyle(
                                                        fontFamily: "Manrope"),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        await getLocationDialog();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )));
                                  },
                                );
                              },
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              splashColor: Colors.white,
                              color: Colors.green,
                              child: Container(
                                  width: viewportWidth * 0.35,
                                  height: viewportHeight * 0.07,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Auto Update Location',
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
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
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
                                  hospital.setAddress = website.length == 0
                                      ? hospital.getAddress
                                      : website;
                                  hospital.setName = fullName.length == 0
                                      ? hospital.getName
                                      : fullName;
                                  hospital.setPhoneNumber =
                                      phoneNumber.length == 0
                                          ? hospital.getPhoneNumber
                                          : phoneNumber;
                                  hospital.setNote = note.length == 0
                                      ? hospital.getNote
                                      : note;
                                  hospital.setWebsite = website.length == 0
                                      ? hospital.getWebsite
                                      : website;
                                  hospital.setAvailability = this.availability;
                                  hospital.setLatitude = this.latitude == 0
                                      ? hospital.getLatitude
                                      : this.latitude;
                                  hospital.setLongitude = this.longitude == 0
                                      ? hospital.getLongitude
                                      : this.longitude;
                                  await getNetworkRepository
                                      .updateHospitalUserData(
                                          hospital: hospital)
                                      .then((value) {
                                    if (value.statusCode == 200) {
                                      Fluttertoast.showToast(
                                        msg: "Profile Updated",
                                      );
                                      hospitalUserProvider.setHospital =
                                          hospital;
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);

                                      Fluttertoast.showToast(
                                        msg: "Error in updating profile",
                                      );
                                      print(
                                          "Update Profile Hospital: ${value.statusCode.toString() + value.body.toString()}");
                                    }
                                  }).catchError((error) {
                                    print(
                                        "Update Profile Hospital: ${error.toString()}");
                                    Navigator.pop(context);
                                  });
                                  refreshIndicatorKey.currentState.show();
                                })
                          ]),
                      SizedBox(height: viewportHeight * 0.05),
                    ])))));
  }

  Future<void> getLocationDialog() async {
    showLoadingDialog(context: context);
    await getLocation().then(
      (value) async {
        if (value != null) {
          Hospital hospital = hospitalUserProvider.getHospital;
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
              hospitalUserProvider.setHospital = hospital;
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
            print("Update Location: ${error.toString()}");
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
  }
}
