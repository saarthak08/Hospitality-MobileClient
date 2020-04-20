import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
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
        .timeout(Duration(seconds: 20))
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

    final Response response = await _client
        .post(url, body: json.encode(loginCredentials), headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        })
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("Login: ${error.toString()}");
          throw (error);
        });
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
        .timeout(Duration(seconds: 20))
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
          "$baseURL/api/patient?email=$email",
          headers: {
            HttpHeaders.authorizationHeader: token,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        )
        .timeout(Duration(seconds: 20))
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
    String url = "";
    if (SplashPage.isPatient) {
      url = "$baseURL/api/patient/";
    } else {
      url = "$baseURL/api/hospital/";
    }

    final Response response = await _client
        .post(url,
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
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
    if (user.getPhoneNumber.toString().length != 0) {
      requestMap["phoneNumber"] = int.parse(user.getPhoneNumber);
    }
    final Response response = await _client
        .post("$baseURL/api/patient/",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("updatePatientUserData: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> updateHospitalUserData({Hospital hospital}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["name"] = hospital.getName;
    if (hospital.getPhoneNumber.toString().length != 0) {
      requestMap["phoneNumber"] = int.parse(hospital.getPhoneNumber);
    }
    requestMap["note"] = hospital.getNote;
    requestMap["availability"] = hospital.getAvailability;
    requestMap["website"] = hospital.getWebsite;
    requestMap["totalBeds"] = hospital.getTotalBeds;
    requestMap["beds"] = hospital.getAvailableBeds;
    requestMap["totalDoctors"] = hospital.getTotalDoctors;
    requestMap["doctors"] = hospital.getAvailableDoctors;

    final Response response = await _client
        .post("$baseURL/api/hospital/",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("updateHospitalUserData: ${error.toString()}");
      throw (error);
    });

    return response;
  }

  Future<Response> getAppointmentsList() async {
    String url = "";
    if (SplashPage.isPatient) {
      url = "$baseURL/api/patient/appointments/";
    } else {
      url = "$baseURL/api/hospital/appointments/";
    }

    final Response response = await _client
        .get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: token,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        )
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("get Appointments List: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> bookAppointment({String hospitalEmail, String note}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["email"] = hospitalEmail;
    requestMap["note"] = note;
    final Response response = await _client
        .post("$baseURL/api/patient/hospital/appointment",
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("Book Appointment: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> changeAppointmentStatus(
      {String email, String status, int timestamp}) async {
    String url = "";

    url = "$baseURL/api/hospital/appointments/appointment";

    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["email"] = email;
    requestMap["confirmation"] = status;
    requestMap["date"] = timestamp;
    final Response response = await _client
        .post(url,
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("Book Appointment: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> deleteAppointmentStatus(
      {String email, int timestamp}) async {
    String url = "$baseURL/api/patient/appointments/appointment";

    final Response response = await _client
        .delete(
          url + "?email=$email&date=$timestamp",
          headers: {
            HttpHeaders.authorizationHeader: token,
            HttpHeaders.contentTypeHeader: 'application/json'
          },
        )
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("Book Appointment: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  Future<Response> signUp(
      {Map<String, dynamic> requestMap, bool isPatient}) async {
    String url = "";
    if (isPatient) {
      url = "$baseURL/api/patient/register";
    } else {
      url = "$baseURL/api/hospital/register";
    }
    final Response response = await _client
        .post(url,
            body: json.encode(requestMap),
            headers: {HttpHeaders.contentTypeHeader: 'application/json'})
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("Book Appointment: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> checkConfirmationLinkCode(
      {String code, String email}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["email"] = email;
    requestMap["code"] = int.parse(code);
    final Response response = await _client
        .post("$baseURL/api/user/verification/check",
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("Check Verification Code: ${error.toString()}");
      throw (error);
    });
    return response;
  }

  @override
  Future<Response> sendConfirmationLinkAgain(
      {String userType, String email}) async {
    final Response response = await _client
        .get(
            "$baseURL/api/user/verification/sent?email=$email&userType=$userType",
            headers: {HttpHeaders.contentTypeHeader: 'application/json'})
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("Send Confirmation Code Again: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> sendForgotPasswordLink(
      {String email, String userType}) async {
    final Response response = await _client
        .get("$baseURL/api/user/forgot/sent?email=$email&userType=$userType",
            headers: {HttpHeaders.contentTypeHeader: 'application/json'})
        .timeout(Duration(seconds: 20))
        .catchError((error) {
          print("Send Forgot Password Link: ${error.toString()}");
          throw (error);
        });
    return response;
  }

  @override
  Future<Response> setPasswordForgotPassword(
      {String code, String email, String password}) async {
    final Map<String, dynamic> requestMap = Map<String, dynamic>();
    requestMap["email"] = email;
    requestMap["code"] = int.parse(code);
    requestMap["passwordNew"] = password;
    final Response response = await _client
        .post("$baseURL/api/user/forgot/check",
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: json.encode(requestMap))
        .timeout(Duration(seconds: 20))
        .catchError((error) {
      print("Check Forgot Password Code: ${error.toString()}");
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
