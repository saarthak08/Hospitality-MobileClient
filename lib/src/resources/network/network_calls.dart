import 'package:hospitality/src/models/user.dart';
import 'package:http/http.dart' show Response;

final String baseURL = "http://192.168.43.197:5000";

abstract class NetworkCalls {
  Future<Response> login(
      {Map<String, String> loginCredentials, bool isPatient});

  Future<Response> sendCurrentLocationAndGetHospitalLists(
      {double latitude, double longitude, double range});

  Future<Response> getHospitalData({String email});

  Future<Response> getPatientUserData({String email});

  Future<Response> updatePatientUserData({User user});

  Future<Response> updateLocation({double latitude, double longitude,String email});
}
