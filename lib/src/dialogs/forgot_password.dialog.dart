import 'package:flutter/material.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/dialogs/set_password_dialog.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:provider/provider.dart';

void showForgotPasswordDialog(BuildContext mainContext) {
  bool isDisabled = true;
  String email = "";
  double viewportHeight = getViewportHeight(mainContext);
  double viewportWidth = getViewportWidth(mainContext);
  showGeneralDialog(
      context: mainContext,
      pageBuilder: (context, anim1, anim2) {
        return null;
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, child) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: StatefulBuilder(builder: (BuildContext build, setState) {
                  return AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    title: Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                          email = "";
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: isDisabled ? Colors.grey : Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          if (email.length != 0) {
                            Navigator.pop(context);
                            sendPasswordResetLink(email, mainContext);
                          }
                        },
                      ),
                    ],
                    content: Container(
                      width: viewportWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        onChanged: (String value) {
                          if (value != null || value.length != 0) {
                            setState(() {
                              isDisabled = false;
                              email = value;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: viewportHeight * 0.01,
                            bottom: viewportHeight * 0.01,
                          ),
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: viewportHeight * 0.022,
                          ),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          labelText: "Email*",
                          labelStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: viewportHeight * 0.02),
                        ),
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: viewportHeight * 0.022),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  );
                })));
      });
}

void sendPasswordResetLink(String email, BuildContext context) async {
  UserProfileProvider userProfileProvider =
      Provider.of<UserProfileProvider>(context, listen: false);
  User user = userProfileProvider.getUser;
  user.setEmail = email;
  userProfileProvider.setUser = user;
  showLoadingDialog(context: context);
  Navigator.pop(context);
  setPasswordDialog(email, context);
  /*await getNetworkRepository.forgotPassword(email: email).then((value) {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Password reset link sent!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      Navigator.pushNamed(context, "/forgot-password");
    } else if (value.statusCode == 404) {
      Fluttertoast.showToast(
        msg: "Error! User doesn't exist",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Error! Password reset link not sent",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    }
  }).catchError((error) {
    Fluttertoast.showToast(
      msg: "Error! Password reset link not sent",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
    Navigator.pop(context);
  });*/
}
