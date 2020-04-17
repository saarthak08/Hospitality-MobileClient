import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/screens/appointments%20_list_screen.dart';
import 'package:hospitality/src/screens/search_hospital_screen.dart';
import 'package:hospitality/src/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/dimensions.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key key, this.title}) : super(key: key);
  static int tabIndex = 0;

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
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
          body: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: () async {
                print(UserHomeScreen.tabIndex);
                if (UserHomeScreen.tabIndex == 1 ||
                    UserHomeScreen.tabIndex == 0) {
                  await getUserData();
                } else if (UserHomeScreen.tabIndex == 2) {
                  print("hello");
                }
              },
              child: TabBarView(
                children: <Widget>[
                  SearchHospitalScreen(
                    controller: scrollController,
                    formKey: _formKey,
                    refreshIndicatorKey: refreshIndicatorKey,
                  ),
                  UserProfileScreen(refreshIndicatorKey: refreshIndicatorKey),
                  AppointmentsListScreen(),
                ],
              )),
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

  Future<void> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString("email");
    await getNetworkRepository.getPatientUserData(email: email).then((value) {
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(value.body);
        User user = User.fromJSON(responseMap: responseMap);
        userProfileProvider.setUser = user;
      } else {
        print("getUserProfileData: " +
            value.statusCode.toString() +
            " ${value.body.toString()}");
        Fluttertoast.showToast(msg: "Error in fetching user profile data");
      }
    }).catchError((error) {
      print("getUserProfileData: " + " ${error.toString()}");
      Fluttertoast.showToast(msg: "Error in fetching user profile data");
    });
  }
}
