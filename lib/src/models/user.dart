class User {
  String _fullName = "";
  String _email = "";
  int _userId = 0;
  String _address = "";
  String _phoneNumber = "";
  double _latitude = 0.0;
  double _longitude = 0.0;
  bool _enabled = false;

  bool get getEnabled => _enabled;

  set setEnabled(bool enabled) => this._enabled = enabled;

  double get getLatitude => _latitude;

  set setLatitude(double latitude) => this._latitude = latitude;

  double get getLongitude => _longitude;

  set setLongitude(double longitude) => this._longitude = longitude;

  String get getAddress => _address;

  set setAddress(String address) => this._address = address;

  String get getPhoneNumber => _phoneNumber;

  set setPhoneNumber(String phoneNumber) => this._phoneNumber = phoneNumber;

  set setEmail(String email) {
    _email = email;
  }

  String get getEmail {
    return _email;
  }

  set setFullName(String fullName) {
    _fullName = fullName;
  }

  String get getFullName {
    return _fullName;
  }

  set setUserId(int userId) {
    _userId = userId;
  }

  int get getUserId {
    return _userId;
  }

  User.fromJSON({Map<String, dynamic> responseMap}) {
    this._email =
        responseMap["email"] != null ? responseMap["email"] : this._email;
    this._latitude = responseMap["latitude"] != null
        ? responseMap["latitude"]
        : this._latitude;
    this._longitude = responseMap["longitude"] != null
        ? responseMap["longitude"]
        : this._longitude;
    this._fullName =
        responseMap["name"] != null ? responseMap["name"] : this._fullName;
    this._address =
        responseMap["address"] != null ? responseMap["address"] : this._address;
    this._phoneNumber = responseMap["phoneNumber"] != null
        ? responseMap["phoneNumber"].toString()
        : this._phoneNumber.toString();
    this._enabled =
        responseMap["enable"] != null ? responseMap["enable"] : this._enabled;
  }

  User();
}
