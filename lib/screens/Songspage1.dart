import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Songspage extends StatefulWidget {
  String song_name, artist_name, song_url, image_url;

  Songspage({this.song_name, this.artist_name, this.song_url, this.image_url});
  @override
  _SongspageState createState() => _SongspageState();
}

class _SongspageState extends State<Songspage> {

  Duration totalDuration;
  Duration position;
  String audioState;

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      print(updatedDuration);
      setState(() {
        totalDuration = updatedDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      print(updatedPosition);
      setState(() {
        position = updatedPosition;
      });
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if(playerState == AudioPlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState == AudioPlayerState.PLAYING)
        audioState = "Playing";
      if(playerState == AudioPlayerState.PAUSED)
        audioState = "Paused";

      setState(() {

      });
    });
  }

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map audioData = {'image': widget.image_url, 'url': widget.song_url};

    playAudio() {
      audioPlayer.play(widget.song_url);
    }

    pauseAudio() {
      audioPlayer.pause();
    }

    stopAudio() {
      audioPlayer.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player App"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                widget.song_name,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.artist_name,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Card(
                child: Image.network(widget.image_url, height: 350.0),
                elevation: 10.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Column(
                children: [
                  Text(totalDuration.toString().split('.').first),
                  Text(position.toString().split('.').first),
                  Text(audioState.toString()),
                  FlatButton(
                      onPressed: () {
                        playAudio();
                      },
                      child: Text("Play")),
                  FlatButton(
                      onPressed: () {
                        pauseAudio();
                      },
                      child: Text("Pause")),
                  FlatButton(
                      onPressed: () {
                        stopAudio();
                      },
                      child: Text("Stop")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
