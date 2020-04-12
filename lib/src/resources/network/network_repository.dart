import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:hospitality/src/resources/network/network_calls.dart';

class _NetworkRepository implements NetworkCalls {
  final Client _client = Client();

  String token = "";

  @override
  Future<Response> login(
      {Map<String, String> loginCredentials, bool isPatient}) async {
    String url;
    if (isPatient) {
      url = "$baseURL/api/patient/login";
    } else {
      url = "$baseURL/api/hospital/login";
    }

    print(json.encode(loginCredentials));

    final Response response = await _client
        .post(url, body: json.encode(loginCredentials), headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("Launch: ${error.toString()}");
          throw (error);
        });
    print(response.body);
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
