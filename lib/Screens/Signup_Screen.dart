import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_maikel/Home.dart';
import 'package:shop_maikel/Screens/login_Screen.dart';
import 'package:shop_maikel/delayed_animation.dart';
import 'package:firebase_database/firebase_database.dart';

class Signup extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  Signup(
      {Key key, this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  final Email_controller = TextEditingController();
  final Password_Controller = TextEditingController();
  final Name_Controller = TextEditingController();
  final Mobile_Controller = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> _future = Firebase.initializeApp();

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: new Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: this.widget.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: new ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Column(
                        children: <Widget>[
                          DelayedAnimation(
                            child: AvatarGlow(
                              endRadius: 90,
                              duration: Duration(seconds: 2),
                              glowColor: Colors.white24,
                              repeat: true,
                              repeatPauseDuration: Duration(seconds: 2),
                              startDelay: Duration(seconds: 1),
                              child: Material(
                                  elevation: 8.0,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(
                                      Icons.people,
                                      size: 50.0,
                                      color: Colors.red,
                                    ),
                                    radius: 50.0,
                                  )),
                            ),
                            delay: delayedAmount + 500,
                          ),
                          DelayedAnimation(
                            child: Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            delay: delayedAmount + 1500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                DelayedAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Name",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: Name_Controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: Email_controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: Mobile_Controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your mobile number',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: Password_Controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                splashColor: this.widget.primaryColor,
                                color: Colors.red,
                                child: new Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "SIGNUP",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onPressed: () => {Sign_UP()},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ALREADY HAVE AN ACCOUNT?",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                onPressed: () => {Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen1()))},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  delay: delayedAmount + 2000,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Sign_UP() async {
    if(Name_Controller.text==""){
      showAlertDialog(context, "Name Error!", "Please Enter Your Name");
    }else{
      try {
        UserCredential user= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email_controller.text, password: Password_Controller.text);
        if(user!=null)
        {
          await FirebaseFirestore.instance.collection('Users').doc(Email_controller.text).set({
            'FullName':Name_Controller.text,
            'MobileNumber':Mobile_Controller.text,
            'Email':Email_controller.text,
          });

        }
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen1()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          showAlertDialog(context,"Password Weak!", 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          showAlertDialog(context,"Email Exists!", 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
  showAlertDialog(BuildContext context,String title,String content) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
