import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mb_player/model/detect_emotion.dart';
import 'package:mb_player/screens/SongListPage.dart';

class GetPicture extends StatefulWidget {

  const GetPicture({Key key}) : super(key: key);
  @override
  _GetPictureState createState() => _GetPictureState();
}

class _GetPictureState extends State<GetPicture> {

  File _image;
  String _mood;
  List _outputs;
  bool _loading = false;
  final imagePicker = ImagePicker();
  DetectEmotion _detectEmotion = DetectEmotion();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    _detectEmotion.getEmotion(_image).then((emotion) {
      if (emotion == "happy" || emotion == "sad" || emotion == "angry" || emotion == "neutral" || emotion == "fearful" || emotion == "disgusted" || emotion == "surprised")
        {
          setState(() {
            _mood = emotion;
          });
          print(emotion);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SongListPage(mood: emotion,)));
        }
      else{
        setState(() {
          _mood = "Face not detected";
        });
        print("Face not detected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getImage();
  }

  Widget checkError() {
    return _mood == "Face not detected" ? Column(
      children: [
        Text("Face not detected"),
        MaterialButton(
          onPressed: () async {
            final result = await FlutterRestart.restartApp();
            print(result);
          },
          child: Text("Try again..."),
        )
      ],
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 20,
            ),
            checkError(),
          ],
        )
      )
    );
  }
}
