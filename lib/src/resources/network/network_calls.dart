import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:http/http.dart' show Response;

final String baseURL = "http://192.168.43.193:5000";


abstract class NetworkCalls {
  Future<Response> login(
      {Map<String, String> loginCredentials, bool isPatient});

  Future<Response> sendCurrentLocationAndGetHospitalLists(
      {double latitude, double longitude, double range});

  Future<Response> getHospitalData();

  Future<Response> getPatientUserData({String email});

  Future<Response> updatePatientUserData({User user});

  Future<Response> updateLocation({double latitude, double longitude,String email});

  Future<Response> updateHospitalUserData({Hospital hospital});

  Future<Response> getAppointmentsList();

  Future<Response> bookAppointment({String hospitalEmail, String note});

  Future<Response> changeAppointmentStatus({String email, String status,int timestamp});

  Future<Response> deleteAppointmentStatus({String email,int timestamp});

  Future<Response> signUp({Map<String,dynamic> requestMap, bool isPatient});

}
