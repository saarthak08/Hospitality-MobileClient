import 'package:flutter/material.dart';
import 'package:hospitality/src/models/appointment.dart';

void acceptAppointment(BuildContext context, Appointment appointment) {
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )));
    },
  );
}

void declineAppointment(BuildContext context, Appointment appointment) {
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
                      'Are you sure you want to reject this appointment?',
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )));
    },
  );
}
