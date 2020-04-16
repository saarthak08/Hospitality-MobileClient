import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/appointment%20_list.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/dimensions.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HospitalDashboardState();
  }
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserProfileProvider userProfileProvider;

  Widget body() {
    return Container(
      color: Color(0xffeff1f3),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                height: getDeviceHeight(context) * 0.4,
                child: Image.asset(
                  'assets/img/dashboard_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              SizedBox(height: getDeviceHeight(context) * 0.50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          BouncyPageRoute(widget: AppointmentScreen()));
                    },
                    child: Container(
                      height: getDeviceHeight(context) * 0.18,
                      width: getDeviceWidth(context) * 0.4,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Icon(Icons.list,
                                size: 30, color: Colors.black87),
                          ),
                          Text('Appointment')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          BouncyPageRoute(widget: AppointmentScreen()));
                    },
                    child: Container(
                      height: getDeviceHeight(context) * 0.18,
                      width: getDeviceWidth(context) * 0.4,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Icon(Icons.timeline,
                                size: 30, color: Colors.black87),
                          ),
                          Text('Availability')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getViewportHeight(context)*0.1,),
              RaisedButton(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    splashColor: Colors.blue,
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                    child: Container(
                      width: getViewportWidth(context) * 0.4,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                              child: Icon(
                            Icons.settings_power,
                            size: 35,
                            color: Colors.blue,
                          )),
                        ],
                      ),
                    )),],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userProfileProvider=Provider.of<UserProfileProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: SideDrawer(),
      appBar: AppBar(
        leading: Hero(
          tag: "ico",
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: getViewportWidth(context) * 0.02),
            height: getDeviceHeight(context) * 0.1,
            width: getDeviceWidth(context) * 0.1,
            child: Image.asset('assets/img/splash_bg.png'),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: GestureDetector(onTap: () {}, child: Text('Hospital Dashboard')),
        centerTitle: true,
      ),
      body: body(),
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
                            User user = User();
                            userProfileProvider.setUser = user;
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
                      title: Text("Log Out"),
                      content: Container(
                        width: getViewportWidth(context),
                        child: Text("Are you sure want to log out?"),
                        padding: EdgeInsets.all(5),
                      ),
                    );
                  })));
        },
        transitionDuration: Duration(milliseconds: 200));
  }
}



