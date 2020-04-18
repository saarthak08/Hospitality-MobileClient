import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/appointments%20_list_screen.dart';
import 'package:hospitality/src/screens/hospital_info_screen.dart';
import 'package:hospitality/src/screens/hospital_stats_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/dimensions.dart';


class HospitalDashboard extends StatefulWidget {
  static int tabIndex=0;

  @override
  _HospitalDashboardState createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  double viewportHeight;
  double viewportWidth;
  HospitalUserProvider hospitalUserProvider;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    HospitalDashboard.tabIndex=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hospitalUserProvider=Provider.of<HospitalUserProvider>(context);
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: () async {
              if(HospitalDashboard.tabIndex==0) {
                await getHospitalData();
              }
            },
            child: TabBarView(
              children: <Widget>[
                HospitalInfo(refreshIndicatorKey: refreshIndicatorKey,),
                HospitalStats(),
                AppointmentsListScreen(),
              ],
            )),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Hospitality',
            style: TextStyle(
                fontFamily: "BalooTamma2", fontSize: viewportHeight * 0.045),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontFamily: "Manrope"),
            tabs: <Widget>[
              Tab(
                icon: Hero(
                  tag: "ico",
                  child: Container(
                    height: viewportHeight * 0.045,
                    child: Image.asset('assets/img/splash_bg.png'),
                  ),
                ),
                text: 'My Profile',
              ),
              Tab(
                icon: Icon(Icons.event_available),
                text: 'Stats',
              ),
              Tab(
                icon: Icon(Icons.message),
                text: 'Appointments',
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> getHospitalData() async {
    await getNetworkRepository.getHospitalData().then((value) {
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(value.body);
        Hospital hospital=Hospital.fromJSON(responseMap);
          hospitalUserProvider.setHospital=hospital;
      } else {
        print("getUserProfileData: " +
            value.statusCode.toString() +
            " ${value.body.toString()}");
        Fluttertoast.showToast(msg: "Error in fetching user profile data");
      }
    }).catchError((error) {
      print("getUserProfileData: " + " ${error.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching user profile data");
    });
  }
}
