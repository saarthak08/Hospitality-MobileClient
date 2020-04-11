import 'package:flutter/material.dart';
import '../helpers/dimensions.dart';

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
                    'Choose your Role!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white70),
                  )
                ],
              ),
              RaisedButton(
                child: Text('Patient'),
                elevation: 10,
                color: Colors.white70,
                animationDuration: Duration(milliseconds: 200),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              // SizedBox(height: getDeviceHeight(context) * 0.2),
              RaisedButton(
                child: Text('Hospital'),
                elevation: 10,
                color: Colors.white70,
                animationDuration: Duration(milliseconds: 200),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
