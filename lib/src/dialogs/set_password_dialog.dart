import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';

Future<void> setPasswordDialog(String email, BuildContext context) async {
  bool _obscureText = true;
  String password = "";
  String confirmPassword = "";
  String verificationCode = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double viewportHeight = getViewportHeight(context);
  double viewportWidth = getViewportWidth(context);

  await showGeneralDialog(
      context: context,
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
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return null;
                            }
                            await setPassword(
                                email, password, verificationCode, context);
                          },
                        ),
                      ],
                      content: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                              width: viewportWidth,
                              child: Form(
                                key: _formKey,
                                child: ListView(
                                    addAutomaticKeepAlives: true,
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Text(
                                        "An email has been sent to $email with a verification code.\nEnter the verification code:",
                                        style: TextStyle(
                                          fontFamily: "Manrope",
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                            onChanged: (String value) {
                                              if (value != null ||
                                                  value.length != 0) {
                                                setState(() {
                                                  verificationCode = value;
                                                });
                                              }
                                            },
                                            validator: (String value) {
                                              if (value.length <= 0) {
                                                return "Code can't be empty";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                top: viewportHeight * 0.01,
                                                bottom: viewportHeight * 0.01,
                                              ),
                                              icon: Icon(
                                                Icons.vpn_key,
                                                color: Colors.blue,
                                                size: viewportHeight * 0.022,
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2)),
                                              labelText: "Code*",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize:
                                                      viewportHeight * 0.02),
                                            ),
                                            style: TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize:
                                                    viewportHeight * 0.022),
                                            keyboardType: TextInputType.number),
                                      ),
                                      SizedBox(height: viewportHeight * 0.02),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          onChanged: (String value) {
                                            if (value != null ||
                                                value.length != 0) {
                                              setState(() {
                                                password = value;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              top: viewportHeight * 0.01,
                                              bottom: viewportHeight * 0.01,
                                            ),
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.blue,
                                              size: viewportHeight * 0.022,
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2)),
                                            labelText: "Password*",
                                            labelStyle: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize:
                                                    viewportHeight * 0.02),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(_obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontFamily: "Manrope",
                                              fontSize: viewportHeight * 0.022),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: _obscureText,
                                          validator: (String value) {
                                            if (value.length < 6) {
                                              return "Password must be of minimum 6 characters";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: viewportHeight * 0.01),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          onChanged: (String value) {
                                            if (value != null ||
                                                value.length != 0) {
                                              setState(() {
                                                confirmPassword = value;
                                              });
                                            }
                                          },
                                          validator: (String value) {
                                            if (value.length < 6) {
                                              return "Password must be of minimum 6 characters";
                                            } else if (value != password) {
                                              return "Doesn't match with password";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              top: viewportHeight * 0.01,
                                              bottom: viewportHeight * 0.01,
                                            ),
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.blue,
                                              size: viewportHeight * 0.022,
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2)),
                                            labelText: "Confirm Password*",
                                            labelStyle: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize:
                                                    viewportHeight * 0.02),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              child: Icon(_obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontFamily: "Manrope",
                                              fontSize: viewportHeight * 0.022),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: _obscureText,
                                          autovalidate:
                                              confirmPassword.length == 0 &&
                                                      password.length == 0
                                                  ? false
                                                  : true,
                                        ),
                                      ),
                                      SizedBox(height: viewportHeight * 0.015),
                                    ]),
                              ))));
                })));
      });
}

Future<void> setPassword(
    String email, String password, String code, BuildContext context) async {
  showLoadingDialog(context: context);
  await getNetworkRepository
      .setPasswordForgotPassword(code: code, email: email, password: password)
      .then((value) {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(msg: "Password reset successfully");
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } else if (value.statusCode == 401) {
      Fluttertoast.showToast(msg: "Incorrect verification code");
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } else {
      Fluttertoast.showToast(msg: "Error in changing password");
      print("Change password: ${value.statusCode} ${value.body.toString()}");
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  }).catchError((error) {
    Fluttertoast.showToast(msg: "Error in changing password");
    print("Change password: ${error.toString()}");
    Navigator.of(context, rootNavigator: true).pop('dialog');
  });
}
