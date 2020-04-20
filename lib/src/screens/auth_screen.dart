import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality/src/dialogs/confirmation_link_dialog.dart';
import 'package:hospitality/src/dialogs/forgot_password.dialog.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/screens/hospital_home_screen.dart';
import 'package:hospitality/src/models/user.dart';
import 'package:hospitality/src/providers/user_profile_provider.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
import 'package:hospitality/src/screens/user_home_screen.dart';
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
  HospitalUserProvider hospitalUserProvider;
  SharedPreferences _sharedPreferencesInstance;
  double viewportHeight;
  double viewportWidth;

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
      margin: EdgeInsets.only(top: viewportHeight * 0.015),
      height: viewportHeight * 0.035,
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
        fontSize: viewportHeight * 0.025,
        color: Color(0xff282c34),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: false,
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
          size: viewportHeight * 0.03,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: "Manrope",
          fontSize: viewportHeight * 0.025,
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
        fontSize: viewportHeight * 0.025,
        color: Color(0xff282c34),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Color(0xff282c34),
          size: viewportHeight * 0.03,
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
          fontSize: viewportHeight * 0.025,
          color: Color(0xff282c34),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _signInButtonBuilder(double viewportHeight, double viewportWidth) {
    return RaisedButton(
      elevation: 3,
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
                  await _sharedPreferencesInstance.setString("token", token);
                  await _sharedPreferencesInstance.setString(
                      "email", _loginCredentials["email"]);
                  getNetworkRepository.token = token;
                  setState(() {
                    SplashPage.isPatient = _isPatient;
                  });
                  if (_isPatient) {
                    _sharedPreferencesInstance.setBool("isPatient", true);
                    User user = userProfileProvider.getUser;
                    if (user == null) {
                      user = User();
                    }
                    user.setEmail = _loginCredentials["email"];
                    userProfileProvider.setUser = user;
                    await getNetworkRepository
                        .getPatientUserData(email: _loginCredentials["email"])
                        .then((value) async {
                      if (value.statusCode == 200) {
                        Map<String, dynamic> responseMap =
                            json.decode(value.body);
                        User user = User.fromJSON(responseMap: responseMap);
                        userProfileProvider.setUser = user;
                        Navigator.pushAndRemoveUntil(
                            context,
                            BouncyPageRoute(widget: UserHomeScreen()),
                            (Route<dynamic> route) => false);
                      } else {
                        print("getUserProfileData: " +
                            value.statusCode.toString() +
                            " ${value.body.toString()}");
                        Fluttertoast.showToast(
                            msg: "Error in fetching user profile data");
                      }
                    }).catchError((error) {
                      print("getUserProfileData: " + " ${error.toString()}");
                      Fluttertoast.showToast(
                          msg: "Error in fetching user profile data");
                    });
                  } else {
                    _sharedPreferencesInstance.setBool("isPatient", false);
                    Hospital hospital = hospitalUserProvider.getHospital;
                    if (hospital == null) {
                      hospital = Hospital();
                    }
                    hospital.setEmail = _loginCredentials["email"];
                    hospitalUserProvider.setHospital = hospital;
                    await getNetworkRepository
                        .getHospitalData()
                        .then((value) async {
                      if (value.statusCode == 200) {
                        Map<String, dynamic> responseMap =
                            json.decode(value.body);
                        Hospital hospital = Hospital.fromJSON(responseMap);
                        hospitalUserProvider.setHospital = hospital;
                        Navigator.pushAndRemoveUntil(
                            context,
                            BouncyPageRoute(widget: HospitalDashboard()),
                            (Route<dynamic> route) => false);
                      } else {
                        print("getUserProfileData: " +
                            value.statusCode.toString() +
                            " ${value.body.toString()}");
                        Fluttertoast.showToast(
                            msg: "Error in fetching user profile data");
                      }
                    }).catchError((error) {
                      print("getUserProfileData: " + " ${error.toString()}");
                      Fluttertoast.showToast(
                          msg: "Error in fetching user profile data");
                    });
                  }
                } else if (response.statusCode == 401) {
                  setState(() {
                    errorMsg = "";
                    isLoading = false;
                  });
                  await sendConfirmationLink(
                      _loginCredentials["email"], context, _isPatient);
                  await showConfirmationDialog(
                      _loginCredentials["email"], context, _isPatient);
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
              .timeout(Duration(seconds: 30))
              .catchError((error) {
                setState(() {
                  print("Login Error: " + error.toString());
                  isLoading = false;
                  errorMsg = "an error occurred";
                });
              });
        }
      },
      child: Container(
        alignment: Alignment.centerRight,
        width: viewportWidth * 0.2,
        height: viewportHeight * 0.065,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context);
    hospitalUserProvider = Provider.of<HospitalUserProvider>(context);

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
                              top: viewportHeight * 0.12,
                              left: viewportWidth * 0.03,
                              right: viewportWidth * 0.03)),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Hospitality',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Satisfy",
                              fontSize: viewportHeight * 0.06,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          child: Column(children: <Widget>[
                        Hero(
                          tag: "ico",
                          child: Container(
                            margin: EdgeInsets.only(top: viewportHeight * 0.13),
                            height: viewportHeight * 0.15,
                            width: viewportWidth,
                            child: Image.asset('assets/img/splash_bg.png'),
                          ),
                        ),
                        _errorMsgContainer(viewportHeight, viewportWidth),
                        Container(
                          child: _emailInputFieldBuilder(viewportHeight),
                          height: viewportHeight * 0.1,
                          width: viewportWidth * 0.85,
                        ),
                        Container(
                          width: viewportWidth,
                          height: viewportHeight * 0.035,
                          padding: EdgeInsets.only(
                              top: viewportHeight * 0.015,
                              left: viewportWidth * 0.1),
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
                        Container(
                          child: _passwordInputFieldBuilder(viewportHeight),
                          height: viewportHeight * 0.1,
                          width: viewportWidth * 0.85,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: viewportHeight * 0.06,
                          padding: EdgeInsets.only(
                              top: viewportHeight * 0.015,
                              right: viewportWidth * 0.1,
                              left: viewportWidth * 0.1),
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
                        SizedBox(
                          height: 0.02,
                        ),
                        Container(
                            height: viewportHeight * 0.04,
                            child: GestureDetector(
                                onTap: () {
                                  showForgotPasswordDialog(context);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.bold,
                                      fontSize: viewportHeight * 0.022),
                                ))),
                        SizedBox(height: viewportHeight * 0.015),
                        Container(
                            height: viewportHeight * 0.045,
                            child: Row(
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
                                      fontSize: viewportWidth * 0.045),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _radioValue,
                                  onChanged: _handleRadioValueChange,
                                ),
                                Text("Hospital",
                                    style: TextStyle(
                                        fontFamily: "BalooTamma2",
                                        fontSize: viewportWidth * 0.045))
                              ],
                            )),
                        SizedBox(
                          height: viewportHeight * 0.03,
                        ),
                        Container(
                          child: _signInButtonBuilder(
                              viewportHeight, viewportWidth),
                          height: viewportHeight * 0.075,
                          width: viewportWidth * 0.24,
                        )
                      ]))
                    ],
                  )
                ]),
          )),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color(0xFF00CCFF),
                const Color(0xFF3366FF),
              ],
            )),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: Text(
                "Not registered? Sign Up!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "BalooTamma2",
                    fontSize: viewportHeight * 0.026,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )));
  }
}
