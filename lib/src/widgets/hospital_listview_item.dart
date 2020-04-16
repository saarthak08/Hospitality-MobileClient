import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HospitalListViewItem extends StatelessWidget {
  final Hospital hospital;
  final PanelController panelController;
  final Completer<GoogleMapController> controller;

  HospitalListViewItem({this.hospital, this.controller, this.panelController});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: getViewportWidth(context) * 0.05,
          vertical: getViewportHeight(context) * 0.01),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(
            color: Colors.blue,
          )),

      clipBehavior: Clip.hardEdge, //color: Color(0xffeefdec),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () async {
          panelController.close();
          final GoogleMapController controller2 = await controller.future;
          CameraPosition myPosition = CameraPosition(
            bearing: 192,
            target: LatLng(hospital.getLatitude, hospital.getLongitude),
            tilt: 0,
            zoom: 18,
          );
          controller2.animateCamera(CameraUpdate.newCameraPosition(myPosition));
        },
        borderRadius: BorderRadius.circular(40),
        child: Column(
          children: <Widget>[
            Text(
              hospital.getName,
              style: TextStyle(
                  fontFamily: "BalooTamma2",
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
            Text(
              "Distance: " + hospital.getDistance.toString() + " km",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
            Text("Contact Info: " + hospital.getEmail,
                textAlign: TextAlign.start, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
