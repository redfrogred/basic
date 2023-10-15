import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

  //  (this class) variables
  static const String _filename = 'Controller.dart'; 
  
  void initApp() {
    //  Start_Page is loaded
    if( !Config.app_initialized ) { 
      Utils.log( _filename, 'initApp() called for the first time');
      //  do any initial housekeeping here
      Config.app_initialized = true;
    }
    else {
      Utils.log( _filename, 'initApp() called, but ignored (cuz the App was already initialized)');
    }

  }
  
  // APP STUFF
  String getAppInfo() {
    return Config.app_version;
  }

}