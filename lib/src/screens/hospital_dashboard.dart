import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hospitality/src/screens/appointment%20_list.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';

import '../helpers/dimensions.dart';

class HospitalDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HospitalDashboardState();
  }
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      ;
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
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: SideDrawer(),
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/img/splash_bg.png')),
        backgroundColor: Theme.of(context).primaryColor,
        title: GestureDetector(onTap: () {}, child: Text('Hospital Dashboard')),
        centerTitle: true,
      ),
      body: body(),
    );
  }
}
