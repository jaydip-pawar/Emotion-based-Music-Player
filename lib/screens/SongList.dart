import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mb_player/colors.dart';
import 'package:mb_player/screens/Songspage.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  final String mood;

  const SongList({Key key, this.mood}) : super(key: key);
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<DocumentSnapshot> _list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.mood)
            .orderBy('song_name')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _list = snapshot.data.docs;

            return ListView.custom(
                childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildList(context, _list[index], index, _list);
              },
              childCount: _list.length,
            ));
          }
        },
      ),
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot documentSnapshot,
      int index, List list) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SongsPage(
                song_name: documentSnapshot.data()["song_name"],
                artist_name: documentSnapshot.data()["artist_name"],
                song_url: documentSnapshot.data()["song_url"],
                image_url: documentSnapshot.data()["image_url"],
                list: list,
                index: index,
                mood: widget.mood,
              ),
            ),
          );
        },
        child: Card(
          color: primaryColor,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              documentSnapshot.data()["song_name"],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          elevation: 10.0,
        ),
      ),
    );
  }
}
