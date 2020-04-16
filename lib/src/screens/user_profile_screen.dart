import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/current_location.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatelessWidget {
  static double viewportHeight;
  static double viewportWidth;
  static LocationProvider locationProvider;

  static UserProfileProvider userProfileProvider;
  static User user;

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    locationProvider = Provider.of<LocationProvider>(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    user = userProfileProvider.getUser;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
            child: Form(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: viewportHeight * 0.02,
                        right: viewportHeight * 0.02,
                        top: viewportHeight * 0.02),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
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
                          initialValue: userProfileProvider.getUser.getEmail,
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
                          initialValue: userProfileProvider.getUser.getFullName,
                        ),
                      ),
                      SizedBox(height: viewportHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0,
                            viewportWidth * 0.04, viewportWidth * 0.01),
                        child: TextFormField(
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
                          initialValue: userProfileProvider.getUser.getPhoneNumber,
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
                          initialValue: userProfileProvider.getUser.getAddress,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: viewportHeight * 0.024),
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
                                initialValue: userProfileProvider.getUser.getLatitude.toString(),
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
                                initialValue: userProfileProvider.getUser.getLongitude.toString(),
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
                              onPressed: () {
                                getLocation().then(
                                  (value) {
                                    if (value != null) {
                                      locationProvider.setLocation = value;
                                      showLoadingDialog(context: context);
                                      Fluttertoast.showToast(
                                        msg: "Location Updated",
                                        //TODO Update Location Variables here!
                                      );
                                      Navigator.pop(context);
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
                                onPressed: () {})
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
                    ])))));
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
