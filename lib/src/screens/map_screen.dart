import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospital_service/src/helpers/current_location.dart';
import 'package:hospital_service/src/providers/location_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData myLocationData;
  LocationProvider locationProvider;
  CameraPosition myPosition;
  Set<Marker> markers = Set<Marker>() ;
  
  @override
  void initState() {
    super.initState();
    markers.add(Marker(visible: true,position:LatLng(27.8894,78.0834),markerId:MarkerId("Taj Mahal"),infoWindow: InfoWindow(title: "GandhiEye")));
  }
  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    myLocationData = locationProvider.getLocation;
    myPosition = CameraPosition(
      bearing: 192,
      target: LatLng(myLocationData.latitude, myLocationData.longitude),
      tilt: 0,
      zoom: 18,
    );
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Hospital Service",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          child: GoogleMap(
        buildingsEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        trafficEnabled: true,
        mapType: MapType.hybrid,
        compassEnabled: true,
        myLocationEnabled: true,
        markers:markers,
        initialCameraPosition: myPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _currentLocation();
        },
        label: Text('Current Location'),
        icon: Icon(Icons.my_location),
      ),
    );
  }

  Future<void> _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    await getLocation().then((value) {
      if (value != null) {
        locationProvider.setLocation = value;
        myLocationData = value;
        myPosition = CameraPosition(
          bearing: 192,
          target: LatLng(myLocationData.latitude, myLocationData.longitude),
          tilt: 0,
          zoom: 18,
        );
        controller.animateCamera(CameraUpdate.newCameraPosition(myPosition));
      }
    });
  }
}
