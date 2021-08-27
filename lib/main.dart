import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_maikel/Home.dart';
import 'package:shop_maikel/Provider/authenication.dart';
import 'package:shop_maikel/Screens/Welcome_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<FirebaseApp> _future = Firebase.initializeApp();
  @override
  void initState(){
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: welcome_screen(),
      ),
    );
  }
}
