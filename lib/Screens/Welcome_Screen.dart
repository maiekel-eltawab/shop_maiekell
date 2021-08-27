import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_maikel/Home.dart';
import 'package:shop_maikel/Screens/Signup_Screen.dart';
import 'package:shop_maikel/Screens/login_Screen.dart';
import 'package:shop_maikel/delayed_animation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_maikel/delayed_animation.dart';

class welcome_screen extends StatefulWidget {
  @override
  _welcome_screenState createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  Future<String> LoginStatus;
  AnimationController _controller;

  @override
  void initState() {
    LoginStatus = Autologin();
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
    return FutureBuilder<String>(
        future: LoginStatus,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            if(snapshot.data=='Not logined'){
              return Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 150,
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
                            child: SvgPicture.asset("assets/icons/Ammit.svg"),
                            radius: 100.0,
                          )),
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Welcome to AMIT STORE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.white),
                      ),
                      delay: delayedAmount + 1000,
                    ),
                    SizedBox(
                      height: 200.0,
                    ),
                    DelayedAnimation(
                      child: ButtonUI("Sign Up"),
                      delay: delayedAmount + 2000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: GestureDetector(
                        child: Text(
                          "I Already have An Account".toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),onTap: (){Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: LoginScreen1()));} ,
                      ),
                      delay: delayedAmount + 3000,
                    ),
                  ],
                ),
              );
            }else{return Home();}
            }
          }
        );
  }

  Widget ButtonUI(String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: Signup()));
      },
      child: Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> Autologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("UserData")) {
      return "Logined";
    } else {
      return "Not logined";
    }
  }
}
