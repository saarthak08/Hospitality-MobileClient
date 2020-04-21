import 'package:flutter/material.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/user_home_screen.dart';
import 'package:hospitality/src/screens/hospital_home_screen.dart';
import 'package:hospitality/src/widgets/scale_page_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'dart:async';

import '../helpers/dimensions.dart';
import 'auth_screen.dart';

class SplashPage extends StatefulWidget {
  static bool isPatient;

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  String token = "";
  String email = "";
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));

    Timer(Duration(seconds: 3), () {
      _isLoggedIn().then((isLoggedIn) async {
        if (isLoggedIn) {
          SharedPreferences instance = await SharedPreferences.getInstance();
          email = instance.getString("email");
          await instance.setString("token", token);
          SplashPage.isPatient = instance.getBool("isPatient");
          if (SplashPage.isPatient != null) {
            if (SplashPage.isPatient) {
              _controller.stop();
              setUser();
              Navigator.pushReplacement(
                  context, ScalePageRoute(page: UserHomeScreen()));
            } else {
              setHospital();
              _controller.stop();
              Navigator.pushReplacement(
                  context, ScalePageRoute(page: HospitalDashboard()));
            }
          } else {
            _controller.stop();
            Navigator.pushReplacementNamed(context, "/auth");
          }
        } else {
          _controller.stop();
          Navigator.pushReplacementNamed(context, "/auth");
        }
      });
    });
  }

  Future<void> setHospital() async {
    Hospital hospital = Hospital();
    HospitalUserProvider hospitalUserProvider =
        Provider.of<HospitalUserProvider>(context, listen: false);
    hospital.setEmail = email;
    hospitalUserProvider.setHospital = hospital;
  }

  Future<void> setUser() async {
    User user = User();
    UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    user.setEmail = email;
    userProfileProvider.setUser = user;
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    getNetworkRepository.token = token;
    if (token == null || token.length == 0) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(children: <Widget>[
            SlideTransition(
                position: _offsetAnimation,
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: "ico",
                      child: Container(
                        height: getDeviceHeight(context) * 0.60,
                        width: getDeviceWidth(context) * 0.60,
                        child: Image.asset('assets/img/splash_bg.png'),
                      ),
                    ))),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: getViewportHeight(context) * 0.6),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Hospitality',
                      style: TextStyle(
                          color: Color(0xff00008b),
                          fontFamily: "Manrope",
                          fontSize: getDeviceHeight(context) * 0.06,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getDeviceHeight(context) * 0.05),
                    Text(
                      '"We are here to help."',
                      style: TextStyle(
                          fontFamily: "Ubuntu",
                          color: Colors.blue,
                          fontSize: getDeviceHeight(context) * 0.03),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
