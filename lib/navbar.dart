import 'package:flutter/material.dart';
import 'package:mb_player/colors.dart';
import 'package:mb_player/model/myaudio.dart';
import 'package:mb_player/screens/SongListPage.dart';
import 'package:mb_player/screens/getPicture.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatefulWidget {
  final String mood;

  const NavigationBar({Key key, this.mood}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  @override
  void initState() {
    // TODO: implement initState
    print(widget.mood);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarItem(
            icon: Icons.camera_alt_outlined,
          ),
          Text('Playing Now',style: TextStyle(fontSize: 20,color: darkPrimaryColor,fontWeight: FontWeight.w500),),
          NavBarItem(
            icon: Icons.list,
            mood: widget.mood,
          )
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String mood;

  const NavBarItem({Key key, this.icon, this.mood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
      builder:(_,myAudioModel,child)=> GestureDetector(
        onTap: () {
          if (icon == Icons.camera_alt_outlined) {
            myAudioModel.stopAudio();
            Navigator.push(context, MaterialPageRoute(builder: (_) => GetPicture()));
          }
          if (icon == Icons.list) {
            print(mood);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SongListPage(mood: mood,)));
          }
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: darkPrimaryColor.withOpacity(0.5),
              offset: Offset(5,10),
                spreadRadius: 3,
                blurRadius: 10
              ),
              BoxShadow(color: Colors.white,offset: Offset(-3,-4),spreadRadius: -2,blurRadius: 20
              )
            ],
              color: primaryColor, borderRadius: BorderRadius.circular(10)),
          child: Icon(
            icon,
            color: darkPrimaryColor,
          ),
        ),
      ),
    );
  }
}
