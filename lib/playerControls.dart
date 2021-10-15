import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mb_player/model/myaudio.dart';
import 'package:mb_player/screens/Songspage.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class PlayerControls extends StatefulWidget {
  int index;
  List list;

  PlayerControls({this.index, this.list});
  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot documentSnapshot = widget.list[widget.index];

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Controls(
            icon: Icons.replay_5,
            index: widget.index,
            list: widget.list,
            documentSnapshot: documentSnapshot,
          ),
          Controls(
            icon: Icons.skip_previous,
            index: widget.index,
            list: widget.list,
            documentSnapshot: documentSnapshot,
          ),
          PlayControl(),
          Controls(
            icon: Icons.skip_next,
            index: widget.index,
            list: widget.list,
            documentSnapshot: documentSnapshot,
          ),
          Controls(
            icon: Icons.forward_5,
            index: widget.index,
            list: widget.list,
            documentSnapshot: documentSnapshot,
          ),
        ],
      ),
    );
  }
}

class PlayControl extends StatefulWidget {
  @override
  _PlayControlState createState() => _PlayControlState();
}

class _PlayControlState extends State<PlayControl> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
      builder: (_, myAudioModel, child) => GestureDetector(
        onTap: () {
          myAudioModel.audioState == "Playing"
              ? myAudioModel.pauseAudio()
              : myAudioModel.playAudio();
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: darkPrimaryColor.withOpacity(0.5),
                  offset: Offset(5, 10),
                  spreadRadius: 3,
                  blurRadius: 10),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-3, -4),
                  spreadRadius: -2,
                  blurRadius: 20)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: darkPrimaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: darkPrimaryColor.withOpacity(0.5),
                            offset: Offset(5, 10),
                            spreadRadius: 3,
                            blurRadius: 10),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -4),
                            spreadRadius: -2,
                            blurRadius: 20)
                      ]),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Center(
                      child: Icon(
                    myAudioModel.audioState == "Playing"
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 50,
                    color: darkPrimaryColor,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Controls extends StatefulWidget {
  final IconData icon;
  final int index;
  final List list;
  final DocumentSnapshot documentSnapshot;

  const Controls(
      {Key key, this.icon, this.index, this.list, this.documentSnapshot})
      : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
      builder: (_, myAudioModel, child) => GestureDetector(
        onTap: () {
          if (widget.icon == Icons.replay_5) {
            Duration position = myAudioModel.position;
            int MPosition = position.inMilliseconds - 5000;
            myAudioModel.seekAudio(Duration(milliseconds: MPosition));
          }
          if (widget.icon == Icons.skip_previous) {
            DocumentSnapshot nextDocumentSnapshot =
                widget.list[widget.index - 1];
            myAudioModel.stopAudio();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SongsPage(
                  song_name: nextDocumentSnapshot.data()["song_name"],
                  artist_name: nextDocumentSnapshot.data()["artist_name"],
                  song_url: nextDocumentSnapshot.data()["song_url"],
                  image_url: nextDocumentSnapshot.data()["image_url"],
                  list: widget.list,
                  index: widget.index - 1,
                ),
              ),
            );
          }
          if (widget.icon == Icons.skip_next) {
            DocumentSnapshot nextDocumentSnapshot =
                widget.list[widget.index + 1];
            myAudioModel.stopAudio();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SongsPage(
                  song_name: nextDocumentSnapshot.data()["song_name"],
                  artist_name: nextDocumentSnapshot.data()["artist_name"],
                  song_url: nextDocumentSnapshot.data()["song_url"],
                  image_url: nextDocumentSnapshot.data()["image_url"],
                  list: widget.list,
                  index: widget.index + 1,
                ),
              ),
            );
          }
          if (widget.icon == Icons.forward_5) {
            Duration position = myAudioModel.position;
            int MPosition = position.inMilliseconds + 5000;
            myAudioModel.seekAudio(Duration(milliseconds: MPosition));
          }
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: darkPrimaryColor.withOpacity(0.5),
                  offset: Offset(5, 10),
                  spreadRadius: 3,
                  blurRadius: 10),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-3, -4),
                  spreadRadius: -2,
                  blurRadius: 20)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: darkPrimaryColor.withOpacity(0.5),
                            offset: Offset(5, 10),
                            spreadRadius: 3,
                            blurRadius: 10),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -4),
                            spreadRadius: -2,
                            blurRadius: 20)
                      ]),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Center(
                      child: Icon(
                    widget.icon,
                    size: 30,
                    color: darkPrimaryColor,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
