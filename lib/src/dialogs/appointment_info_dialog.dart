import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/appointment.dart';
import 'package:hospitality/src/screens/splash_screen.dart';

void showAppointmentInfo(
    {@required BuildContext context, @required Appointment appointment}) {
  double viewportHeight = getViewportHeight(context);
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
                      'Information',
                      style: TextStyle(
                        fontFamily: "BalooTamma2",
                        fontSize: viewportHeight*0.03
                      ),
                    ),
                    content: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Text(
                            'Appointment: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Manrope",
                                fontSize: viewportHeight * 0.022),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Date: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: appointment.getDate,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: "Time: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: appointment.getTime,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: "Status: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: appointment.getStatus,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: appointment.getStatus == "Accepted"
                                          ? Colors.green
                                          : appointment.getStatus == "Pending"
                                              ? Colors.blue
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: "Note Provided: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: '"${appointment.getNote}"',
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          Divider(),
                          Text(
                            SplashPage.isPatient
                                ? 'Booking Appointee Details: '
                                : 'Booking Appointer Details: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Manrope",
                                fontSize: viewportHeight * 0.022),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Name: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: SplashPage.isPatient
                                      ? appointment.getHospital.getName
                                      : appointment.getUser.getFullName,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: "Email: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: SplashPage.isPatient
                                      ? appointment.getHospital.getEmail
                                      : appointment.getUser.getEmail,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: "Contact No.: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: SplashPage.isPatient
                                      ? appointment.getHospital.getPhoneNumber
                                      : appointment.getUser.getPhoneNumber,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: SplashPage.isPatient
                                      ? "Website: "
                                      : "Address: ",
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Manrope"),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: SplashPage.isPatient
                                      ? appointment.getHospital.getWebsite
                                      : appointment.getUser.getAddress,
                                  style: TextStyle(
                                      fontSize: viewportHeight * 0.02,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )
                              ])),
                        ])),
                    actions: <Widget>[
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
