import 'package:http/http.dart' show Response;

final String baseURL = "http://192.168.42.75:5000";

abstract class NetworkCalls {
  Future<Response> logIn({Map<String, String> loginCredentials});

  Future<Response> sendCurrentLocation(
      {double latitude, double longitude, double range});
}
