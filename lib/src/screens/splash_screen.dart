import 'package:flutter/material.dart';
import 'package:hospital_service/src/widgets/bouncy_page_animation.dart';
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
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, BouncyPageRoute(widget: AuthScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade500]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "ico",
                child: Container(
                  height: getDeviceHeight(context) * 0.50,
                  width: getDeviceWidth(context) * 0.50,
                  child: Image.asset('assets/img/splash_bg.png'),
                ),
              ),
              SizedBox(height: getDeviceHeight(context) * 0.01),
              Text(
                'Hospitality',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getDeviceHeight(context) * 0.05),
              ),
              SizedBox(height: getDeviceHeight(context) * 0.01),
              Text(
                'We are here to help',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getDeviceHeight(context) * 0.03),
              )
            ],
          ),
        ),
      ),
    );
  }
}
