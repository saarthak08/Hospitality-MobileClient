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
      margin: EdgeInsets.only(top: viewportHeight * 0.01),
      height: viewportHeight * 0.05,
      width: viewportWidth,
      alignment: Alignment.center,
      child: Text(
        errorMsg,
        style: TextStyle(
          fontSize: viewportHeight * 0.025,
          fontFamily: 'BalooTamma2',
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
        fontSize: 22.0,
        color: Color(0xff282c34),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: false,
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
          size: getViewportHeight(context) * 0.03,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: "Manrope",
          fontSize: 20.0,
          color: Color(0xff282c34),
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
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
        fontSize: 22.0,
        color: Color(0xff282c34),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Color(0xff282c34),
          size: getViewportHeight(context) * 0.03,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        alignLabelWithHint: false,
        labelText: "Password",
        labelStyle: TextStyle(
          fontFamily: "Manrope",
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
        alignment: Alignment.centerRight,
        width: getViewportWidth(context) * 0.2,
        height: getViewportHeight(context) * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  value: null,
                  backgroundColor: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      Text(
                        "OK",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.white,
                          fontSize: viewportHeight * 0.025,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: viewportHeight * 0.03,
                      )
                    ]),
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

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF00CCFF),
                const Color(0xFF3366FF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        height: getDeviceHeight(context),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                            // shadow direction: bottom right
                          )
                        ],
                      ),
                      height: viewportHeight * 0.75,
                      margin: EdgeInsets.only(
                          top: viewportHeight * 0.13,
                          left: viewportWidth * 0.03,
                          right: viewportWidth * 0.03)),
                  Container(
                      child: Column(children: <Widget>[
                    Hero(
                      tag: "ico",
                      child: Container(
                        margin: EdgeInsets.only(top: viewportHeight * 0.15),
                        height: getDeviceHeight(context) * 0.15,
                        width: viewportWidth,
                        child: Image.asset('assets/img/splash_bg.png'),
                      ),
                    ),
                    _errorMsgContainer(viewportHeight, viewportWidth),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: viewportWidth * 0.1,
                            vertical: viewportHeight * 0.015),
                        alignment: Alignment.center,
                        child: Column(children: <Widget>[
                          _emailInputFieldBuilder(viewportHeight),
                          Container(
                            width: viewportWidth,
                            height: viewportHeight * 0.04,
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
                                fontFamily: 'BalooTamma2',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: viewportHeight * 0.02,
                          ),
                          _passwordInputFieldBuilder(viewportHeight),
                          Container(
                            width: viewportWidth,
                            height: viewportHeight * 0.04,
                            padding: EdgeInsets.only(
                                top: viewportHeight * 0.015,
                                left: viewportWidth * 0.05),
                            child: Text(
                              _errorPassword,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: viewportWidth * 0.04,
                                color: Colors.red,
                                fontFamily: 'BalooTamma2',
                                height: viewportWidth * 0.002,
                              ),
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: viewportHeight * 0.02,
                    ),
                    _signInButtonBuilder(viewportHeight, viewportWidth),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: getViewportHeight(context) * 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            Text(
                              "Patient",
                              style: TextStyle(
                                  fontFamily: "BalooTamma2",
                                  fontSize: getViewportWidth(context) * 0.045),
                            ),
                            Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            Text("Hospital",
                                style: TextStyle(
                                    fontFamily: "BalooTamma2",
                                    fontSize:
                                        getViewportWidth(context) * 0.045))
                          ],
                        )),
                  ]))
                ],
              )
            ]),
      )),
    ));
  }
}
