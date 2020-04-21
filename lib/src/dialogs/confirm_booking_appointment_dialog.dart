import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/loading_dialog.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';

void confirmAppointment(
    {@required BuildContext context,
    @required String note,
    @required String hospitalEmail}) {
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
                        borderRadius: BorderRadius.circular(10.0)),
                    title: Text(
                      'Confirm your decision!',
                      style: TextStyle(
                        fontFamily: "BalooTamma2",
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to book the appointment?',
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
                          showLoadingDialog(context: context);
                          await getNetworkRepository
                              .bookAppointment(
                                  hospitalEmail: hospitalEmail, note: note)
                              .then((value) {
                            if (value.statusCode == 200) {
                              Fluttertoast.showToast(
                                  msg: "Appointment booked succesfully");
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                            } else {
                              print(
                                  "Book Appointment: ${value.statusCode} ${value.body.toString()}");
                              Fluttertoast.showToast(
                                  msg: "Error in booking appointment.");
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                            }
                          }).catchError((error) {
                            print("Book Appointment: ${error.toString()}");
                            Fluttertoast.showToast(
                                msg: "Error in booking appointment.");
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                          });
                        },
                      ),
                    ],
                  );
                },
              )));
    },
  );
}
