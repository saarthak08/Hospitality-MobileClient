import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/dimensions.dart';

class HospitalInfo extends StatefulWidget {
  @override
  _HospitalInfoState createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Hospital Info',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      borderRadius: BorderRadius.circular(25)),
                  splashColor: Colors.blue,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    width: getViewportWidth(context) * 0.42,
                    height: getViewportHeight(context) * 0.06,
                    alignment: Alignment.center,
                    child: Text(
                      'Book Appointment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Ubuntu",
                        fontSize: getViewportHeight(context) * 0.025,
                      ),
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () {},
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
                  'website.com',
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
        SizedBox(width: 20.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hospital name',
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
        )
      ],
    );
  }
}
