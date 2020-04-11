import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_service/src/providers/location_provider.dart';
import 'package:location/location.dart';

Location location = Location();
LocationData locationData;
LocationProvider locationProvider;

Future<LocationData> getLocation() async {
  locationData=null;
  await location.hasPermission().then((value) async {
    if (value==PermissionStatus.denied||value==PermissionStatus.deniedForever) {
      await location.requestPermission().then((value) async {
        Fluttertoast.showToast(
          msg: "Location is required to show the city data.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        if (value==PermissionStatus.granted) {
         await _locationSettings();
        } else {
            Fluttertoast.showToast(
                msg: "Location Permission not given!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
        }
      });
    } else {
     await  _locationSettings();
    }
  });
  await location.serviceEnabled().then((value) {
    if (!value) {
      Fluttertoast.showToast(
          msg: "Location Setting not enabled!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  });
  return locationData;
}

Future<void> _locationSettings() async {
  await location.serviceEnabled().then((value) async {
    if (!value) {
      await location.requestService().then((value) async {
        if (value) {
          await location.getLocation().then((value) {
              locationData = value;            
              print(
                  'Latitude: ${locationData.latitude}\nLongitude: ${locationData.longitude}');
          }).catchError((error) {
            Fluttertoast.showToast(
                msg: "Error in getting location",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
          }).timeout(Duration(seconds: 5));
        } else {
            locationData=null;
        }
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Error in getting location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }).timeout(Duration(seconds: 5));
    } else {
      await location.getLocation().then((value) {
          locationData = value;
          print(
              'Latitude: ${locationData.latitude}\nLongitude: ${locationData.longitude}');
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Error in getting location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }).timeout(Duration(seconds: 5));
    }
  });
}
