// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'Utils.dart';

//  Presenting the "Sound_Clip" class version 1.25 ...
//  This class is a helper class for the just_audio package.  
//  It is instantiated 1x for every sound asset. (I am considering
//  a better approach -- but this way seems the most straighforward.)
//
//  Each time it is initialized, the constructor plays the sound 1x
//  at 0 volume in order to "prime" it.  Priming it makes it
//  load faster (since it gets cached), for the next time it gets
//  played. 
//
//  For a *REALLY* thourough explanation see END NOTES below...

class Sound {
  
  // (this page) variables
  static const String _filename = 'Sound.dart';

  //  --------------------------------------------------------------------------------  
  
  late AudioPlayer _sound1;
  final String sound_file;
  static int _sound_count = 0;            // # of total sound clips played
  int _this_sound_count = 0;              // # of times *this* sound clip was played

  Sound( { required this.sound_file, bool loop = false }  ) {
    Utils.log( _filename,'initialized "$sound_file"');
    _sound1 = AudioPlayer();
    _sound1.setVolume(0);
    _sound1.play();
    if( loop ) {
      _sound1.setLoopMode( LoopMode.all);
    }
  }

  /*
  void dispose() {
    Utils.log( _filename,'dispose() Sound class');
    _sound1.dispose();
  }
  */

  void play( [double volume = 1.0 ] ) {
    _sound_count++;
    _this_sound_count++;
    _sound1.setAsset('assets/audio/' + sound_file);
    _sound1.setVolume( volume );
    Utils.log( _filename, 'play ' + sound_file + ' ( play count = $_this_sound_count )');
    _sound1.seek(const Duration(seconds: 0));
    _sound1.play();
  }

  void kill() async {
    await _sound1.stop();
  }

  void pause() async {
    await _sound1.pause();
  }

  void resume() async {
    await _sound1.play();
  }

  void mute() async {
    await _sound1.setVolume(0);
  }

  void unMute( [double volume = 1.0 ] ) async {
    await _sound1.setVolume( volume );
  }

  void fade() {
    Timer? _timerInterval;
    double num = 1.0;

    void lowerVolume() {
      num = num - .01;
      if ( num > 0 ) {
        _sound1.setVolume( num ); 
      }
      else {
        _timerInterval?.cancel();
        _sound1.stop();
      }
      return;       
    } 

    _timerInterval = Timer.periodic(const Duration(milliseconds: 10 ), (timer) {
      lowerVolume();
    });

  }
}
//  END NOTES
//  The goal of this class is to have all sound files 
//  using the same class.
//
//  The last thing I added was looping ability.