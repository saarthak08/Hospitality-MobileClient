import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/appointment.dart';
import 'package:hospitality/src/widgets/appointments_list_view_item.dart';

class AppointmentsListScreen extends StatefulWidget {
  _AppointmentsListScreenState createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  double viewportHeight;
  double viewportWidth;
  List<Appointment> appointmentsList = new List<Appointment>();

  @override
  void initState() {
    super.initState();
    appointmentsList.add(Appointment(
        date: "10/12/1990", hospitalName: "JNMC AMU", status: "Accepted"));
    appointmentsList.add(Appointment(
        date: "10/10/1999", hospitalName: "AIIMS Delhi", status: "Accepted"));
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: viewportHeight * 0.025, horizontal: viewportWidth * 0.01),
        child: ListView.builder(
            itemCount: appointmentsList.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              return AppointmentsListViewItem(
                  appointment: appointmentsList[index]);
            }));
  }
}
