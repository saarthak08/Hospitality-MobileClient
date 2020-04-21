import 'package:flutter/material.dart';
import 'package:hospitality/src/helpers/dimensions.dart';

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
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      title: Text(
                        "Loading...",
                        style: TextStyle(
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      content: Padding(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: getViewportWidth(context) * 0.25,
                              vertical: getViewportHeight(context) * 0.02))),
                ));
      },
      transitionDuration: Duration(milliseconds: 200));
}
