import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyAudio extends ChangeNotifier{

  final String song_url;

  Duration totalDuration;
  Duration position;
  String audioState;

  MyAudio(this.song_url){
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();


  initAudio(){
    audioPlayer.onDurationChanged.listen((updatedDuration) {
        totalDuration = updatedDuration;
        notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
        position = updatedPosition;
        // if (position == totalDuration)
        //   audioState = "Stopped";
        notifyListeners();
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      audioState = "Stopped";
      stopAudio();
      seekAudio(Duration(milliseconds: 0));
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if(playerState == AudioPlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState==AudioPlayerState.PLAYING)
        audioState = "Playing";
      if(playerState == AudioPlayerState.PAUSED)
        audioState = "Paused";
      notifyListeners();
    });
  }

  playAudio(){
    // print("1" + song_url);
    audioPlayer.play(song_url);
  }

  playNext(String url) {
    audioPlayer.play(url);
  }

  pauseAudio(){
    audioPlayer.pause();
  }

  stopAudio(){
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek){
    audioPlayer.seek(durationToSeek);
  }

}