import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index);
                    }),
              ),
              // Container(
              //   height: 140,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: Theme.of(context).primaryColor,
              //       borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(30),
              //           bottomRight: Radius.circular(30))),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 30),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         IconButton(
              //           icon: Icon(
              //             Icons.arrow_back,
              //             color: Colors.white,
              //           ),
              //           onPressed: () => Navigator.pop(context),
              //         ),
              //         Text(
              //           "Appointment List",
              //           style: TextStyle(color: Colors.white, fontSize: 24),
              //         ),
              //         IconButton(
              //           icon: Icon(
              //             Icons.restore,
              //             color: Colors.white,
              //           ),
              //           onPressed: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:
                    Border.all(width: 3, color: Theme.of(context).accentColor),
                image: DecorationImage(
                    image: AssetImage('assets/img/splash_bg.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Patient Name',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Patient location',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13,
                              letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.school,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Patient note',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13,
                              letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
