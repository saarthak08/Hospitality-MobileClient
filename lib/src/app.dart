import 'package:flutter/material.dart';
import 'package:hospital_service/src/providers/location_provider.dart';
import 'package:hospital_service/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => LocationProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(title: 'Flutter Demo Home Page'),
        ));
  }
}
