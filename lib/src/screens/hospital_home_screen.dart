import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/screens/appointment%20_list.dart';
import 'hospital_info_screen.dart';
import '../helpers/dimensions.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboardState createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  double viewportHeight;
  double viewportWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _hospital(BuildContext context) {
    return HospitalInfo();
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            _hospital(context),
            _hospital(context),
            AppointmentScreen(),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: Hero(
            tag: "ico",
            child: Container(
              margin: EdgeInsets.only(right: viewportWidth * 0.035),
              child: Image.asset('assets/img/splash_bg.png'),
            ),
          ),
          title: Text(
            'Hospitality',
            style: TextStyle(
                fontFamily: "BalooTamma2", fontSize: viewportHeight * 0.03),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontFamily: "Manrope"),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_circle),
                text: 'My Profile',
              ),
              Tab(
                icon: Icon(Icons.event_available),
                text: 'Availability Stats',
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
