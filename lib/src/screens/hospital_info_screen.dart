import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality/src/models/hospital.dart';
import '../helpers/dimensions.dart';

class HospitalInfo extends StatefulWidget {
  final Hospital hospital;

  HospitalInfo({this.hospital});

  @override
  _HospitalInfoState createState() => _HospitalInfoState(hospital: hospital);
}

class _HospitalInfoState extends State<HospitalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool formVisible = false;
  double viewportHeight;
  double viewportWidth;
  Hospital hospital;

  _HospitalInfoState({@required this.hospital});

  Widget _buildForm() {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);

    return Container(
        margin: const EdgeInsets.all(16.0),
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
                hintText: "Enter Name",
                border: OutlineInputBorder(),
              ),
              onSaved: (String value) {
                //  _formData['name'] = value;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter note",
                border: OutlineInputBorder(),
              ),
              onSaved: (String value) {
                // _formData['password'] = value;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Status",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Address",
                border: OutlineInputBorder(),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Address can not be left empty.';
                }
                return null;
              },
              onSaved: (String value) {
                //  _formData['username'] = value;
              },
            ),
            const SizedBox(height: 10.0),
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
                  height: 15,
                ),
                _buildHeader(),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: Text(
                      "Our team of over 7000 doctors join us in giving you the best of modern healthcare to ensure you stay healthy, always."),
                ),
                _buildTitle("Availability"),
                SizedBox(height: 10.0),
                _buildSkillRow("Beds", 0.75),
                SizedBox(height: 5.0),
                _buildSkillRow("Doctors", 0.6),
                SizedBox(height: 5.0),
                _buildSkillRow("Distance", 0.65),
                SizedBox(height: 30.0),
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
                        width: viewportWidth * 0.42,
                        height: viewportHeight * 0.08,
                        alignment: Alignment.center,
                        child: Text(
                          'Book Appointment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Ubuntu",
                            fontSize: viewportHeight * 0.025,
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
                SizedBox(height: 30.0),
                _buildTitle("Contact"),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30.0),
                    Icon(
                      Icons.mail,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      hospital.getEmail == null
                          ? "website.com"
                          : hospital.getEmail,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(width: 30.0),
                    Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '8374639274',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: (!formVisible)
                  ? null
                  : SingleChildScrollView(
                      child: Container(
                        height: viewportHeight,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.black54,
                                alignment: Alignment.center,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: _buildForm(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        SizedBox(width: viewportHeight*0.02),
        Container(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 35.0,
                    backgroundImage: AssetImage('assets/img/splash_bg.png')))),
        SizedBox(width: 20.0),
        Flexible(
            child: Container(
                child: Column(
          children: <Widget>[
            Text(
              "fjskldjflaksdjfkldfklasdklfjaksdf;asdkfjsdlkfj",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Availability status'),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  'address',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )))
      ],
    );
  }
}
