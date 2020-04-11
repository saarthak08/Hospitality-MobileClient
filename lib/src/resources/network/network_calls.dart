import 'package:http/http.dart' show Response;

final String baseURL = "http://abcd.com";

abstract class NetworkCalls {
 
  Future<Response> logIn({Map<String, String> loginCredentials});

  Future<Response> sendCurrentLocation({double latitude, double longitude});

  

  
}
