// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../classes/Stored.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Controller with ChangeNotifier {

  //  (this class) variables
  static const String _fileName = 'Controller.dart'; 
  
  // Helper classes !!
  Stored stored = Stored();   //  fetch the stored "cookie"

  void initApp() {
    //  Start_Page is loaded
    if( !Config.app_initialized ) { 
      Utils.log( _fileName, 'initApp() called for the first time');
      //  do any initial housekeeping here
      Config.app_initialized = true;
    }
    else {
      Utils.log( _fileName, 'initApp() called, but ignored (cuz the App was already initialized)');
    }

  }
  




  //  =================
  //  STORED STUFF
  //  =================  
  //  This treats the stored variables like ineger or
  //  String cookies that can be rerieved through the Controller
  Future<int?> getStoredNumber( String key ) async {
    return stored.num[ key ];
  }  

  Future<String?> getStoredString( String key ) async {
    return stored.str[ key ];
  } 

}