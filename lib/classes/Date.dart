// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import "package:intl/intl.dart";
import './Utils.dart';

//  Presenting the "Date" class version 1.01.
//  It is for... doing date and time stuff...

class Date {

  // (this page) variables
  static const String _filename = 'Date.dart';

  //  --------------------------------------------------------------------------------

  static String todaysDate () {
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  //  --------------------------------------------------------------------------------

  //  makeTimestampAsDateTime() takes no paramters, and
  //  returns a DateTime like
  //  "2022-11-27 13:04:26.233525"
  static DateTime makeTimestampAsDateTime() {
    final DateTime now = DateTime.now();
    Utils.log( _filename, 'makeTimestampAsDateTime() returns ' + now.toString());
    return now;
  }

    //  --------------------------------------------------------------------------------

  //  getFriendlyTime() takes a DateTime and returns
  //  a String like "1:11pm"
  static String getFriendlyTime( DateTime date ) {
    final DateFormat formatter = DateFormat('h:mm a');
    Utils.log( _filename, 'getFriendlyTime() returns ' + formatter.format(date).toLowerCase());
    return formatter.format(date).toLowerCase();
  }

  //  --------------------------------------------------------------------------------

  //  getRelativeTimeApart() takes 2 DateTimes and returns
  //  a human friendly timestamp like
  //  "moments", "22 hours", etc.
  static String getRelativeTimeApart( DateTime date1, DateTime date2 ) {
    final Duration diff = date1.difference(date2);
    final int weeks;
    final int years;

    // Utils.log(_filename, 'getRelativeTimeApart() returns a String...');

    if ( diff.inSeconds < 60 ) {
      return 'just now';
    }

    if ( diff.inSeconds < 3599 ) {
      return (diff.inMinutes).toString() + ' min';
    }

    if ( diff.inSeconds < 172800 ) {
      int hr = diff.inHours;
      int min = diff.inMinutes - (hr*60);
      return '${ hr }h ${ min }m';
    }

    if ( diff.inSeconds < 1209600 ) {
      return (diff.inDays).toString() + ' days';
    }

    // if it gets here is is over 2 weeks ago
    weeks = ((diff.inDays.toInt()) / 7).round();

    if ( weeks > 104 ) {
      years = ((weeks.toInt()) / 52).round();
      return years.toString() + ' years';
    }
    else {
      if ( weeks > 56 && weeks <= 104 ) {
        return 'over 1 year';
      }
    }

    // finally, if it gets here is it less than 2 years
    return weeks.toString() + ' weeks';
  }  

  //  --------------------------------------------------------------------------------

  //  getTimeApartInSeconds() takes 2 DateTimes and returns
  //  the number of seconds
  static int getTimeApartInSeconds( DateTime date1, DateTime date2 ) {
    final Duration diff = date1.difference(date2);
    return diff.inSeconds;
  }

  //  --------------------------------------------------------------------------------

  //  getTimeApartInDays
  static int getTimeApartInDays( DateTime date1, DateTime date2 ) {
    final Duration diff = date1.difference(date2);
    return diff.inDays;
  }  

  //  --------------------------------------------------------------------------------

  //  The "convertUnixTimestampToDate" method accepts 1 parameter:
  //    1 - an int to be converted to a friendly String
  //    Note: It assumes the param is in seconds, and
  //          if conversion was not possible it will
  //          return an empty string...

  static String convertUnixTimestampToDate( int date ) {

    String newStr = date.toString();
    var formattedDate = '';

    if ( newStr.length == 10) {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date*1000);
      final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
      formattedDate = formatter.format(dateTime);
    }
    return formattedDate;
  }

}