import 'package:flutter/material.dart';
import 'package:hospitality/src/dialogs/appointment_list_view_item_dialogs.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/appointment.dart';
import 'package:hospitality/src/screens/splash_screen.dart';

class AppointmentsListViewItem extends StatelessWidget {
  final Appointment appointment;
  static double viewportHeight;
  static double viewportWidth;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  static bool isPatient;

  AppointmentsListViewItem(
      {@required this.appointment, @required this.refreshIndicatorKey});

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    isPatient = SplashPage.isPatient;
    return Card(
        elevation: 3,
        margin: EdgeInsets.only(
            bottom: viewportHeight * 0.015,
            left: viewportWidth * 0.01,
            right: viewportWidth * 0.01),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.blue,
            onTap: () {},
            child: ListTile(
                trailing: Wrap(
                  children: <Widget>[
                    (appointment.getStatus == "Rejected" ||
                            appointment.getStatus == "rejected"||appointment.getStatus=="Confirmed"||appointment.getStatus=="Confirmed")
                        ? Container(height: 0, width: 0)
                        : IconButton(
                            color: Colors.red,
                            icon: Icon(
                              Icons.cancel,
                              size: viewportHeight * 0.04,
                            ),
                            onPressed: () {
                              declineAppointment(
                                  context, appointment, refreshIndicatorKey);
                            },
                          ),
                    isPatient
                        ? Container(height: 0, width: 0)
                        : (appointment.getStatus == "Confirmed" ||
                                appointment.getStatus == "confirmed" ||
                                appointment.getStatus == "rejected" ||
                                appointment.getStatus == "Rejected")
                            ? Container(height: 0, width: 0)
                            : IconButton(
                                icon: Icon(Icons.check_circle,
                                    size: viewportHeight * 0.04),
                                color: Colors.green,
                                onPressed: () {
                                  acceptAppointment(context, appointment,
                                      refreshIndicatorKey);
                                },
                              ), //
                  ],
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: viewportHeight * 0.01,
                    horizontal: viewportWidth * 0.01),
                leading: Icon(
                  Icons.assignment,
                  size: viewportHeight * 0.05,
                  color: Colors.blue,
                ),
                title: Text(
                  !isPatient
                      ? appointment.getUser.getFullName
                      : appointment.getHospital.getName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: viewportHeight * 0.021,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: "Time: ",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooTamma2"),
                        children: <TextSpan>[
                      TextSpan(
                        text: appointment.getTime,
                        style: TextStyle(
                            fontSize: viewportHeight * 0.018,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Manrope"),
                      ),
                      TextSpan(
                        text: "\nDate: ",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooTamma2"),
                      ),
                      TextSpan(
                        text: appointment.getDate,
                        style: TextStyle(
                            fontSize: viewportHeight * 0.018,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Manrope"),
                      ),
                      TextSpan(
                        text: "\nStatus: ",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooTamma2"),
                      ),
                      TextSpan(
                        text: appointment.getStatus,
                        style: TextStyle(
                            fontSize: viewportHeight * 0.018,
                            color: appointment.getStatus == "confirmed" ||
                                    appointment.getStatus == "Confirmed"
                                ? Colors.green
                                : appointment.getStatus == "Pending" ||
                                        appointment.getStatus == "pending"
                                    ? Colors.blue
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Manrope"),
                      )
                    ])))));
  }
}
