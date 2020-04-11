import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:hospital_service/src/resources/network/network_calls.dart';

class _NetworkRepository implements NetworkCalls {
  final Client _client = Client();

  String token = "";

  @override
  Future<Response> logIn({Map<String, String> loginCredentials}) async {
    //Sample Login code
    return null;
  }

  @override
  Future<Response> sendCurrentLocation(
      {double latitude, double longitude}) async {
    final Response response = await _client
        .get(
            "$baseURL/api/location?latitude=${latitude.toString()}&longitude=${longitude.toString()}",
            headers: {HttpHeaders.authorizationHeader: token})
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("Launch: ${error.toString()}");
          throw (error);
        });
    return response;
  }
}

_NetworkRepository _networkRepository;

_NetworkRepository get getNetworkRepository {
  if (_networkRepository == null) {
    _networkRepository = _NetworkRepository();
    return _networkRepository;
  } else {
    return _networkRepository;
  }
}
