import 'package:flutter/material.dart';
import 'package:hospital_service/src/widgets/bouncy_page_animation.dart';
import '../helpers/dimensions.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade500]),
        ),
        height: getDeviceHeight(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: "ico",
                    child: Container(
                      height: getDeviceHeight(context) * 0.30,
                      width: getDeviceWidth(context) * 0.30,
                      child: Image.asset('assets/img/splash_bg.png'),
                    ),
                  ),
                  Text(
                    'Choose your role!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getViewportHeight(context)*0.04,
                        fontFamily: "Montserrat",
                        color: Colors.white),
                  )
                ],
              ),
              RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                splashColor: Colors.blue,
                color: Colors.white,
                child: Container(
                  width: getViewportWidth(context) * 0.4,
                  height: getViewportHeight(context) * 0.08,
                  alignment: Alignment.center,
                  child: Text(
                    'Patient',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Ubuntu",
                      fontSize: getViewportHeight(context) * 0.025,
                    ),
                  ),
                ),
                textColor: Colors.white,
                animationDuration: Duration(milliseconds: 300),
                onPressed: () => Navigator.push(
                    context, BouncyPageRoute(widget: HomeScreen())),
              ),

              // SizedBox(height: getDeviceHeight(context) * 0.2),
              RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                splashColor: Colors.blue,
                color: Colors.white,
                child: Container(
                  width: getViewportWidth(context) * 0.4,
                  height: getViewportHeight(context) * 0.08,
                  alignment: Alignment.center,
                  child: Text(
                    'Hospital',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Ubuntu",
                      fontSize: getViewportHeight(context) * 0.025,
                    ),
                  ),
                ),
                textColor: Colors.white,
                animationDuration: Duration(milliseconds: 300),
                onPressed: () => Navigator.pushNamed(context, "/home"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
