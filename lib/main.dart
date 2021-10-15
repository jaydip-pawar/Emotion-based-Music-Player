import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mb_player/my_http_overrides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mb_player/screens/getPicture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music Player App",
      theme: ThemeData(
        fontFamily: 'Circular',
        primarySwatch: Colors.blue,
      ),
      home: GetPicture(),
    );
  }
}

