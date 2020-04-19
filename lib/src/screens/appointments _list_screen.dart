import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/appointment.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
import 'package:hospitality/src/widgets/appointments_list_view_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsListScreen extends StatefulWidget {
  _AppointmentsListScreenState createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  double viewportHeight;
  double viewportWidth;
  bool isPatient = SplashPage.isPatient;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<Appointment> appointmentsList = new List<Appointment>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      if (mounted &&
          refreshIndicatorKey.currentState.mounted &&
          refreshIndicatorKey != null) {
        await refreshIndicatorKey.currentState.show();
      }
    });
  }

  Future<void> getAppointmentsList() async {
    await getNetworkRepository.getAppointmentsList().then((value) async {
      if (value.statusCode == 200) {
        setState(() {
          List<dynamic> responseList = json.decode(value.body);
          Map<String, dynamic> temp;
          appointmentsList = List<Appointment>();
          for (temp in responseList) {
            Appointment appointment = Appointment.fromJSON(temp);
            appointmentsList.add(appointment);
          }
        });
      } else if (value.statusCode == 401) {
        print("Get Hospital Data: ${value.statusCode} Unauthorized access");
        Hospital hospital = Hospital();
        HospitalUserProvider hospitalUserProvider =
            Provider.of<HospitalUserProvider>(context);
        hospitalUserProvider.setHospital = hospital;
        UserProfileProvider userProfileProvider =
            Provider.of<UserProfileProvider>(context);
        User user = User();
        userProfileProvider.setUser = user;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/auth", (Route<dynamic> route) => false);
      } else {
        print(
            "Get Appointments List: ${value.statusCode.toString()} ${value.body.toString()}");
        Fluttertoast.showToast(msg: "Error in fetching appointments list");
      }
    }).catchError((error) {
      print("Get Appointments List: ${error.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching appointments list");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    isPatient=SplashPage.isPatient;
    return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          await getAppointmentsList();
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: viewportHeight * 0.025,
                horizontal: viewportWidth * 0.01),
            child: ListView.builder(
                itemCount: appointmentsList.length,
                addAutomaticKeepAlives: true,
                itemBuilder: (BuildContext context, int index) {
                  return AppointmentsListViewItem(
                      appointment: appointmentsList[index],refreshIndicatorKey: refreshIndicatorKey,);
                })));
  }
}
