import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality/src/dialogs/confirm_booking_appointment_dialog.dart';
import 'package:hospitality/src/models/hospital.dart';
import '../helpers/dimensions.dart';

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
  bool formVisible = false;
  double viewportHeight;
  double viewportWidth;
  int inputDistance;
  Hospital hospital;
  String noteAppointment;

  _HospitalInfoState({@required this.hospital, this.inputDistance});

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
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    if (hospital.getName != null) {
      //  _formData["name"] = hospital.getName;
    }
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      hospital.getNote,
                      style: TextStyle(
                          fontFamily: "BalooTamma2",
                          fontSize: viewportHeight * 0.02),
                    )),
                SizedBox(
                  height: viewportHeight * 0.04,
                ),
                _buildTitle("Stats"),
                SizedBox(height: viewportHeight * 0.015),
                hospital.getTotalBeds == 0 || hospital.getAvailableBeds == 0
                    ? _buildSkillRow("Beds", 0, 0, 0)
                    : _buildSkillRow(
                        "Beds",
                        hospital.getAvailableBeds / hospital.getTotalBeds,
                        hospital.getAvailableBeds,
                        hospital.getTotalBeds),
                SizedBox(height: 5.0),
                hospital.getAvailableDoctors == 0 ||
                        hospital.getTotalDoctors == 0
                    ? _buildSkillRow("Doctors", 0, 0, 0)
                    : _buildSkillRow(
                        "Doctors",
                        hospital.getAvailableDoctors / hospital.getTotalDoctors,
                        hospital.getAvailableDoctors,
                        hospital.getTotalDoctors),
                SizedBox(height: 5.0),
                hospital.getDistance == 0
                    ? _buildSkillRow("Displacement (km)", 0, 0, inputDistance)
                    : _buildSkillRow(
                        "Displacement (km)",
                        hospital.getDistance / inputDistance,
                        hospital.getDistance.toInt(),
                        inputDistance),
                SizedBox(height: viewportHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      splashColor: Colors.blue,
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        width: viewportWidth * 0.4,
                        height: viewportHeight * 0.06,
                        alignment: Alignment.center,
                        child: Text(
                          'Book Appointment',
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
                        setState(() {
                          formVisible = true;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: viewportHeight * 0.06),
                _buildTitle("Contact Details"),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: viewportWidth * 0.04),
                    Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      hospital.getEmail,
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
                      hospital.getContactNo,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
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
                child: LinearProgressIndicator(
              value: level,
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
                          text: hospital.getAddress,
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
              hospital.getName,
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
                        text: hospital.getAvailability
                            ? "Available"
                            : "Not Available",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.blue,
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
}
