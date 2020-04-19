import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';

void setPasswordDialog(String email, BuildContext context) async {
  bool _obscureText = true;
  String password = "";
  String confirmPassword = "";
  String verificationCode = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double viewportHeight = getViewportHeight(context);
  double viewportWidth = getViewportWidth(context);

  showGeneralDialog(
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
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color:Colors.blue
                            ),
                          ),
                          onPressed: () {
                            if(!_formKey.currentState.validate()) {
                              return null;
                            }
                            
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
                                      Container(
                                          width: viewportWidth,
                                          height: viewportHeight * 0.1,
                                          child: Text(
                                            "An email has been sent to $email with a verification code.\nEnter the verification code:",
                                            style: TextStyle(
                                              fontFamily: "Manrope",
                                            ),
                                          )),
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
                                            keyboardType: TextInputType.text),
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
                                      SizedBox(height: viewportHeight * 0.01),
                                    ]),
                              ))));
                })));
      });
}
