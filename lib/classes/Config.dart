// ignore_for_file: file_names

import 'package:flutter/material.dart';

//  Presenting the "Config" class (version 1.0)
//  This class is for "global variables" used by
//  the app.  Right now is is mostly colors.

class Config {
  
  static const  String    app_name                  = "basic";
  static const  String    app_version               = "1.0.alpha.1";
  
  // App status  
  static bool             app_initialized           = false;           //  after StartPage loaded, it is init'ed
    
    // timeouts and delays
  static int              server_timeout            = 10; // seconds
  static int              short_delay               = 500; // milliseconds
  static int              long_delay                = 1500; // milliseconds

  // global "CSS" styles
  static Color            main_background_color     = const Color(0xFF1A1A1A);
  static Color            main_font_color           = Colors.white;
  static const double     main_font_size            = 16;
  static Color            button_background_color   = Colors.cyan.shade400;
  static Color            accent1_color             = Colors.grey;
  static Color            accent2_color             = const Color(0xFF333333);
  static Color            hilite1_color             = Colors.cyan.shade400;

  // global "status" colors (for errors, warning, etc.)
  static List<Color> status_color = [
    Colors.grey,
    Colors.white,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

}