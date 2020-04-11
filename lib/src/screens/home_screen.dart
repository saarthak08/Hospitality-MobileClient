import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_service/src/helpers/current_location.dart';
<<<<<<< HEAD
import 'package:hospital_service/src/helpers/dimensions.dart';
=======
import 'package:hospital_service/src/models/hospital.dart';
import 'package:hospital_service/src/providers/hospital_list_provider.dart';
>>>>>>> 66a46057130914e355f190f3270db3da8f7bb5db
import 'package:hospital_service/src/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:hospital_service/src/resources/network/network_repository.dart';
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

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  int distance = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    _formKey.currentState.save();
    setState(() {
      locationProvider.setHospitalDistance = distance;
      print('done');
    });
    // Timer(Duration(seconds: 3), () {
    // });
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade500]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: getDeviceHeight(context) * 0.20,
                width: getDeviceWidth(context) * 0.20,
                child: Image.asset('assets/img/splash_bg.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Input distance for nearby hospital',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white70),
                  ),
                ],
              ),
              SizedBox(
                height: getDeviceHeight(context) * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      style: dropdownMenuItem,
                      decoration: InputDecoration(
                        hintText: "Search by distance in km",
                        hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 16),
                        prefixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              _submitForm();
                              _formKey.currentState.reset();
                              FocusScope.of(context).requestFocus(FocusNode());
                            }),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (String value) {
                        distance = int.parse(value);
                      },
                      onSaved: (String value) {
                        distance = int.parse(value);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                splashColor: Colors.white,
                color: Colors.white,
                child: Container(
                  width: getViewportWidth(context) * 0.35,
                  height: getViewportHeight(context) * 0.06,
                  alignment: Alignment.center,
                  child: Text(
                    'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Ubuntu",
                      fontSize: getViewportHeight(context) * 0.025,
                    ),
                  ),
                ),
                textColor: Colors.white,
                onPressed: () {
                  _submitForm();
                  _formKey.currentState.reset();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
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
        child: Icon(
          Icons.map,
          color: Theme.of(context).primaryColor,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
