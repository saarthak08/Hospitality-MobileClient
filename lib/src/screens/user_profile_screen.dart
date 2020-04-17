import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/user_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  UserProfileScreen({@required this.refreshIndicatorKey});

  @override
  State<StatefulWidget> createState() {
    return UserProfilScreenState(refreshIndicatorKey: refreshIndicatorKey);
  }
}

class UserProfilScreenState extends State<UserProfileScreen> {
  double viewportHeight;
  double viewportWidth;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  LocationProvider locationProvider;
  UserProfileProvider userProfileProvider;
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
    Future.delayed(Duration.zero, () async {
      refreshIndicatorKey.currentState.show();
    });
  }

  UserProfilScreenState({@required this.refreshIndicatorKey});

  @override
  Widget build(BuildContext context) {
    UserHomeScreen.tabIndex = 1;
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    locationProvider = Provider.of<LocationProvider>(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    userProfileProvider.addListener(() {
      fullNameController.text = userProfileProvider.getUser.getFullName;
      phoneNumberController.text = userProfileProvider.getUser.getPhoneNumber;
      addressController.text = userProfileProvider.getUser.getAddress;
    });

    return GestureDetector(
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
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
                child: TextFormField(
                  controller: TextEditingController()
                    ..text = userProfileProvider.getUser.getEmail,
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
                      fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
                ),
              ),
              SizedBox(height: viewportHeight * 0.02),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
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
                      fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
                ),
              ),
              SizedBox(height: viewportHeight * 0.02),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
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
                        color: Colors.blue, size: viewportHeight * 0.03),
                    labelText: "Phone Number",
                    labelStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: viewportHeight * 0.022),
                  ),
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                      fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
                ),
              ),
              SizedBox(height: viewportHeight * 0.02),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
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
                        color: Colors.blue, size: viewportHeight * 0.03),
                    labelText: "Address",
                    labelStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: viewportHeight * 0.022),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: "Manrope", fontSize: viewportHeight * 0.024),
                  controller: addressController,
                ),
              ),
              SizedBox(height: viewportHeight * 0.02),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
                      child: TextFormField(
                        controller: TextEditingController()
                          ..text = userProfileProvider.getUser.getLatitude
                              .toString(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: viewportHeight * 0.01,
                              bottom: viewportHeight * 0.01),
                          icon: Icon(Icons.my_location,
                              color: Colors.blue, size: viewportHeight * 0.03),
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
                      padding: EdgeInsets.fromLTRB(
                          0.0, 0.0, viewportWidth * 0.04, viewportWidth * 0.01),
                      child: TextFormField(
                        controller: TextEditingController()
                          ..text = userProfileProvider.getUser.getLongitude
                              .toString(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: viewportHeight * 0.01,
                              bottom: viewportHeight * 0.01),
                          icon: Icon(Icons.my_location,
                              color: Colors.blue, size: viewportHeight * 0.03),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                RaisedButton(
                  onPressed: () async {
                    showLoadingDialog(context: context);
                    await getLocation().then(
                      (value) async {
                        if (value != null) {
                          locationProvider.setLocation = value;
                          User user = userProfileProvider.getUser;
                          user.setLatitude = value.latitude;
                          user.setLongitude = value.longitude;
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
                              userProfileProvider.setUser = user;
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                msg: "Error in updating location",
                              );
                              print(
                                  "Update Location: ${value.statusCode.toString() + value.body.toString()}");
                              Navigator.pop(context);
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
                        refreshIndicatorKey.currentState.show();
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
                      User user = userProfileProvider.getUser;
                      user.setAddress =
                          address.length == 0 ? user.getAddress : address;
                      user.setFullName =
                          fullName.length == 0 ? user.getFullName : fullName;
                      user.setPhoneNumber = phoneNumber.length == 0
                          ? user.getPhoneNumber
                          : phoneNumber;
                      print(phoneNumber);
                      await getNetworkRepository
                          .updatePatientUserData(user: user)
                          .then((value) {
                        if (value.statusCode == 200) {
                          Fluttertoast.showToast(
                            msg: "Profile Updated",
                          );
                          userProfileProvider.setUser = user;
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);

                          Fluttertoast.showToast(
                            msg: "Error in updating profile",
                          );
                          print(
                              "Update Profile Patient: ${value.statusCode.toString() + value.body.toString()}");
                        }
                      }).catchError((error) {
                        print("Update Profile Patient: ${error.toString()}");
                        Navigator.pop(context);
                      });
                      refreshIndicatorKey.currentState.show();
                    })
              ]),
              SizedBox(height: viewportHeight * 0.05),
              RaisedButton(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2)),
                  splashColor: Colors.blue,
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  child: Container(
                    width: viewportWidth * 0.4,
                    margin:
                        EdgeInsets.symmetric(horizontal: viewportWidth * 0.005),
                    padding: EdgeInsets.only(
                        top: viewportHeight * 0.012,
                        bottom: viewportHeight * 0.012),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: viewportWidth * 0.02),
                          child: Text(
                            "Sign Out",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: viewportWidth * 0.05,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                            child: Icon(
                          Icons.power_settings_new,
                          size: viewportWidth * 0.075,
                          color: Colors.blue,
                        )),
                      ],
                    ),
                  )),
            ])));
  }

  void showLogoutDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return null;
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierLabel: '',
        transitionBuilder: (context, a1, a2, child) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child:
                      StatefulBuilder(builder: (BuildContext build, setState) {
                    return AlertDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () async {
                            User user = User();
                            userProfileProvider.setUser = user;
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/auth", (Route<dynamic> route) => false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      title: Text("Sign Out"),
                      content: Container(
                        width: viewportWidth,
                        child: Text("Are you sure want to sign out?"),
                        padding: EdgeInsets.all(5),
                      ),
                    );
                  })));
        },
        transitionDuration: Duration(milliseconds: 200));
  }
}
