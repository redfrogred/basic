// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/Stored.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../classes/Sound.dart';

class Controller with ChangeNotifier {

  //  (this class) variables
  static const String _filename = 'Controller.dart'; 
  
  //  Helper classes !!
  Stored stored = Stored();   //  fetch the stored "cookie"

  //  Sounds!
  final alarm1        = Sound(sound_file: 'alarm1.mp3');
  final bell1         = Sound(sound_file: 'bell1.mp3');
  final hero_short1         = Sound(sound_file: 'hero_short1.mp3');

  void initApp() {
    //  Start_Page is loaded
    if( !Config.app_initialized ) { 
      Utils.log( _filename, 'initApp() called for the first time');
      //  add keyboard listener (if in debug mode only)
      if ( kDebugMode ) {
        RawKeyboard.instance.addListener(_handleKeyDown);
      }
      //  do any initial housekeeping here
      Config.app_initialized = true;
      //  see if Stored has fetched variables with appReady()
      appReady();
    }
    else {
      Utils.log( _filename, 'initApp() called, but ignored (cuz the App was already initialized)');
    }

  }

  //  appReady() is a recursive function that makes sure
  //  all of the needed stored values are retrieved from
  //  local storage...
  void appReady() {
    if( stored.ready == true ) { 
        Utils.log( _filename, 'Yes, the appReady() !!!' );
        stored.setVar( 'app_date_last_run', '2023-01-01' );  
        //  App is Ready, so do whatevs!
        hero_short1.play( 10 );      
        return;
    }
    else {
      Future.delayed( const Duration(milliseconds: 50 ), () async {
        appReady();
        return;
      });
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
        case '1':
          Utils.log(_filename, '_handleKeyDown = "$k"');  // factoryReset()
          bell1.play( 5 );
          break; 
        case '2':
          Utils.log(_filename, '_handleKeyDown = "$k"');  // factoryReset()
          alarm1.play( 5 );
          break;           
        case 'S':
          Utils.log(_filename, '_handleKeyDown = "$k"');  //  show stores vals
          stored.showAllStoredValues();
          break;
        case 'F':
          Utils.log(_filename, '_handleKeyDown = "$k"');  // factoryReset()
          stored.factoryReset();
          break;                
        case 'R':
          Utils.log(_filename, '_handleKeyDown = "$k"');  // 
          appReady();
          break;              
        default:
          Utils.log(_filename, '_handleKeyDown ( with unused key "$k" )');          
      }      
    }
  }  

}