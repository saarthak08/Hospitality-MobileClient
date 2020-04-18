import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality/src/dialogs/confirm_booking_appointment_dialog.dart';
import 'package:hospitality/src/helpers/fetch_user_data.dart';
import 'package:hospitality/src/models/hospital.dart';
import 'package:hospitality/src/providers/hospital_user_provider.dart';
import 'package:hospitality/src/screens/splash_screen.dart';
import 'package:hospitality/src/widgets/bouncy_page_animation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/dimensions.dart';
import 'hospital_profile_edit_screen.dart';

class HospitalInfo extends StatefulWidget {
  final Hospital hospital;
  final int inputDistance;

  HospitalInfo({this.hospital, this.inputDistance});

  @override
  _HospitalInfoState createState() =>
      _HospitalInfoState(hospital: hospital, inputDistance: this.inputDistance);
}

class _HospitalInfoState extends State<HospitalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  HospitalUserProvider hospitalUserProvider;
  bool formVisible = false;
  double viewportHeight;
  bool isPatient = SplashPage.isPatient;
  double viewportWidth;
  int inputDistance;
  Hospital hospital;
  String noteAppointment;

  _HospitalInfoState({
    this.hospital,
    this.inputDistance,
  });

  Widget _buildForm() {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return Container(
        margin: EdgeInsets.all(viewportHeight * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter symptoms or any note for the hospital: ",
                border: OutlineInputBorder(),
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              style: TextStyle(
                fontFamily: "Poppins",
              ),
              maxLines: 10,
              onSaved: (String value) {
                noteAppointment = value;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: viewportHeight * 0.03),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              splashColor: Colors.white,
              elevation: 5,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text('Submit'),
              onPressed: () {
                _submitForm();
              },
            ),
          ],
        ));
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    confirmAppointment(
        context: context,
        note: noteAppointment,
        hospitalEmail: hospital.getEmail);
    setState(() {
      formVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!isPatient) {
      hospital = Hospital();
      Future.delayed(Duration(milliseconds: 500), () async {
        if (mounted &&
            refreshIndicatorKey.currentState.mounted &&
            refreshIndicatorKey != null) {
          await refreshIndicatorKey.currentState.show();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    hospitalUserProvider =
        hospitalUserProvider = Provider.of<HospitalUserProvider>(context);
    isPatient = SplashPage.isPatient;


    return Scaffold(
      appBar: isPatient
          ? AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                'Hospital Info',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 2,
              automaticallyImplyLeading: false,
            )
          : null,
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {
          if (!isPatient) {
            await fetchHospitalUserData(
                context: context, hospitalUserProvider: hospitalUserProvider);
          }
        },
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: viewportHeight * 0.02,
                ),
                _buildHeader(),
                _buildAddress(),
                Container(
                    margin: EdgeInsets.all(viewportHeight * 0.02),
                    padding: EdgeInsets.all(viewportHeight * 0.015),
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: Text(
                      isPatient
                          ? hospital.getNote
                          : hospitalUserProvider.getHospital.getNote,
                      style: TextStyle(
                          fontFamily: "BalooTamma2",
                          fontSize: viewportHeight * 0.02),
                    )),
                SizedBox(
                  height: viewportHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      splashColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        width: isPatient
                            ? viewportWidth * 0.4
                            : viewportWidth * 0.4,
                        height: viewportHeight * 0.06,
                        alignment: Alignment.center,
                        child: Text(
                          isPatient ? 'Book Appointment' : 'Edit Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: viewportHeight * 0.018,
                          ),
                        ),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        if (isPatient) {
                          setState(() {
                            formVisible = true;
                          });
                        } else {
                          Navigator.push(
                              context,
                              BouncyPageRoute(
                                widget: HospitalProfileEditScreen(),
                              ));
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: viewportHeight * 0.05),
                _buildTitle("Stats"),
                SizedBox(height: viewportHeight * 0.015),
                isPatient
                    ? (hospital.getTotalBeds == 0 ||
                            hospital.getAvailableBeds == 0)
                        ? _buildSkillRow("Beds", 0, 0, 0)
                        : _buildSkillRow(
                            "Beds",
                            hospital.getAvailableBeds / hospital.getTotalBeds,
                            hospital.getAvailableBeds,
                            hospital.getTotalBeds)
                    : (hospitalUserProvider.getHospital.getTotalBeds == 0 ||
                            hospitalUserProvider.getHospital.getAvailableBeds ==
                                0)
                        ? _buildSkillRow("Beds", 0, 0, 0)
                        : _buildSkillRow(
                            "Beds",
                            hospitalUserProvider.getHospital.getAvailableBeds /
                                hospitalUserProvider.getHospital.getTotalBeds,
                            hospitalUserProvider.getHospital.getAvailableBeds,
                            hospitalUserProvider.getHospital.getTotalBeds),
                SizedBox(height: 5.0),
                isPatient
                    ? hospital.getTotalDoctors == 0 ||
                            hospital.getAvailableDoctors == 0
                        ? _buildSkillRow("Doctors", 0, 0, 0)
                        : _buildSkillRow(
                            "Doctors",
                            hospital.getAvailableDoctors /
                                hospital.getTotalDoctors,
                            hospital.getAvailableDoctors,
                            hospital.getTotalDoctors)
                    : (hospitalUserProvider.getHospital.getTotalDoctors == 0 ||
                            hospitalUserProvider
                                    .getHospital.getAvailableDoctors ==
                                0)
                        ? _buildSkillRow("Doctors", 0, 0, 0)
                        : _buildSkillRow(
                            "Doctors",
                            hospitalUserProvider
                                    .getHospital.getAvailableDoctors /
                                hospitalUserProvider
                                    .getHospital.getTotalDoctors,
                            hospitalUserProvider
                                .getHospital.getAvailableDoctors,
                            hospitalUserProvider.getHospital.getTotalDoctors),
                SizedBox(height: 5.0),
                isPatient
                    ? hospital.getDistance == 0
                        ? _buildSkillRow(
                            "Displacement (km)", 0, 0, inputDistance)
                        : _buildSkillRow(
                            "Displacement (km)",
                            hospital.getDistance / inputDistance,
                            hospital.getDistance.toInt(),
                            inputDistance)
                    : Container(),
                SizedBox(height: viewportHeight * 0.04),
                _buildTitle("Contact Details"),
                SizedBox(height: viewportHeight * 0.015),
                Row(
                  children: <Widget>[
                    SizedBox(width: viewportWidth * 0.04),
                    Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      isPatient
                          ? hospital.getEmail
                          : hospitalUserProvider.getHospital.getEmail,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: viewportWidth * 0.04),
                    Icon(
                      Icons.web,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      isPatient
                          ? hospital.getWebsite
                          : hospitalUserProvider.getHospital.getWebsite,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: viewportWidth * 0.04),
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      isPatient
                          ? hospital.getPhoneNumber
                          : hospitalUserProvider.getHospital.getPhoneNumber,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                isPatient
                    ? Container()
                    : Container(
                        height: viewportHeight * 0.02,
                      ),
                isPatient
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            RaisedButton(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Colors.blue,
                                      style: BorderStyle.solid,
                                      width: 2)),
                              splashColor: Colors.blue,
                              onPressed: () {
                                showLogoutDialog(context);
                              },
                              child: Container(
                                  width: viewportWidth * 0.4,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: viewportWidth * 0.005),
                                  padding: EdgeInsets.only(
                                      top: viewportHeight * 0.012,
                                      bottom: viewportHeight * 0.012),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: viewportWidth * 0.02),
                                        child: Text(
                                          "Sign Out",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: viewportWidth * 0.05,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins"),
                                          textAlign: TextAlign.center,
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      Container(
                                          child: Icon(
                                        Icons.power_settings_new,
                                        size: viewportWidth * 0.075,
                                        color: Colors.blue,
                                      )),
                                    ],
                                  )),
                            )
                          ]),
                isPatient
                    ? Container()
                    : Container(
                        height: viewportHeight * 0.05,
                      )
              ],
            ),
            formVisible
                ? AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: (!formVisible)
                        ? null
                        : Center(
                            child: SingleChildScrollView(
                              child: Container(
                                color: Colors.black54,
                                height: viewportHeight,
                                alignment: Alignment.center,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: viewportHeight * 0.15,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: viewportWidth * 0.03),
                                          child: IconButton(
                                            color: Colors.white,
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              setState(() {
                                                formVisible = false;
                                              });
                                            },
                                          )),
                                      Container(
                                        alignment: Alignment.center,
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 300),
                                          child: _buildForm(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                : Container(),
          ],
        ),
      ),
    );
  }

  Row _buildSkillRow(String skill, double level, int avail, int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: viewportHeight * 0.02),
        Expanded(
            flex: 2,
            child: Text(
              skill,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: viewportHeight * 0.02),
              textAlign: TextAlign.left,
            )),
        Expanded(
            flex: 1,
            child: Container(
                child: LinearPercentIndicator(
              animation: true,
              addAutomaticKeepAlive: true,
              percent: level,
              animationDuration: 1500,
              lineHeight: viewportHeight * 0.015,
              linearStrokeCap: LinearStrokeCap.roundAll,
            ))),
        SizedBox(width: viewportWidth * 0.02),
        Expanded(
            child: Text(
          "$avail/$total",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Manrope"),
        )),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: viewportHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
                fontSize: viewportHeight * 0.025, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
        padding: EdgeInsets.only(
            top: viewportHeight * 0.02,
            left: viewportWidth * 0.04,
            right: viewportWidth * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.map,
              size: viewportHeight * 0.04,
              color: Colors.black,
            ),
            SizedBox(width: viewportWidth * 0.01),
            Flexible(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                  RichText(
                      text: TextSpan(
                          text: "Address: ",
                          style: TextStyle(
                              fontSize: viewportHeight * 0.022,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Manrope"),
                          children: <TextSpan>[
                        TextSpan(
                          text: isPatient
                              ? hospital.getAddress
                              : hospitalUserProvider.getHospital.getAddress,
                          style: TextStyle(
                              fontSize: viewportHeight * 0.022,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        )
                      ])),
                ]))),
          ],
        ));
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        SizedBox(width: viewportHeight * 0.02),
        Container(
            width: viewportWidth * 0.2,
            height: viewportHeight * 0.1,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage('assets/img/splash_bg.png')))),
        SizedBox(width: viewportWidth * 0.02),
        Flexible(
            child: Container(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isPatient
                  ? hospital.getName
                  : hospitalUserProvider.getHospital.getName,
              style: TextStyle(
                  fontSize: viewportHeight * 0.024,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"),
            ),
            SizedBox(height: viewportHeight * 0.01),
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: "Availability: ",
                    style: TextStyle(
                        fontSize: viewportHeight * 0.02,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Manrope"),
                    children: <TextSpan>[
                      TextSpan(
                        text: (isPatient
                                ? hospital.getAvailability
                                : hospitalUserProvider
                                    .getHospital.getAvailability)
                            ? "Available"
                            : "Not Available",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: (isPatient
                                    ? hospital.getAvailability
                                    : hospitalUserProvider
                                        .getHospital.getAvailability)
                                ? Colors.blue
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      )
                    ])),
            SizedBox(height: 5.0),
          ],
        )))
      ],
    );
  }

  void showLogoutDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return null;
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierLabel: '',
        transitionBuilder: (context, a1, a2, child) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                  opacity: a1.value,
                  child:
                      StatefulBuilder(builder: (BuildContext build, setState) {
                    return AlertDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () async {
                            Hospital hospital = Hospital();
                            hospitalUserProvider.setHospital = hospital;
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/auth", (Route<dynamic> route) => false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      title: Text("Sign Out"),
                      content: Container(
                        width: viewportWidth,
                        child: Text("Are you sure want to sign out?"),
                        padding: EdgeInsets.all(5),
                      ),
                    );
                  })));
        },
        transitionDuration: Duration(milliseconds: 200));
  }
}
