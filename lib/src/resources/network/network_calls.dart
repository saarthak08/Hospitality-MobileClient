import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:http/http.dart' show Response;


abstract class NetworkCalls {
  Future<Response> login(
      {Map<String, String> loginCredentials, bool isPatient});

  Future<Response> sendCurrentLocationAndGetHospitalLists(
      {double latitude, double longitude, double range});

  Future<Response> getHospitalData();

  Future<Response> getPatientUserData({String email});

  Future<Response> updatePatientUserData({User user});

  Future<Response> updateLocation(
      {double latitude, double longitude, String email});

  Future<Response> updateHospitalUserData({Hospital hospital});

  Future<Response> getAppointmentsList();

  Future<Response> bookAppointment({String hospitalEmail, String note});

  Future<Response> changeAppointmentStatus(
      {String email, String status, int timestamp});

  Future<Response> deleteAppointmentStatus({String email, int timestamp});

  Future<Response> signUp({Map<String, dynamic> requestMap, bool isPatient});

  Future<Response> sendConfirmationLinkAgain({String userType, String email});

  Future<Response> checkConfirmationLinkCode({String code, String email});

  Future<Response> sendForgotPasswordLink({String email, String userType});

  Future<Response> setPasswordForgotPassword(
      {String code, String email, String password});
}
