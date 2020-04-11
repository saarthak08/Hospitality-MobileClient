import 'package:flutter/material.dart';

void showLoadingDialog({@required BuildContext context}) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return null;
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, child) {
        return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  title: Text("Please Wait!"),
                  content: new Container(
                    child: new Column(
                      children: <Widget>[
                        Text("Loading..."),
                        Padding(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          padding: EdgeInsets.all(16.0),
                        )
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),
                  elevation: 8.0,
                )));
      },
      transitionDuration: Duration(milliseconds: 200));
}
