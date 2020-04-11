import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospital_service/src/helpers/dimensions.dart';
import 'package:hospital_service/src/models/hospital.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HospitalListViewItem extends StatelessWidget {
  final Hospital hospital;
  final PanelController panelController;
  final Completer<GoogleMapController> controller;

  HospitalListViewItem({this.hospital, this.controller, this.panelController});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(
        top: getViewportHeight(context) * 0.02,
        left: getViewportWidth(context) * 0.04,
        right: getViewportWidth(context) * 0.04,
      ),
      clipBehavior: Clip.hardEdge, //color: Color(0xffeefdec),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () async {
          if (panelController.isPanelOpen) {
            panelController.close();
          }
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
                  fontFamily: "Montserrat",
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
            Text(
              "Distance: " + hospital.getDistance.toString() + " km",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
            Text("Email: " + hospital.getEmail,
                textAlign: TextAlign.start, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
