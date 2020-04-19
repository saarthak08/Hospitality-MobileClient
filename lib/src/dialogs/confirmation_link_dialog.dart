import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';

int confirmationLinkCounter = 0;

Future<void> sendConfirmationLink(
    String email, BuildContext context, bool isPatient) async {
  confirmationLinkCounter++;
  if (confirmationLinkCounter > 3) {
    Fluttertoast.showToast(msg: "Can't send more links! Try again later.");
    return;
  }
  showLoadingDialog(context: context);
  String userType = isPatient ? "Patient" : "Hospital";
  await getNetworkRepository
      .sendConfirmationLinkAgain(email: email, userType: userType)
      .then((value) {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Confirmation link sent!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Error! Confirmation link not sent",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    }
  }).catchError((error) {
    print(error);
    Fluttertoast.showToast(
      msg: "Error! Confirmation link not sent",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
    Navigator.pop(context);
  });
}

Future<void> checkConfirmationLinkCode(
    String email, BuildContext context, String code) async {
  showLoadingDialog(context: context);
  await getNetworkRepository
      .checkConfirmationLinkCode(email: email, code: code)
      .then((value) {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Account activated successfully",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      Navigator.pop(context);
    } else if (value.statusCode == 401) {
      Fluttertoast.showToast(
        msg: "Incorrect confirmation code.",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Error in activating account.",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    }
  }).catchError((error) {
    print(error);
    Fluttertoast.showToast(
      msg: "Error in activating accoint.",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
    Navigator.pop(context);
  });
}

Future<void> showConfirmationDialog(
    String email, BuildContext mainContext, bool isPatient) async {
  double viewportHeight = getViewportHeight(mainContext);
  double viewportWidth = getViewportWidth(mainContext);
  bool isDisabled = true;
  String code = "";
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
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(
                      "Account Activation",
                      textAlign: TextAlign.center,
                    ),
                    content: Container(
                        child: Container(
                            width: getViewportWidth(context),
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Text(
                                    "Your account \'$email\' is currently not activated. Please activate your account by entering the code sent to $email."),
                                Container(
                                  width: viewportWidth,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      if (value != null || value.length != 0) {
                                        setState(() {
                                          isDisabled = false;
                                          code = value;
                                        });
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
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2)),
                                      labelText: "Code*",
                                      labelStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: viewportHeight * 0.02),
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: viewportHeight * 0.022),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ))),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancel",
                            style: TextStyle(
                              color: Colors.red,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Send Code Again",
                            style: TextStyle(
                              color: Color(0xff5db646),
                            )),
                        onPressed: () async {
                          await sendConfirmationLink(
                              email, mainContext, isPatient);
                        },
                      ),
                      FlatButton(
                        child: Text("Activate",
                            style: TextStyle(
                              color: isDisabled ? Colors.grey : Colors.blue,
                            )),
                        onPressed: () async {
                          if (!isDisabled) {
                            await checkConfirmationLinkCode(
                                email, context, code);
                          }
                        },
                      ),
                    ],
                  );
                })));
      });
}
