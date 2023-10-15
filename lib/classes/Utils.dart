// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';

//  Presenting the dead simple "Utils" class.
//  This version does only one thing: it
//  does console logs (with a timestamp and
//  a ">>" which is used to filter stuff out
//  in the debug console.)
//  For a *REALLY* thourough explanation see END NOTES below...

class Utils {

  // (this page) variables
  static const String _filename = 'Utils.dart';
  //  the first timestamp
  static final int _original_timestamp = DateTime.now().millisecondsSinceEpoch;
  //  running Log String
  static String _running_log = '';  //  this is a capture of what console.log has printed
  
  //  ==============================
  //  return current timestamp in ms
  //  ==============================
  static int timeStampNow () {
    return DateTime.now().millisecondsSinceEpoch;
 }
  
  //  ==============================
  //  return the ms difference in this timestamp
  //  and the original one
  //  ==============================  
  static String showTimeDiff ( [bool allowHtml = false ]) {
    String val = '';
    int diff = timeStampNow() - _original_timestamp;
    double minute = 0;
    if ( diff < 60000 ) {
      double seconds = diff * .001;
      val = '${seconds.toStringAsFixed(1)}s';
    }
    else {
      minute = diff/60000;
      double remainder = diff%60000;
      remainder = remainder*.001;
      val = '${minute.toInt()}m ${remainder.toStringAsFixed(1)}s';
    }
    //  if value has a minus, remove it!
    if ( val == '-0.0s' ) {
      val = '0.0s';
    }
    return val;
  }

  //  =============
  //  == The LOG ==
  //  =============
  //  This takes 2 paramaters.
  //    1. filename is the calling file
  //    2. message is the message to log
  //  NOTE: If the file name is blacklisted it
  //        will not be shown 
  static void log( String filename, String message ) {
    if ( !blacklist.contains( filename )) {
      if ( kDebugMode ) {
        print('(${ showTimeDiff() }) >> ($filename) $message');
      }
      _running_log += "(${ showTimeDiff() }) >> ($filename) $message\r\n";
    }
  }




  //  ============
  //  STRING STUFF
  //  ============

  //  The "truncateStr" accepts 3 parameters:
  //    1 - the String to be chopped
  //    2 - where to chop it (int)
  //    3 - an optional cutOffStr (defaults to "...")

  static String truncateStr ( String str, int passedCutOff, [ cutOffStr = '...' ] ) {
    int cutOff = passedCutOff + 3;
    String newStr = str;
    if ( str.length > cutOff ) {
      newStr = '${str.substring(0, cutOff)}$cutOffStr';
    }
    return newStr;
  }  

  
  //  fixDanglingComma() takes a String and
  //  chops off any dangling ", " from it.
  //  If the string is empty, or does not end
  //  with a dangling comma, it will return
  //  the same string that was passed.
  static String fixDanglingComma( String str ) {
    String  return_str = '';
    List<String> pieces = [];
    int num = str.length;
    //  first check length ( needs to be greater than 2 )
    if ( num < 3 ) {
      Utils.log( _filename, 'fixDanglingComma() did nothing');
      return str; // return the original string
    } 
    else {
      if ( str.substring(str.length - 2) != ', ') {
        Utils.log( _filename, 'fixDanglingComma() did nothing');
        return str; // return the original string
      }
      else {
        //  now split on commas
        pieces = str.split(', ');
        num = pieces.length;
        //  if there are more than 1 piece, git rid of the last one
        if ( num > 1 ) {
          for ( int i = 0; i < num; i++ ) {
            return_str += pieces[i];
            if ( i < (num -2)) {
              return_str += ', ';
            }
          }  
        }
        else {
          Utils.log( _filename, 'fixDanglingComma() did nothing');
          return str; // return the original string
        }
      } 
    }

    Utils.log( _filename, 'fixDanglingComma() returns "$return_str"');
    return return_str;
  }    


  //  BLACKLIST
  static List<String> blacklist = [
    /*
    'Utils.dart',
    'Controller.dart',
    'Stored.dart',
    'Start_Page.dart'
    */
    'Stored.dart'
  ];

}
//  END NOTES
//  The goal of this class is to have utility stuff in one place.
//  In the future, it will have:
//    * String methods (like truncation)
//    * More robust logging
//      + possibly a blacklist ( to not log certain files )
//      + possibly a "log" String ( to keep a running log, not just a console one )
//      + consider a hilite_list ( like blacklist, but adds formatting to hilite certain things )
  