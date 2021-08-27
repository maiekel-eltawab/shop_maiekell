import 'package:flutter/material.dart';
import 'package:shop_maikel/common_widget/Tab_Bar.dart';
import 'package:shop_maikel/delayed_animation.dart';

import 'common_widget/SearchWidget.dart';
import 'common_widget/TopPromoSlider.dart';
import 'common_widget/PopularMenu.dart';


class Home_Page extends StatefulWidget {

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page>  with SingleTickerProviderStateMixin{
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
    return Container(
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DelayedAnimation(child: SearchWidget(),delay: delayedAmount+1000,),
              DelayedAnimation(child: TopPromoSlider(),delay: delayedAmount+2000,),
              DelayedAnimation(child: PopularMenu(),delay: delayedAmount+3000,),
              DelayedAnimation(child: Tab_Bar(),delay: delayedAmount+4000,),

            ],
          )),
    );
  }
}
