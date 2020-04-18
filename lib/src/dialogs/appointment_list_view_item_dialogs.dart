import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/models/appointment.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/splash_screen.dart';

Future<void> acceptAppointment(BuildContext context, Appointment appointment,
    GlobalKey<RefreshIndicatorState> refreshIndicatorKey) {
  showGeneralDialog(
    context: context,
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation1, animation2) {
      return null;
    },
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(
                      'Confirm your decision!',
                      style: TextStyle(
                        fontFamily: "BalooTamma2",
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to accept this appointment?',
                      style: TextStyle(fontFamily: "Manrope"),
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
                          Navigator.of(context).pop();
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
                          String email = "";
                          email = appointment.getUser.getEmail;
                          await _changeStatus(
                              context: context,
                              email: email,
                              timestamp: appointment.getTimestamp,
                              status: "Confirmed");
                          refreshIndicatorKey.currentState.show();
                        },
                      ),
                    ],
                  );
                },
              )));
    },
  );
  return null;
}

Future<void> _changeStatus(
    {String email, String status, BuildContext context,@required int timestamp}) async {
  showLoadingDialog(context: context);

  await getNetworkRepository
      .changeAppointmentStatus(
    email: email,
    status: status,
    timestamp: timestamp
  )
      .then((value) {
    Navigator.pop(context);
    Navigator.pop(context);
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Appointment status changed to $status successfully.");
    } else {
      print(
          "Change appointment status: ${value.statusCode} ${value.body.toString()}");
      Fluttertoast.showToast(msg: "Error in changing appointment status");
    }
  }).catchError((error) {
    Navigator.pop(context);
    Navigator.pop(context);
    print("Change appointment status: ${error.toString()}");
    Fluttertoast.showToast(msg: "Error in changing appointment status");
  });

  return null;
}

Future<void> declineAppointment(BuildContext context, Appointment appointment,
    GlobalKey<RefreshIndicatorState> refreshIndicatorKey) {
  showGeneralDialog(
    context: context,
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation1, animation2) {
      return null;
    },
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(
                      'Confirm your decision!',
                      style: TextStyle(
                        fontFamily: "BalooTamma2",
                      ),
                    ),
                    content: Text(
                      SplashPage.isPatient
                          ? "Are you sure you want to delete this appointment?"
                          : 'Are you sure you want to reject this appointment?',
                      style: TextStyle(fontFamily: "Manrope"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () async {
                          if (SplashPage.isPatient) {
                            showLoadingDialog(context: context);
                            await getNetworkRepository
                                .deleteAppointmentStatus(
                                  timestamp: appointment.getTimestamp,
                                    email: appointment.getHospital.getEmail)
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);

                              if (value.statusCode == 200) {
                                Fluttertoast.showToast(
                                    msg: "Appointment deleted successfully");
                              } else {
                                print(
                                    "Error in deleting appointment: ${value.statusCode} ${value.body.toString()}");
                                Fluttertoast.showToast(
                                    msg: "Error in deleting appointment");
                              }
                            }).catchError((error) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              print(
                                  "Error in deleting appointment: ${error.toString()}");
                              Fluttertoast.showToast(
                                  msg: "Error in deleting appointment");
                            });
                            refreshIndicatorKey.currentState.show();
                          } else {
                            await _changeStatus(
                                context: context,
                                timestamp: appointment.getTimestamp,
                                email: appointment.getUser.getEmail,
                                status: "Rejected");
                            refreshIndicatorKey.currentState.show();
                          }
                        },
                      ),
                    ],
                  );
                },
              )));
    },
  );
  return null;
}
