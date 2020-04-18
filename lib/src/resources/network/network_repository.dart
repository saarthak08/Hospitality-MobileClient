import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hospitality/src/models/user.dart';
import 'package:http/http.dart';
import 'package:hospitality/src/resources/network/network_calls.dart';

class _NetworkRepository implements NetworkCalls {
  final Client _client = Client();

  String token = "";

  Future<Response> getHospitalData() async {
    final Response response = await _client
        .get("$baseURL/api/hospital/", headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("Get Hospital Data: $error");
          throw (error);
        });
    return response;
  }

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
          print("Login: ${error.toString()}");
          throw (error);
        });
    print(response.body);
    return response;
  }

  @override
  Future<Response> sendCurrentLocationAndGetHospitalLists(
      {double latitude, double longitude, double range}) async {
    final Response response = await _client
        .get(
            "$baseURL/api/patient/hospitals?latitude=${latitude.toString()}&longitude=${longitude.toString()}&range=$range",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print(
              "Send Current Location And Get Hospital Lists: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> getPatientUserData({String email}) async {
    final Response response = await _client
        .get(
          "$baseURL/api/patient/?email=$email",
          headers: {
            HttpHeaders.authorizationHeader: token,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        )
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("getPatientUserData: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> updateLocation(
      {double latitude, double longitude, String email}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["latitude"] = (latitude);
    requestMap["longitude"] = (longitude);

    final Response response = await _client
        .post("$baseURL/api/patient/",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 10))
        .catchError((error) {
      print("updateLocation: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> updatePatientUserData({User user}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["address"] = user.getAddress;
    requestMap["name"] = user.getFullName;
    if(user.getPhoneNumber.toString().length!=0) {
      requestMap["phoneNumber"] = int.parse(user.getPhoneNumber);
    }
    print(requestMap);
    final Response response = await _client
        .post("$baseURL/api/patient/",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 10))
        .catchError((error) {
      print("updatePatientUserData: ${error.toString()}");
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
