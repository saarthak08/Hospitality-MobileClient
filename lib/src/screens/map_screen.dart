import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_list_provider.dart';
import 'package:hospitality/src/providers/location_provider.dart';
import 'package:hospitality/src/widgets/hospital_list_view_item.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapView extends StatefulWidget {
  final int inputDistance;

  MapView({this.inputDistance});

  @override
  State<MapView> createState() => MapViewState(inputDistance: inputDistance);
}

class MapViewState extends State<MapView> {
  List<Hospital> hospitals;
  HospitalListProvider hospitalListProvider;
  Completer<GoogleMapController> _controller = Completer();
  LocationData myLocationData;
  LocationProvider locationProvider;
  CameraPosition myPosition;
  PanelController controller = new PanelController();
  Set<Marker> markers = Set<Marker>();
  GlobalKey listViewKey = new GlobalKey();
  double viewportHeight;
  double viewportWidth;
  int inputDistance;

  @override
  void initState() {
    super.initState();
  }

  MapViewState({this.inputDistance});

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    hospitalListProvider = Provider.of<HospitalListProvider>(context);
    hospitals = hospitalListProvider.getHospitalsList;
    for (Hospital hospital in hospitals) {
      markers.add(
        Marker(
          visible: true,
          position: LatLng(hospital.getLatitude, hospital.getLongitude),
          markerId: MarkerId(hospital.getName),
          infoWindow: InfoWindow(title: hospital.getName),
        ),
      );
    }
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
          "Hospitality",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "BalooTamma2",
            fontSize: viewportHeight * 0.03,
          ),
        ),
        centerTitle: true,
      ),
      body: SlidingUpPanel(
        controller: controller,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        backdropEnabled: true,
        panelBuilder: (ScrollController sc) => _scrollingList(sc),
        isDraggable: true,
        parallaxEnabled: true,
        collapsed: Material(
            borderRadius: BorderRadius.circular(35),
            elevation: 2,
            child: InkWell(
                borderRadius: BorderRadius.circular(35),
                splashColor: Colors.blue,
                onTap: () {},
                child: Container(
                    width: viewportWidth,
                    height: viewportHeight * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_upward,
                          size: viewportHeight * 0.06,
                          color: Colors.blue,
                        ),
                        Text("Hospitals!",
                            style: TextStyle(
                                fontSize: viewportHeight * 0.04,
                                fontFamily: "Poppins")),
                        Icon(
                          Icons.arrow_upward,
                          size: viewportHeight * 0.06,
                          color: Colors.blue,
                        ),
                      ],
                    )))),
        body: Center(
          child: Container(
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
            myLocationButtonEnabled: true,
            markers: markers,
            initialCameraPosition: myPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          )),
        ),
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    return ListView.builder(
      key: listViewKey,
      controller: sc,
      padding: EdgeInsets.only(top: viewportHeight * 0.03),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, int index) {
        return HospitalListViewItem(
          inputDistance: inputDistance,
          panelController: controller,
          controller: _controller,
          hospital: hospitals[index],
        );
      },
      itemCount: hospitals.length,
    );
  }
  /* Future<void> _currentLocation() async {
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
  }*/
}
