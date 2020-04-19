import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hospitality/src/helpers/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  double viewportHeight;
  double viewportWidth;
  bool _obscureText = true;
  bool isLoading = false;
  String fullName = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPassword = "";
  PageController _pageController = PageController();
  int _radioValue = 0;
  bool _isPatient = true;
  GlobalKey<FormState> _formKeyPageOne = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyPageTwo = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "BalooTamma2",
              fontSize: viewportHeight * 0.03,
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        left: viewportHeight * 0.02,
                        right: viewportHeight * 0.02,
                        top: viewportHeight * 0.02),
                    height: viewportHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00CCFF),
                        const Color(0xFF3366FF),
                      ],
                    )),
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: viewportHeight * 0.05),
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: <Widget>[pageOne(), pageTwo()],
                        ))))));
  }

  Widget pageTwo() {
    return Form(
        key: _formKeyPageTwo,
        child: Column(children: <Widget>[
          SizedBox(height: viewportHeight * 0.05),
          Hero(
            tag: "ico",
            child: Container(
              height: viewportHeight * 0.14,
              width: viewportWidth,
              child: Image.asset('assets/img/splash_bg.png'),
            ),
          ),
          SizedBox(height: viewportHeight * 0.03),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(viewportWidth * 0.02, 0,
                viewportWidth * 0.04, viewportWidth * 0.04),
            child: TextFormField(
              onChanged: (String value) {
                if (value != null || value.length != 0) {
                  setState(() {
                    this.password = value;
                  });
                }
              },
              controller: passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: viewportHeight * 0.01,
                  bottom: viewportHeight * 0.01,
                ),
                icon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                  size: viewportHeight * 0.03,
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                labelText: "Password*",
                labelStyle: TextStyle(
                    fontFamily: "Poppins", fontSize: viewportHeight * 0.022),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              style: TextStyle(
                  fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              validator: (String value) {
                if (value.length < 6) {
                  return "Password must be of minimum 6 characters";
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(viewportWidth * 0.02, 0,
                viewportWidth * 0.04, viewportWidth * 0.04),
            child: TextFormField(
              controller: confirmPasswordController,
              onChanged: (String value) {
                if (value != null || value.length != 0) {
                  setState(() {
                    this.confirmPassword = value;
                  });
                }
              },
              validator: (String value) {
                if (value.length < 6) {
                  return "Password must be of minimum 6 characters";
                } else if (value != password) {
                  return "Doesn't match with password";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: viewportHeight * 0.01,
                  bottom: viewportHeight * 0.01,
                ),
                icon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                  size: viewportHeight * 0.03,
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                labelText: "Confirm Password*",
                labelStyle: TextStyle(
                    fontFamily: "Poppins", fontSize: viewportHeight * 0.022),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              style: TextStyle(
                  fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              autovalidate: true,
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            splashColor: Colors.blue,
            onPressed: () {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Container(
              alignment: Alignment.centerRight,
              width: viewportWidth * 0.2,
              height: viewportHeight * 0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                color: Colors.blue,
                size: viewportHeight * 0.03,
              )),
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          RaisedButton(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            splashColor: Colors.blue,
            onPressed: () async {
              if (!_formKeyPageTwo.currentState.validate()) {
                return;
              }
              _formKeyPageTwo.currentState.save();
              passwordController.text = this.password;
              confirmPasswordController.text = this.confirmPassword;
            },
            child: Container(
              alignment: Alignment.centerRight,
              width: viewportWidth * 0.3,
              height: viewportHeight * 0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(
                        value: null,
                        backgroundColor: Colors.blue,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.blue,
                                fontSize: viewportHeight * 0.025,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: viewportHeight * 0.03,
                            )
                          ]),
              ),
            ),
          ),
        ]));
  }

  Widget pageOne() {
    return Form(
      key: _formKeyPageOne,
      child: Column(
        children: <Widget>[
          Hero(
            tag: "ico",
            child: Container(
              height: viewportHeight * 0.14,
              width: viewportWidth,
              child: Image.asset('assets/img/splash_bg.png'),
            ),
          ),
          SizedBox(height: viewportHeight * 0.03),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(viewportWidth * 0.02, 0,
                viewportWidth * 0.04, viewportWidth * 0.04),
            child: TextFormField(
              controller: emailController,
              onChanged: (String value) {
                if (value != null || value.length != 0) {
                  setState(() {
                    this.email = value;
                  });
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: viewportHeight * 0.01,
                  bottom: viewportHeight * 0.01,
                ),
                icon: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: viewportHeight * 0.03,
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                labelText: "Email*",
                labelStyle: TextStyle(
                    fontFamily: "Poppins", fontSize: viewportHeight * 0.022),
              ),
              style: TextStyle(
                  fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if ((!value.contains("@")) || (!value.endsWith(".com"))) {
                  return "Invalid email";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(viewportWidth * 0.02, 0,
                viewportWidth * 0.04, viewportWidth * 0.04),
            child: TextFormField(
              onChanged: (String value) {
                if (value != null || value.length != 0) {
                  setState(() {
                    this.fullName = value;
                  });
                }
              },
              validator: (String value) {
                if (value.length <= 0) {
                  return "Full Name can't be empty";
                }
                return null;
              },
              controller: fullNameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: viewportHeight * 0.01,
                  bottom: viewportHeight * 0.01,
                ),
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                  size: viewportHeight * 0.03,
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                labelText: "Full Name*",
                labelStyle: TextStyle(
                    fontFamily: "Poppins", fontSize: viewportHeight * 0.022),
              ),
              style: TextStyle(
                  fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(viewportWidth * 0.02, 0,
                viewportWidth * 0.04, viewportWidth * 0.04),
            child: TextFormField(
              onChanged: (String value) {
                if (value != null || value.length != 0) {
                  setState(() {
                    this.phoneNumber = value;
                  });
                }
              },
              validator: (String value) {
                if (value.length <= 0) {
                  return "Phone Number can't be empty";
                } else {
                  return null;
                }
              },
              controller: phoneNumberController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: viewportHeight * 0.01,
                  bottom: viewportHeight * 0.01,
                ),
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.blue,
                  size: viewportHeight * 0.03,
                ),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                labelText: "Phone Number*",
                labelStyle: TextStyle(
                    fontFamily: "Poppins", fontSize: viewportHeight * 0.022),
              ),
              style: TextStyle(
                  fontFamily: "Manrope", fontSize: viewportHeight * 0.022),
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(height: viewportHeight * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: viewportWidth * 0.1),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.fromLTRB(
                viewportWidth * 0.02,
                viewportWidth * 0.02,
                viewportWidth * 0.02,
                viewportWidth * 0.02),
            child: Container(
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
                        fontSize: viewportWidth * 0.045)),
              ],
            )),
          ),
          SizedBox(
            height: viewportHeight * 0.01,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            splashColor: Colors.blue,
            onPressed: () {
              _formKeyPageOne.currentState.save();
              if (!_formKeyPageOne.currentState.validate()) {
                return;
              }
              emailController.text = this.email;
              phoneNumberController.text = this.phoneNumber;
              fullNameController.text = this.fullName;
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            child: Container(
              alignment: Alignment.centerRight,
              width: viewportWidth * 0.2,
              height: viewportHeight * 0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_forward,
                color: Colors.blue,
                size: viewportHeight * 0.03,
              )),
            ),
          ),
        ],
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
}
