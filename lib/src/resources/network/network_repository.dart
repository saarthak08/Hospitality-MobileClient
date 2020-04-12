import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:hospitality/src/resources/network/network_calls.dart';

class _NetworkRepository implements NetworkCalls {
  final Client _client = Client();

  String token = "";

  @override
  Future<Response> launch({Map<String, String> loginCredentials}) async {
    final Response response = await _client
        .post("$baseURL/api/v1/launch", body: jsonEncode(loginCredentials))
        .timeout(Duration(seconds: 10))
        .catchError((error) {
      print("Launch: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> sendCurrentLocation(
      {double latitude, double longitude, double range}) async {
    final Response response = await _client
        .get(
            "$baseURL/api/patient/hospitals?latitude=${latitude.toString()}&longitude=${longitude.toString()}&range=$range",
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
