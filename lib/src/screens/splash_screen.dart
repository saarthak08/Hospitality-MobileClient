import 'package:flutter/material.dart';
import 'package:hospitality/src/screens/home_screen.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'dart:async';

import '../helpers/dimensions.dart';
import 'auth_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  String token = "";

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      _isLoggedIn().then((isLoggedIn) async {
        if (isLoggedIn) {
          SharedPreferences instance = await SharedPreferences.getInstance();
          await instance.setString("token", token);
          bool isPatient = instance.getBool("isPatient");
          if (isPatient) {
            Navigator.pushReplacement(
                context, BouncyPageRoute(widget: HomeScreen()));
          } else {
            Navigator.pushReplacement(
                context, BouncyPageRoute(widget: HomeScreen()));
          }
        } else {
          Navigator.pushReplacement(
              context, BouncyPageRoute(widget: AuthScreen()));
        }
      });
    });
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
        child: Center(
          child: Column(
            children: <Widget>[
              Hero(
                tag: "ico",
                child: Container(
                  height: getDeviceHeight(context) * 0.60,
                  width: getDeviceWidth(context) * 0.60,
                  child: Image.asset('assets/img/splash_bg.png'),
                ),
              ),
              SizedBox(height: getDeviceHeight(context) * 0.01),
              Text(
                'Hospitality',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Montserrat",
                    fontSize: getDeviceHeight(context) * 0.05),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getDeviceHeight(context) * 0.03),
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
      ),
    );
  }
}
