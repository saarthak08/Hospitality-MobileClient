import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/screens/search_hospital_screen.dart';
import 'package:hospitality/src/screens/user_profile.dart';
import 'package:provider/provider.dart';
import '../helpers/dimensions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider locationProvider;
  HospitalListProvider hospitalListProvider;
  bool isButtonEnabled = false;
  double viewportHeight;
  double viewportWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);
    ScrollController controller = new ScrollController();
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              SearchHospitalScreen(controller: controller, formKey: _formKey),
              UserProfile(),
              Text("3"),
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
                  icon: Icon(Icons.search),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(Icons.account_circle),
                  text: 'My Profile',
                ),
                Tab(
                  icon: Icon(Icons.message),
                  text: 'Appointments',
                ),
              ],
            ),
          ),
        ));
  }
}
