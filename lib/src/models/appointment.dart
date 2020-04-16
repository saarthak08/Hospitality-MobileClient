class Appointment {
  String date;
  String status;
  String hospitalName;
  
  Appointment({this.date,this.hospitalName,this.status});

  String get getDate => date;

  set setDate(String date) => this.date = date;

  String get getStatus => status;

  set setStatus(String status) => this.status = status;

  String get getHospitalName => hospitalName;

  set setHospitalName(String hospitalName) => this.hospitalName = hospitalName;

  Appointment.fromJSON(Map<String, dynamic> responseMap) {
    if (responseMap == null) {
      throw FormatException("Null JSON");
    }
    this.date = responseMap["date"];
    this.status = responseMap["status"];
    this.hospitalName = responseMap["hospitalName"];
  }
}
