// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'Utils.dart';

//  Presenting the "SoundClip" class...
//  This class is a helper class for the just_audio package.  
//  It is instantiated 1x for every sound asset. (I am considering
//  a better approach -- but this way seems the most straighforward.)
//
//  Each time it is initialized, the constructor plays the sound 1x
//  at 0 volume in order to "prime" it.  Priming it makes it
//  load faster (since it gets cached), for the next time it gets
//  played, for realsies. 

class SoundClip {
  static const double _version = 1.03;  // the version of this class last updated July, 2022
  late AudioPlayer Sound1;
  final String fileName;
  static int soundClipCount     = 0;      // # of total sound clips played
  int thisClipCount             = 0;      // # of times *this* sound clip was played

  SoundClip( {required this.fileName} ) {
    Utils.log('***','[[ SoundClip() ver ${ _version.toString() } ]] class ("SoundClip.dart") initialized with "$fileName "');
    Sound1 = AudioPlayer();
    Sound1.setVolume(0);
    Sound1.play();
  }

  void dispose() {
    Utils.log('***','dispose() SoundClip class');
    Sound1.dispose();
  }

  void play( [double volume = 1.0 ] ) {
    soundClipCount++;
    thisClipCount++;
    Sound1.setAsset('assets/audio/' + fileName);
    Sound1.setVolume( volume );
    Utils.log('***','play ' + fileName + ' ( play count = $thisClipCount )');
    Sound1.play();
  }

  void kill() async {
    await Sound1.stop();
  }

  void pause() async {
    await Sound1.pause();
  }

  void resume() async {
    await Sound1.play();
  }

  void fade() {
    Timer? _timerInterval;
    double num = 1.0;

    void lowerVolume() {
      num = num - .01;
      if ( num > 0 ) {
        Sound1.setVolume( num ); 
      }
      else {
        _timerInterval?.cancel();
        Sound1.stop();
      }
      return;       
    } 

    _timerInterval = Timer.periodic(const Duration(milliseconds: 10 ), (timer) {
      lowerVolume();
    });

  }

}