import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';
import 'package:hospitality/src/models/appointment.dart';

class AppointmentsListViewItem extends StatelessWidget {
  final Appointment appointment;
  static double viewportHeight;
  static double viewportWidth;

  AppointmentsListViewItem({@required this.appointment});

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: viewportHeight * 0.015,left: viewportWidth*0.01,right: viewportWidth*0.01),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
            splashColor: Colors.blue,
            onTap: () {},
            child: ListTile(
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon:
                          Icon(Icons.check_circle, size: viewportHeight * 0.04),
                      color: Colors.green,
                      onPressed: () {},
                    ), // icon-1
                    IconButton(
                      color: Colors.red,
                      icon: Icon(
                        Icons.cancel,
                        size: viewportHeight * 0.04,
                      ),
                      onPressed: () {},
                    ), // icon-1
                  ],
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: viewportHeight * 0.01),
                leading: Icon(
                  Icons.assignment,
                  size: viewportHeight * 0.05,
                  color: Colors.blue,
                ),
                title: Text(
                  appointment.getHospitalName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: viewportHeight * 0.021,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        text: "Date: ",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooTamma2"),
                        children: <TextSpan>[
                      TextSpan(
                        text: appointment.getDate,
                        style: TextStyle(
                            fontSize: viewportHeight * 0.018,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Manrope"),
                      ),
                      TextSpan(
                        text: "\nStatus: ",
                        style: TextStyle(
                            fontSize: viewportHeight * 0.02,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "BalooTamma2"),
                      ),
                      TextSpan(
                        text: appointment.getStatus,
                        style: TextStyle(
                            fontSize: viewportHeight * 0.018,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Manrope"),
                      )
                    ])))));
  }
}
