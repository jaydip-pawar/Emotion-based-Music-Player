import 'package:flutter/material.dart';
import 'package:mb_player/colors.dart';
import 'package:mb_player/screens/SongList.dart';
import 'package:mb_player/screens/Upload.dart';

class SongListPage extends StatefulWidget {
  final String mood;

  const SongListPage({Key key, this.mood}) : super(key: key);
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {

  int currentindex = 0;
  String mood;
  List tabs;

  @override
  void initState() {
    // TODO: implement initState
    mood = widget.mood;
    tabs = [
      SongList(mood: mood),
      Upload(mood: mood),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: darkPrimaryColor
        ),
        backgroundColor: primaryColor,
        elevation: 10,
        title: Text("Music Player App",
        style: TextStyle(
          color: darkPrimaryColor
        ),),
      ),
      body: tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedItemColor: darkPrimaryColor,
        currentIndex: currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black45),
            activeIcon: Icon(Icons.home, color: darkPrimaryColor,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload, color: Colors.black45),
            activeIcon: Icon(Icons.home, color: darkPrimaryColor,),
            label: "Upload",
          )
        ],
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
      ),
    );
  }
}
