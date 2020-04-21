import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/helpers/fetch_user_data.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return UserProfilScreenState();
  }
}

class UserProfilScreenState extends State<UserProfileScreen> {
  double viewportHeight;
  double viewportWidth;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  UserProfileProvider userProfileProvider;
  String fullName = "";
  String phoneNumber = "";
  String address = "";
  String email = "";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    userProfileProvider.addListener(() {
      fullNameController.text = userProfileProvider.getUser.getFullName;
      phoneNumberController.text = userProfileProvider.getUser.getPhoneNumber;
      addressController.text = userProfileProvider.getUser.getAddress;
      latitudeController.text =
          userProfileProvider.getUser.getLatitude.toString();
      longitudeController.text =
          userProfileProvider.getUser.getLongitude.toString();
    });

    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await fetchPatientUserData(
              context: context, userProfileProvider: userProfileProvider);
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
                child: ListView(
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
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
                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Error in updating location",
                                          );
                                          print(
                                              "Update Location: ${value.statusCode.toString() + value.body.toString()}");
                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                        }
                                      }).catchError((error) {
                                        Fluttertoast.showToast(
                                          msg: "Error in updating location",
                                        );
                                        print(
                                            "Update Location: ${error.toString()}");
                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Error in fetching location!",
                                      );
                                      Navigator.of(context, rootNavigator: true).pop('dialog');
                                    }
                                    _refreshIndicatorKey.currentState.show();
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
                                  height: viewportHeight * 0.06,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Auto Update Location',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope",
                                      fontSize: viewportHeight * 0.019,
                                    ),
                                  )),
                              textColor: Colors.white,
                            ),
                            MaterialButton(
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
                                  User user = userProfileProvider.getUser;
                                  user.setAddress = address.length == 0
                                      ? user.getAddress
                                      : address;
                                  user.setFullName = fullName.length == 0
                                      ? user.getFullName
                                      : fullName;
                                  user.setPhoneNumber = phoneNumber.length == 0
                                      ? user.getPhoneNumber
                                      : phoneNumber;
                                  user.setLatitude = latitude == 0
                                      ? user.getLatitude
                                      : latitude;
                                  user.setLongitude = longitude == 0
                                      ? user.getLongitude
                                      : longitude;
                                  await getNetworkRepository
                                      .updatePatientUserData(user: user)
                                      .then((value) {
                                    if (value.statusCode == 200) {
                                      Fluttertoast.showToast(
                                        msg: "Profile Updated",
                                      );
                                      userProfileProvider.setUser = user;
                                      Navigator.of(context, rootNavigator: true).pop('dialog');
                                    } else {
                                      Navigator.of(context, rootNavigator: true).pop('dialog');

                                      Fluttertoast.showToast(
                                        msg: "Error in updating profile",
                                      );
                                      print(
                                          "Update Profile Patient: ${value.statusCode.toString() + value.body.toString()}");
                                    }
                                  }).catchError((error) {
                                    print(
                                        "Update Profile Patient: ${error.toString()}");
                                    Navigator.of(context, rootNavigator: true).pop('dialog');
                                  });
                                  _refreshIndicatorKey.currentState.show();
                                })
                          ]),
                      SizedBox(height: viewportHeight * 0.05),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: viewportWidth * 0.2),
                        child: RaisedButton(
                            color: Colors.white,
                            elevation: 3,
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: viewportWidth * 0.005),
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
                      )
                    ]))));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      if (mounted &&
          _refreshIndicatorKey != null &&
          _refreshIndicatorKey.currentState.mounted) {
        _refreshIndicatorKey.currentState.show();
      }
    });
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
                            Navigator.of(context, rootNavigator: true).pop('dialog');
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
