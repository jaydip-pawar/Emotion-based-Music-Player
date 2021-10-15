
import 'package:flutter/material.dart';
import 'package:mb_player/albumart.dart';
import 'package:mb_player/colors.dart';
import 'package:mb_player/model/myaudio.dart';
import 'package:mb_player/navbar.dart';
import 'package:mb_player/playerControls.dart';
import 'package:provider/provider.dart';

class SongsPage extends StatefulWidget {
  final String song_name, artist_name, song_url, image_url, mood;
  final int index;
  final List list;

  SongsPage({this.song_name, this.artist_name, this.song_url, this.image_url, this.index, this.list, this.mood});
  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  double sliderValue = 2;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => MyAudio(widget.song_url),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NavigationBar(mood: widget.mood,),
            Container(
              margin: EdgeInsets.only(left: 40),
              height: height / 2.5,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return AlbumArt(img_url: widget.image_url,);
                },
                itemCount: 1,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Text(
              widget.song_name,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: darkPrimaryColor),
            ),
            Text(
              widget.artist_name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: darkPrimaryColor),
            ),
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 5,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)
                  ),
                  child: Consumer<MyAudio>(
                    builder:(_,myAudioModel,child)=> Slider(
                      value: myAudioModel.position==null? 0 : myAudioModel.position.inMilliseconds.toDouble() ,
                      activeColor: darkPrimaryColor,
                      inactiveColor: darkPrimaryColor.withOpacity(0.3),
                      onChanged: (value) {
                        myAudioModel.seekAudio(Duration(milliseconds: value.toInt()));
                      },
                      min: 0,
                      max:myAudioModel.totalDuration==null? 20 : myAudioModel.totalDuration.inMilliseconds.toDouble() ,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Consumer<MyAudio>(
                    builder:(_,myAudioModel,child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(myAudioModel.position == null ? "00:00:00" : myAudioModel.position.toString().split('.').first,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: darkPrimaryColor),
                        ),
                        Text(myAudioModel.totalDuration == null ? "00:00:00" : myAudioModel.totalDuration.toString().split('.').first,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: darkPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            PlayerControls(
              index: widget.index,
              list: widget.list,
            ),

            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
