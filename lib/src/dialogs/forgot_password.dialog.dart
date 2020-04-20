import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/dialogs/set_password_dialog.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';

Future<void> showForgotPasswordDialog(BuildContext mainContext) async {
  bool isDisabled = true;
  String email = "";
  int _radioValue = 0;
  bool _isPatient = true;

  double viewportHeight = getViewportHeight(mainContext);
  double viewportWidth = getViewportWidth(mainContext);
  await showGeneralDialog(
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
                        onPressed: () async {
                          if (email.length != 0 &&
                              email.contains("@") &&
                              email.endsWith(".com")) {
                            await sendPasswordResetLink(
                                email, mainContext, _isPatient);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Invalid email address");
                          }
                        },
                      ),
                    ],
                    content: Container(
                        width: viewportWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView(shrinkWrap: true, children: [
                          Text("Select your User Type:"),
                          Container(
                              alignment: Alignment.center,
                              height: viewportHeight * 0.045,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioValue = value;

                                        switch (_radioValue) {
                                          case 0:
                                            _isPatient = true;
                                            break;
                                          case 1:
                                            _isPatient = false;
                                            break;
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    "Patient",
                                    style: TextStyle(
                                        fontFamily: "BalooTamma2",
                                        fontSize: viewportWidth * 0.045),
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioValue = value;

                                        switch (_radioValue) {
                                          case 0:
                                            _isPatient = true;
                                            break;
                                          case 1:
                                            _isPatient = false;
                                            break;
                                        }
                                      });
                                    },
                                  ),
                                  Text("Hospital",
                                      style: TextStyle(
                                          fontFamily: "BalooTamma2",
                                          fontSize: viewportWidth * 0.045))
                                ],
                              )),
                          SizedBox(
                            height: viewportHeight * 0.01,
                          ),
                          TextFormField(
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
                          SizedBox(height: viewportHeight * 0.015),
                        ])),
                  );
                })));
      });
}

Future<void> sendPasswordResetLink(
    String email, BuildContext context, bool isPatient) async {
  showLoadingDialog(context: context);
  String userType = isPatient ? "Patient" : "Hospital";
  await getNetworkRepository
      .sendForgotPasswordLink(email: email, userType: userType)
      .then((value) async {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Password reset link sent!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      await setPasswordDialog(email, context);
    } else if (value.statusCode == 404) {
      Fluttertoast.showToast(
        msg: "Error! User doesn't exist or wrong user type selected.",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Error! Password reset link not sent",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }).catchError((error) {
    Fluttertoast.showToast(
      msg: "Error! Password reset link not sent",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  });
}
