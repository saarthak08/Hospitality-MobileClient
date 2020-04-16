class Hospital {
  String _name;
  double _distance;
  double _latitude;
  double _longitude;
  String _email;
  String _address;
  String _website;
  String _contactNo;
  String _note;
  bool _availability;
  int _totalBeds;
  int _availableBeds;
  int _totalDoctors;
  int _availableDoctors;

  String get getAddress => _address;

  set setAddress(String value) => _address = value;

  String get getWebsite => _website;

  set setWebsite(String value) => _website = value;

  String get getContactNo => _contactNo;

  set setContactNo(String value) => _contactNo = value;

  String get getNote => _note;

  set setNote(String value) => _note = value;

  bool get getAvailability => _availability;

  set setAvailability(bool value) => _availability = value;

  int get getTotalBeds => _totalBeds;

  set setTotalBeds(int value) => _totalBeds = value;

  int get getAvailableBeds => _availableBeds;

  set setAvailableBeds(int value) => _availableBeds = value;

  int get getTotalDoctors => _totalDoctors;

  set setTotalDoctors(int value) => _totalDoctors = value;

  int get getAvailableDoctors => _availableDoctors;

  set setAvailableDoctors(int value) => _availableDoctors = value;

  Hospital.fromJSON(Map<String, dynamic> responseMap) {
    if (responseMap == null) {
      throw FormatException("Null JSON");
    }
    this._email = responseMap["email"];
    this._latitude = responseMap["lattitude"];
    this._longitude = responseMap["longitude"];
    this._name = responseMap["name"];
    this._distance = responseMap["distance"];
    this._address = responseMap["address"];
    this._availability = responseMap["availability"];
    this._availableBeds = responseMap["beds"];
    this._note = responseMap["note"];
    this._totalBeds = responseMap["totalBeds"];
    this._availableDoctors = responseMap["doctors"];
    this._totalDoctors = responseMap["totalDoctors"];
    this._contactNo = responseMap["contact"];
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
