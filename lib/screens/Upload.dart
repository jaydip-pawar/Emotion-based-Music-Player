import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mb_player/colors.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  final String mood;

  const Upload({Key key, this.mood}) : super(key: key);
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController songname = TextEditingController();
  TextEditingController artistname = TextEditingController();

  File image, song;
  String imagepath, songpath;
  Reference ref;
  var image_down_url, song_down_url;
  final firestoreinstance = FirebaseFirestore.instance;

  void selectimage() async {
    image = await FilePicker.getFile();

    setState(() {
      image = image;
      imagepath = basename(image.path);
      uploadimagefile(image.readAsBytesSync(), imagepath);
    });
  }

  Future<String> uploadimagefile(List<int> image, String imagepath) async {
    ref = FirebaseStorage.instance.ref().child(imagepath);
    UploadTask uploadTask = ref.putData(image);

    image_down_url = await (await uploadTask).ref.getDownloadURL();
  }

  void selectsong() async {
    song = await FilePicker.getFile();

    setState(() {
      song = song;
      songpath = basename(song.path);
      uploadsongfile(song.readAsBytesSync(), songpath);
    });
  }

  Future<String> uploadsongfile(List<int> song, String songpath) async {
    ref = FirebaseStorage.instance.ref().child(songpath);
    UploadTask uploadTask = ref.putData(song);

    song_down_url = await (await uploadTask).ref.getDownloadURL();
  }

  finalupload(context) {
    if (songname.text != '' &&
        song_down_url != null &&
        image_down_url != null) {
      print(songname.text);
      print(artistname.text);
      print(song_down_url);
      print(image_down_url.toString());

      var data = {
        "song_name": songname.text,
        "artist_name": artistname.text,
        "song_url": song_down_url.toString(),
        "image_url": image_down_url.toString(),
      };

      firestoreinstance
          .collection(widget.mood)
          .doc()
          .set(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else if(songname.text != '' &&
        song_down_url != null){
      var data = {
        "song_name": songname.text,
        "artist_name": artistname.text,
        "song_url": song_down_url.toString(),
        "image_url": "https://firebasestorage.googleapis.com/v0/b/mb-player-eec74.appspot.com/o/default_thumbnail.jpg?alt=media&token=bfe4fe54-a852-4cff-9e6e-7743827d2215",
      };

      firestoreinstance
          .collection(widget.mood)
          .doc()
          .set(data)
          .whenComplete(() => showDialog(
        context: context,
        builder: (context) =>
            _onTapButton(context, "Files Uploaded Successfully :)"),
      ));
    }else {
      showDialog(
        context: context,
        builder: (context) =>
            _onTapButton(context, "Please Enter All Details :("),
      );
    }
  }

  _onTapButton(BuildContext context, data) {
    return AlertDialog(title: Text(data));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            color: primaryColor,
            onPressed: () => selectimage(),
            child: Text(
              "Select Image",
              style: TextStyle(color: darkPrimaryColor),
            ),
          ),
          RaisedButton(
            color: primaryColor,
            onPressed: () => selectsong(),
            child: Text(
              "Select Song",
              style: TextStyle(color: darkPrimaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              style: TextStyle(color: darkPrimaryColor),
              controller: songname,
              decoration: InputDecoration(
                hintText: "Enter song name",
                hintStyle: TextStyle(color: darkPrimaryColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              style: TextStyle(color: darkPrimaryColor),
              controller: artistname,
              decoration: InputDecoration(
                hintText: "Enter artist name",
                focusColor: darkPrimaryColor,
                hintStyle: TextStyle(color: darkPrimaryColor),
              ),
            ),
          ),
          SizedBox(height: 20,),
          RaisedButton(
            color: primaryColor,
            onPressed: () => finalupload(context),
            child: Text(
              "Upload",
              style: TextStyle(color: darkPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
