// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'Utils.dart';
import 'Date.dart';

//  Presenting the "Stored" class version 1.03...
//  This class uses the shared_preferences package, with the goal
//  of making it super-easy to grab and change Strings and ints
//  locally, very much like cookies in the web world.
//
//  It uses 2 hash maps: 
//  - one for Strings called "str", and
//  - one for ints called "num"
//
//  The "Getter"
//  The magic is in using the hashmaps, where the names of Strings and
//  ints get defined in one place.  These maps are used when the
//  the class first initialized, by looping through the map, and
//  pulling out the corresponding values for each key.  If no key is found
//  an int defaults to 0, and a String defaults to ''.  
//
//  The "Setter"
//  Another piece of magic is in setting a key-value pair.  The method
//  "setVar" detects if the key is a String or an int, and saves
//  the new value accordingly.
//
//  The "num" Map and "str" Map are mandatory, but they can be empty
//  if they are not used.  

class Stored {

  //  (this page) variables
  static const String _filename     = 'Stored.dart';
  static const double _version      = 1.03;  // the version of this class last updated 2023-10-08
  static const bool   _add_to_log   = true;
  static bool _ready = false;
  static late SharedPreferences     prefs;

  //  bool ready => get _ready;
  bool get ready => _ready;

  //  create an associative array for all of the stored 
  //  integers... if there are no values, use: Map<String, int> num = {}
  Map<String, int> num = {
    'app_loaded_total_num'            : 0,
    'app_days_since_last_use'         : 0,
  };

  //  create an associative array for all of the stored 
  //  Strings... if there are no values, use: Map<String, String> str = {}
  Map<String, String> str = {
    'app_date_first_run'              : '',
    'app_date_last_run'               : '',
    'app_last_lifecycle_event'        : '',
  };

  Stored() {
    Utils.log( _filename, 'init version $_version' ); 
    init();
  }

  Future init() async  {
    prefs = await SharedPreferences.getInstance();

    // ********************
    // *** GETTER LOOPS ***
    // ********************    

    //  FIRST do the INTs !

    //  "num" is hash map (also known as an associative array).  
    //  It maps out "num's" into key/value pairs with a big loop...
    if ( num.isNotEmpty ) {
      if ( _add_to_log ) { Utils.log( _filename, 'Stored() num.length =  ' + num.length.toString()); }
        
      num.forEach((String key, int value) { 
        if ( prefs.getInt(key) != null ) {
          num[key] = prefs.getInt(key)!;
        }
        //  below show all the key/value pairs
        //  Utils.log ('$key = ${ num[key].toString() } ');
      });
    }
    else {
      Utils.log( _filename, 'Stored() num.length =  0' );
    }

    //  NOW do the STRINGs !

    if ( str.isNotEmpty ) { 
        
      if ( _add_to_log ) { Utils.log( _filename, 'Stored() str.length =  ' + str.length.toString()); }
      str.forEach((String key, String value) { 
        if ( prefs.getString(key) != null ) {
          str[key] = prefs.getString(key)!;
        }
        //  below show all the key/value pairs
        if ( _add_to_log ) { Utils.log ( _filename, '$key = ${ str[key] } ' ); }
      });
    }
    else {
      Utils.log( _filename, 'Stored() str.length =  0');
    }

    //  bump up the app loaded count
    incrementAppLoaded();
  }

  // ***************
  // *** SETTER  ***
  // ***************    

  //  this checks to see if it is an int or String, and
  //  saves the associative array accordingly  
  void setVar ( String k, var v ) {
    
    if ( _add_to_log ) { Utils.log( _filename, 'Stored.setVar() $k = $v'); }

    if ( v.runtimeType == String ) {
      prefs.setString(k, v);
      str[k] = v;
      
      if ( _add_to_log ) { Utils.log( _filename, 'setString $k = "$v"'); }
    }
    else {
      prefs.setInt(k, v);
      num[k] = v;
      
      if ( _add_to_log ) { Utils.log( _filename, 'setInt $k = ${ v.toString() }'); }
    }
    return;
  }

  // bump up the app loaded count
  void incrementAppLoaded() {
    int? c = num[ 'app_loaded_total_num' ]!;
    String? l = str[ 'app_date_last_run' ]!;

    //  today's date
    String todays_date = Date.todaysDate();

    //  is this first ever app run?
    if ( c == 0 ) {
      setVar('app_date_first_run', todays_date );
      setVar('app_date_last_run', todays_date );
      setVar('app_days_since_last_use', 0);
    }
    else {
      //  store app_days_since_last_use
      int d = Date.getTimeApartInDays( DateTime.parse(todays_date), DateTime.parse(l) );
      setVar('app_days_since_last_use', d);
    }

    //  store app loaded count
    c++;
    num[ 'app_loaded_total_num' ] = c;
    setVar('app_loaded_total_num', c);
    
    if ( _add_to_log ) { Utils.log(  _filename, 'incrementAppLoaded() | app_loaded_total_num = ' + num[ 'app_loaded_total_num' ].toString() ); }

    //  d
    _ready = true;
  }  

  //  show all stored values!
  void showAllStoredValues() {
    String show_str = 'showAllStoredValues() ( int -> ';

    if ( num.isNotEmpty ) {
      num.forEach((String key, int value) { 
        if ( prefs.getInt(key) != null ) {
          show_str += '$key=' + prefs.getInt(key)!.toString() + ', ';
        }
      });
    }
    //  cut off any dangling commas
    show_str = Utils.fixDanglingComma(show_str);

    show_str += ' ) ( String -> '; 

    if ( str.isNotEmpty ) { 
      str.forEach((String key, String value) { 
        if ( prefs.getString(key) != null ) {
          show_str += '$key="' + prefs.getString(key)!.toString() + '", ';
        }
      });
    }
    //  cut off any dangling commas
    show_str = Utils.fixDanglingComma(show_str);    
    show_str += ' )'; 

    
    Utils.log(  _filename, show_str );
    return;
  }

  void factoryReset() async {
    if ( str.isNotEmpty ) {
      Utils.log( _filename, 'factoryReset() with str.length =  ' + str.length.toString());  
      str.forEach((String key, String value) { 
        if ( prefs.getString(key) != null ) {
          setVar(key,'');
        }
      });
    }    
    if ( num.isNotEmpty ) {
      Utils.log( _filename, 'factoryReset() with num.length =  ' + num.length.toString());  
      num.forEach((String key, int value) { 
        if ( prefs.getInt(key) != null ) {
          setVar(key,0);
        }
      });
    }      
    return;
  }

}