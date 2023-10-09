// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      //  add keyboard listener (if in debug mode only)
      if ( kDebugMode ) {
        RawKeyboard.instance.addListener(_handleKeyDown);
      }
      //  do any initial housekeeping here
      Config.app_initialized = true;
      //  WILLFIX:  check if the app has been loaded before
      //            using Stored()
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

  //  ===============
  //  KEYBOARD CLICKS
  //  ===============
  void _handleKeyDown(RawKeyEvent value) {
    if( kReleaseMode || Config.keyboard_listener == false ) { 
      return; // Don't let these hooks slip into release!
    }
    if (value is RawKeyDownEvent) {
      final k = value.logicalKey.keyLabel;
      switch ( k ) {
        case 'S':
          Utils.log(_fileName, '_handleKeyDown = "$k"');
          stored.showAllStoredValues();
          break;
        default:
          Utils.log(_fileName, '_handleKeyDown ( with unused key "$k" )');          
      }      
    }
  }  

}