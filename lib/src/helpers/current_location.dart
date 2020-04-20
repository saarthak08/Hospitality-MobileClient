import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

Location location = Location();
LocationData locationData;

Future<LocationData> getLocation() async {
  locationData = null;
  await location.hasPermission().then((value) async {
    if (value == PermissionStatus.denied ||
        value == PermissionStatus.deniedForever) {
      await location.requestPermission().then((value) async {
        Fluttertoast.showToast(
          msg: "Location is required to show nearest hospital.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
        if (value == PermissionStatus.granted) {
          await _locationSettings();
        } else {
          Fluttertoast.showToast(
              msg: "Location Permission not given!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
          return null;
        }
      });
    } else {
      await _locationSettings();
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
            print(error);
            return null;
          }).timeout(Duration(seconds: 30));
        } else {
          Fluttertoast.showToast(
              msg: "Location Settings or GPS not enabled!",
              toastLength: Toast.LENGTH_SHORT);
          return null;
        }
      }).catchError((error) {
        print(error);
        return null;
      }).timeout(Duration(seconds: 30));
    } else {
      await location.getLocation().then((value) {
        locationData = value;
        print(
            'Latitude: ${locationData.latitude}\nLongitude: ${locationData.longitude}');
      }).catchError((error) {
        print(error);
        return null;
      }).timeout(Duration(seconds: 30));
    }
  });
}