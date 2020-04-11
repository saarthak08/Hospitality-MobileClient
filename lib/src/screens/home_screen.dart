import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_service/src/helpers/current_location.dart';
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

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push button to get your current Location:',
            ),
            Text(
              'Lets Go',
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
        child: Icon(Icons.map),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
