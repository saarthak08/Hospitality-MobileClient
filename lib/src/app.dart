import 'package:flutter/material.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/screens/hospital_info_screen.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/auth_screen.dart';
import 'package:hospitality/src/screens/signup_screen.dart';
import 'package:hospitality/src/screens/user_home_screen.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
import 'package:hospitality/src/screens/map_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HospitalListProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HospitalUserProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff0079f5),
          accentColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => SplashPage(),
          '/info': (BuildContext context) => HospitalInfo(),
          '/home': (BuildContext context) => UserHomeScreen(),
          '/auth': (BuildContext context) => AuthScreen(),
          '/map': (BuildContext context) => MapView(),
          '/signup': (BuildContext context) => SignUpScreen(),
        },
      ),
    );
  }
}
