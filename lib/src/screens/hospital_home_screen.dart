import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/screens/appointments%20_list_screen.dart';
import 'package:hospitality/src/screens/hospital_info_screen.dart';
import 'package:hospitality/src/screens/hospital_stats_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/dimensions.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboardState createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  double viewportHeight;
  double viewportWidth;
  HospitalUserProvider hospitalUserProvider;

  @override
  Widget build(BuildContext context) {
    hospitalUserProvider = Provider.of<HospitalUserProvider>(context);
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            HospitalInfo(),
            HospitalStats(),
            AppointmentsListScreen(),
          ],
        ),
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
}