import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/screens/appointment%20_list.dart';
import 'package:hospitality/src/screens/stats_screen.dart';
import 'hospital_info_screen.dart';
import '../helpers/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  _HospitalDashboardState createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  double viewportHeight;
  double viewportWidth;

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
            Container(
              height: 200,
              color: Colors.yellow,
              child: RaisedButton(
                onPressed: () => showLogoutDialog(context),
                child: Text('logout'),
              ),
            ),
            HospitalStats(),
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

  void showLogoutDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return null;
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierLabel: '',
        transitionBuilder: (context, a1, a2, child) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child:
                      StatefulBuilder(builder: (BuildContext build, setState) {
                    return AlertDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/auth", (Route<dynamic> route) => false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      title: Text("Sign Out"),
                      content: Container(
                        width: viewportWidth,
                        child: Text("Are you sure want to sign out?"),
                        padding: EdgeInsets.all(5),
                      ),
                    );
                  })));
        },
        transitionDuration: Duration(milliseconds: 200));
  }
}
