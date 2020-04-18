class Hospital {
  String _name = "";
  double _distance = 0.0;
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _email = "";
  String _address = "";
  String _website = "";
  String _phoneNumber = "";
  String _note = "";
  bool _availability = false;
  int _totalBeds = 0;
  int _availableBeds = 0;
  int _totalDoctors = 0;
  int _availableDoctors = 0;

  String get getAddress => _address;

  set setAddress(String value) => _address = value;

  String get getWebsite => _website;

  set setWebsite(String value) => _website = value;

  String get getPhoneNumber => _phoneNumber;

  set setPhoneNumber(String value) => _phoneNumber = value;

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
    print(responseMap);
    this._email =
        responseMap["email"] != null ? responseMap["email"] : this._email;
    this._latitude = responseMap["latitude"] != null
        ? responseMap["latitude"]
        : this._latitude;
    this._longitude = responseMap["longitude"] != null
        ? responseMap["longitude"]
        : this._longitude;
    this._name = responseMap["name"] != null ? responseMap["name"] : this._name;
    this._distance = responseMap["distance"] != null
        ? double.parse((responseMap["distance"].toString()))
        : this._distance;
    // this._address = responseMap["address"];
    this._availability = responseMap["availability"] != null
        ? responseMap["availability"]
        : this._availability;
    this._availableBeds =
        responseMap["beds"] != null ? responseMap["beds"] : this._availableBeds;
    this._note = responseMap["note"] != null ? responseMap["note"] : this._note;
    this._totalBeds = responseMap["totalBeds"] != null
        ? responseMap["totalBeds"]
        : this._totalBeds;
    this._availableDoctors = responseMap["doctors"] != null
        ? responseMap["doctors"]
        : this._availableDoctors;
    this._totalDoctors = responseMap["totalDoctors"] != null
        ? responseMap["totalDoctors"]
        : this._totalDoctors;
    this._phoneNumber = responseMap["phoneNumber"] != null
        ? responseMap["phoneNumber"].toString()
        : this._phoneNumber.toString();
    this._website =
        responseMap["website"] != null ? responseMap["website"] : this._website;
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
