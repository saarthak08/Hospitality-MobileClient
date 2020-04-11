import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';

setSystemChromeSettings() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //statusBarColor: Color(0xff5db646),
      //systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Platform.operatingSystem == "android"
          ? Brightness.dark
          : Brightness.dark,
      statusBarBrightness: Platform.operatingSystem == "android"
          ? Brightness.light
          : Brightness.light,
      statusBarIconBrightness: Platform.operatingSystem == "android"
          ? Brightness.light
          : Brightness.light,
    ),
  );
}
