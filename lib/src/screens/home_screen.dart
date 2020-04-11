import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_service/src/helpers/current_location.dart';
import 'package:hospital_service/src/models/hospital.dart';
import 'package:hospital_service/src/providers/hospital_list_provider.dart';
import 'package:hospital_service/src/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:hospital_service/src/resources/network/network_repository.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider locationProvider;
  HospitalListProvider hospitalListProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Hello',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getLocation().then((value) async {
            if (value == null) {
              Fluttertoast.showToast(
                  msg: "Error in getting location",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM);
            } else {
                  Hospital h=Hospital();
                  h.setDistance=123;
                  h.setEmail="av";
                  h.setName="Gandhi Eye";
                  h.setLatitude=27.8894;
                  h.setLongitude=78.0834;
                  List<Hospital> hospitals = List<Hospital>();
                  hospitals.add(h);
                  hospitalListProvider.setHospitalLists=hospitals;
              Fluttertoast.showToast(
                  msg:
                      "Latitude: ${value.latitude}\nLongitude: ${value.longitude}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM);
              locationProvider.setLocation = value;
              await getNetworkRepository.sendCurrentLocation(
                  latitude: value.latitude, longitude: value.longitude);
              
              Navigator.pushNamed(context, "/map");
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
