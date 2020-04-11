class Hospital {
  String _name;
  double _distance;
  double _latitude;
  double _longitude;
  String _email;

  Hospital.fromJSON(Map<String, dynamic> responseMap) {
    if (responseMap == null) {
      throw FormatException("Null JSON");
    }
    this._email = responseMap["email"];
    this._latitude= responseMap["lattitude"];
    this._longitude = responseMap["longitude"];
    this._name = responseMap["name"];
    this._distance = responseMap["distance"];
  
  }

  Hospital();

 String get getName => _name;

 set setName(String value) => _name = value;

 double get getDistance => _distance;

 set setDistance(double value) => _distance = value;

 double get getLatitude => _latitude;

 set setLatitude(double value) => _latitude = value;

 double get getLongitude => _longitude;

 set setLongitude(double value) => _longitude = value;

 String get getEmail => _email;

 set setEmail(String value) => _email = value;

  
}