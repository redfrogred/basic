// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

//  Presenting the dead simple "Utils" class.
//  This version does only one thing: it
//  does console logs (with a timestamp and
//  a ">>" which is used to filter stuff out
//  in the debug console.)

class Utils {

  //  the first timestamp
  static final int _originalTimeStamp = DateTime.now().millisecondsSinceEpoch;
  
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
    int diff = timeStampNow() - _originalTimeStamp;
    double minute = 0;
    if ( diff < 60000 ) {
      double seconds = diff * .001;
      return '${seconds.toStringAsFixed(1)}s';
    }
    else {
      minute = diff/60000;
      double remainder = diff%60000;
      remainder = remainder*.001;
      return '${minute.toInt()}m ${remainder.toStringAsFixed(1)}s';
    }
  }

  //  =============
  //  == The LOG ==
  //  =============
  //  This takes 2 paramaters. (A third optional one is not used for this
  //  simple version of log.)
  //    1. filename is the calling file
  //    2. message is the message to log
  static void log( String filename, String message, [ int num = 2 ]) {
    if (kDebugMode) {
      print('(${ showTimeDiff() }) >>  ($filename) $message');
    }
  }

}
  