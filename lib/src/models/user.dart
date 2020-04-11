
class User {
  String _fullName = "";
  String _email = "";
  int _userId = 0;
  String _address="";
  String _gender="";
  String _phoneNumber="";

  String get getAddress => _address;

  set setAddress(String address) => this._address = address;

  String get getGender => _gender;

  set setGender(String gender) => this._gender = gender;

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
