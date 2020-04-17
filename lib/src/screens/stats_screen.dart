import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';

class HospitalStats extends StatefulWidget {
  @override
  _HospitalStatsState createState() => _HospitalStatsState();
}

class _HospitalStatsState extends State<HospitalStats> {
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double updateValue = 0;

  void editDialog(BuildContext context, String choice) {
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AlertDialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  title: Text(
                    'Update ' + choice,
                    style: TextStyle(
                      fontFamily: "BalooTamma2",
                    ),
                  ),
                  content: Container(
                    height: getViewportHeight(context) * 0.2,
                    child: Column(
                      children: <Widget>[
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  hintText: "Update " + choice,
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  contentPadding: EdgeInsets.all(10)),
                              keyboardType: TextInputType.number,
                              onSaved: (String value) {
                                if (value.length == 0) {
                                } else {
                                  updateValue = double.parse(value);
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Input count according to live data manually!',
                          style: TextStyle(fontFamily: "Manrope"),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {
                        _submitForm(context, choice);
                        _formKey.currentState.reset();
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _submitForm(BuildContext context, String choice) {
    _formKey.currentState.save();
    switch (choice) {
      case "Available Beds":
        {
          print("Available Beds");
        }
        break;

      case "Available Doctors":
        {
          print("Available Doctors");
        }
        break;

      case "Confirmed Appointments":
        {
          print("Confirmed Appointments");
        }
        break;

      case "Waiting":
        {
          print("Waiting");
        }
        break;

      case "Total Beds":
        {
          print("Total Beds");
        }
        break;

      case "Total Doctors":
        {
          print("Total Doctors");
        }
        break;

      case "On Leave":
        {
          print("On Leave");
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }

    print(updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20),
            child: Text(
              "Availability Stats",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Card(
            elevation: 4.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => editDialog(context, "Available Beds"),
                    child: ListTile(
                      leading: Container(
                        alignment: Alignment.bottomCenter,
                        width: 45.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 25,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 40,
                              width: 8.0,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 30,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                      title: Text("Available"),
                      subtitle: Text("18 beds"),
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: GestureDetector(
                    onTap: () => editDialog(context, "Available Doctors"),
                    child: ListTile(
                      leading: Container(
                        alignment: Alignment.bottomCenter,
                        width: 45.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 25,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 40,
                              width: 8.0,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              height: 30,
                              width: 8.0,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                      title: Text("Available"),
                      subtitle: Text("7 doctors"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.green,
                    icon: Icons.portrait,
                    title: "Confirmed Appointments",
                    data: "125",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: Icons.portrait,
                    title: "Waiting",
                    data: "4",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.hotel,
                    title: "Total Beds",
                    data: "82",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: Icons.healing,
                    title: "Total Doctors",
                    data: "38",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.invert_colors_off,
                    title: "On Leave",
                    data: "7",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildTile({Color color, IconData icon, String title, String data}) {
    return GestureDetector(
      onTap: () => editDialog(context, title),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: whiteText.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              data,
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
