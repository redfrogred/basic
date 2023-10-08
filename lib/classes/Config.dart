// ignore_for_file: file_names

import 'package:flutter/material.dart';

//  Presenting the "Config" class (version 1.0)
//  This class is for "global variables" used by
//  the app.  Right now is is mostly colors.

class Config {
  
  static const  String    appName                = "basic";
  static const  String    appVersion             = "1.0.alpha.1";
  
  // App status  
  static bool             appInitialized         = false;           //  after StartPage loaded, it is init'ed
    
    // timeouts and delays
  static int              serverTimeout           = 10; // seconds
  static int              shortDelay              = 500; // milliseconds
  static int              longDelay               = 1500; // milliseconds

  // global "CSS" styles
  static Color            mainBackgroundColor     = const Color(0xFF1A1A1A);
  static Color            mainFontColor           = Colors.white;
  static const double     mainFontSize            = 16;
  static Color            buttonBackgroundColor   = Colors.cyan.shade400;
  static Color            accent1Color            = Colors.grey;
  static Color            accent2Color            = const Color(0xFF333333);
  static Color            hilite1Color            = Colors.cyan.shade400;

  // global "status" colors (for errors, warning, etc.)
  static List<Color> statusColor = [
    Colors.white,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

}