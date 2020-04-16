class User {
  String _fullName = "";
  String _email = "";
  int _userId = 0;
  String _address = "";
  String _phoneNumber = "";
  double _latitude;
  double _longitude;

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
}
