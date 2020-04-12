import 'package:flutter/material.dart';
import 'package:hospitality/src/providers/currrent_hospital_on_map_provider.dart';
import 'package:hospitality/src/screens/hospital_dashboard.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/home_screen.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';
import "dart:convert";
import 'package:http/http.dart' show Response;
import 'package:flutter/services.dart';
import 'package:hospitality/src/resources/network/network_repository.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final Map<String, String> _loginCredentials = <String, String>{
    "email": "",
    "password": ""
  };
  UserProfileProvider userProfileProvider;
  SharedPreferences _sharedPreferencesInstance;
  CurrentHospitalOnMapProvider currentHospitalOnMapProvider;

  bool isemailValid = true;
  bool ispasswordValid = true;
  bool _obscureText = true;

  bool isLoading = false;
  String errorMsg = "";
  String _errorEmail = "";
  String _errorPassword = "";
  int _radioValue = 0;
  bool _isPatient = true;

  Widget _errorMsgContainer(double viewportHeight, double viewportWidth) {
    return Container(
      margin: EdgeInsets.only(top: viewportHeight * 0.04),
      height: viewportHeight * 0.05,
      width: viewportWidth,
      alignment: Alignment.center,
      child: Text(
        errorMsg,
        style: TextStyle(
          fontSize: viewportHeight * 0.025,
          fontFamily: 'Montserrat',
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emailInputFieldBuilder(double viewportWidth) {
    return TextFormField(
      onChanged: (String value) {
        _loginCredentials["email"] = value;
      },
      onSaved: (String value) {
        _loginCredentials["email"] = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 20.0,
        color: Color(0xff282c34),
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
      cursorWidth: 2,
      cursorColor: Color(0xff282c34),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 10.0, top: 12.0, bottom: 22.0),
        prefixIcon: Icon(
          Icons.email,
          color: Color(0xff282c34),
          size: 30.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        alignLabelWithHint: false,
        labelText: "Email",
        labelStyle: TextStyle(
          fontFamily: "Arial Round",
          fontSize: 20.0,
          color: Color(0xff282c34),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _passwordInputFieldBuilder(double viewportWidth) {
    return TextFormField(
      onChanged: (String value) {
        _loginCredentials["password"] = value;
      },
      onSaved: (String value) {
        _loginCredentials["password"] = value;
      },
      obscureText: _obscureText,
      style: TextStyle(
        fontSize: 20.0,
        color: Color(0xff282c34),
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
      cursorWidth: 2,
      cursorColor: Color(0xff282c34),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: 10.0, top: 12.0, bottom: 22.0),
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Color(0xff282c34),
          size: 30.0,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        alignLabelWithHint: false,
        labelText: "Password",
        labelStyle: TextStyle(
          fontFamily: "Arial Round",
          fontSize: 20.0,
          color: Color(0xff282c34),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _signInButtonBuilder(double viewportHeight, double viewportWidth) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.blue,
      splashColor: Colors.white,
      onPressed: () async {
        if (isLoading) return;
        FocusScope.of(context).requestFocus(FocusNode());
        if (_loginCredentials["email"].length == 0 ||
            _loginCredentials["password"].length == 0) {
          if (_loginCredentials["email"].length == 0) {
            setState(() {
              _errorEmail = "please enter an email";
            });
          } else {
            _errorEmail = "";
          }
          if (_loginCredentials["password"].length == 0) {
            setState(() {
              _errorPassword = "please enter a password";
            });
          } else {
            _errorPassword = "";
          }
          errorMsg = "";
          return;
        } else {
          _errorEmail = "";
          _errorPassword = "";
          _sharedPreferencesInstance = await SharedPreferences.getInstance();
          setState(() {
            isLoading = true;
            errorMsg = "";
          });
          await getNetworkRepository
              .login(loginCredentials: _loginCredentials, isPatient: _isPatient)
              .then((Response response) async {
                print(response.statusCode);
                if (response.statusCode == 200) {
                  setState(() {
                    isLoading = false;
                    errorMsg = "";
                  });
                  Map<dynamic, dynamic> res = json.decode(response.body);
                  String token = res["token"];
                  User user = userProfileProvider.getUser;
                  if (user == null) {
                    user = User();
                  }
                  user.setEmail = _loginCredentials["email"];
                  userProfileProvider.setUser = user;
                  await _sharedPreferencesInstance.setString("token", token);
                  getNetworkRepository.token = token;
                  if (_isPatient) {
                    _sharedPreferencesInstance.setBool("isPatient", true);
                    userProfileProvider.isPatient = true;
                    Navigator.pushAndRemoveUntil(
                        context,
                        BouncyPageRoute(widget: HomeScreen()),
                        (Route<dynamic> route) => false);
                  } else {
                   
                        _sharedPreferencesInstance.setBool("isPatient", false);
                        userProfileProvider.isPatient = false;
                        Navigator.pushAndRemoveUntil(
                            context,
                            BouncyPageRoute(widget: HospitalDashboard()),
                            (Route<dynamic> route) => false);
                    
                    
                  }
                } else if (response.statusCode == 403) {
                  setState(() {
                    isLoading = false;
                    errorMsg = "Couldn't sign in";
                    Map<dynamic, dynamic> errorMap = json.decode(response.body);
                    if (errorMap.containsKey("email")) {
                      _errorEmail = errorMap["email"];
                    }
                    if (errorMap.containsKey("password")) {
                      _errorPassword = errorMap["password"];
                    }
                  });
                } else if (response.statusCode == 400) {
                  Map<dynamic, dynamic> errorMap = json.decode(response.body);
                  setState(() {
                    isLoading = false;
                    errorMsg = "Couldn't sign in";
                    if (errorMap.containsKey("email")) {
                      _errorEmail = errorMap["email"];
                    }
                    if (errorMap.containsKey("password")) {
                      _errorPassword = errorMap["password"];
                    }
                  });
                } else if (response.statusCode == 404) {
                  setState(() {
                    isLoading = false;
                    errorMsg = "Wrong login!";
                    Map<dynamic, dynamic> errorMap = json.decode(response.body);

                    if (errorMap.containsKey("email")) {
                      _errorEmail = errorMap["email"];
                    }
                    if (errorMap.containsKey("password")) {
                      _errorPassword = errorMap["password"];
                    }
                  });
                } else {
                  setState(() {
                    isLoading = false;
                    Map<dynamic, dynamic> errorMap = json.decode(response.body);
                    if (errorMap.containsKey("email")) {
                      _errorEmail = errorMap["email"];
                    }
                    if (errorMap.containsKey("password")) {
                      _errorPassword = errorMap["password"];
                    }
                  });
                }
              })
              .timeout(Duration(seconds: 10))
              .catchError((error) {
                print("hello" + error.toString());
                isLoading = false;
                errorMsg = "an error occurred";
              });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: getViewportWidth(context) * 0.4,
        height: getViewportHeight(context) * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  value: null,
                  backgroundColor: Colors.white,
                )
              : Text(
                  "Launch",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: viewportHeight * 0.025,
                  ),
                ),
        ),
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _isPatient = true;
          break;
        case 1:
          _isPatient = false;
          break;
      }
      userProfileProvider.isPatient = _isPatient;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double viewportHeight = getViewportHeight(context);
    final double viewportWidth = getViewportWidth(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    currentHospitalOnMapProvider =
        Provider.of<CurrentHospitalOnMapProvider>(context);

    return Stack(children: <Widget>[
      Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
            child: Container(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
              tag: "ico",
              child: Container(
                margin: EdgeInsets.only(top: viewportHeight * 0.05),
                height: getDeviceHeight(context) * 0.30,
                width: getDeviceWidth(context) * 0.30,
                child: Image.asset('assets/img/splash_bg.png'),
              ),
            ),
            _errorMsgContainer(viewportHeight, viewportWidth),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: viewportWidth * 0.1,
                    vertical: viewportHeight * 0.025),
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  Material(
                    child: _emailInputFieldBuilder(viewportHeight),
                    elevation: 10,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  Container(
                    width: viewportWidth,
                    height: viewportHeight * 0.05,
                    padding: EdgeInsets.only(
                        top: viewportHeight * 0.015,
                        left: viewportWidth * 0.05),
                    child: Text(
                      _errorEmail,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: viewportWidth * 0.04,
                        color: Colors.red,
                        height: viewportWidth * 0.002,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: viewportHeight * 0.02,
                  ),
                  Material(
                    child: _passwordInputFieldBuilder(viewportHeight),
                    elevation: 10,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  Container(
                    width: viewportWidth,
                    height: viewportHeight * 0.05,
                    padding: EdgeInsets.only(
                        top: viewportHeight * 0.015,
                        left: viewportWidth * 0.05),
                    child: Text(
                      _errorPassword,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: viewportWidth * 0.04,
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        height: viewportWidth * 0.002,
                      ),
                    ),
                  ),
                ])),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: getViewportHeight(context) * 0.03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Patient"),
                    new Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("Hospital")
                  ],
                )),
            SizedBox(
              height: getViewportHeight(context) * 0.01,
            ),
            _signInButtonBuilder(viewportHeight, viewportWidth),
          ],
        ))),
      )),
      Visibility(
          visible: (Platform.isIOS ? true : false),
          child: Container(
            height: viewportHeight * 0.06,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: viewportWidth * 0.85),
            child: FlatButton(
              child: Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: viewportWidth * 0.07),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/pre-login");
              },
            ),
            color: Colors.transparent,
          )),
    ]);
  }
}
