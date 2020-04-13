import 'package:http/http.dart' show Response;

final String baseURL = "http://192.168.110.1:5000";

abstract class NetworkCalls {
  Future<Response> login(
      {Map<String, String> loginCredentials, bool isPatient});

  Future<Response> sendCurrentLocation(
      {double latitude, double longitude, double range});

  Future<Response> getHospitalData({String email});
}
