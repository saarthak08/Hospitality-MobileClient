import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/appointments%20_list_screen.dart';
import 'package:hospitality/src/screens/search_hospital_screen.dart';
import 'package:hospitality/src/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/dimensions.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with TickerProviderStateMixin {
  LocationProvider locationProvider;
  UserProfileProvider userProfileProvider;
  HospitalListProvider hospitalListProvider;
  bool isButtonEnabled = false;
  double viewportHeight;
  double viewportWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);
    ScrollController scrollController = ScrollController();
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              SearchHospitalScreen(
                controller: scrollController,
                formKey: _formKey,
              ),
              UserProfileScreen(),
              AppointmentsListScreen(),
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Hospitality',
              style: TextStyle(
                  fontFamily: "BalooTamma2", fontSize: viewportHeight * 0.045),
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
                  icon: Hero(
                    tag: "ico",
                    child: Container(
                      height: viewportHeight * 0.045,
                      child: Image.asset('assets/img/splash_bg.png'),
                    ),
                  ),
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
