import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_maikel/Categories/BabyProduct.dart';
import 'package:shop_maikel/Categories/Electronics.dart';
import 'package:shop_maikel/Categories/Fashion.dart';
import 'package:shop_maikel/Categories/FetchData.dart';
import 'package:shop_maikel/Categories/Phones.dart';
import 'package:shop_maikel/Categories/SuperMarket.dart';
import 'package:shop_maikel/common_widget/HealthBeauty.dart';

class Tab_Bar extends StatefulWidget {
  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<Tab_Bar> with SingleTickerProviderStateMixin {
  List<Map> Fashion_Products = [];
  List<Map> Electronics_Products = [];
  int height;
  List Heights = [500.00];
  int _selectedIndex = 0;
  TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Fashion',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),
                Tab(
                  child: Text('Electronics',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),
                Tab(
                  child: Text('Baby product',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),Tab(
                  child: Text('Health & Beauty',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),
                Tab(
                  child: Text('Phones',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),
                Tab(
                  child: Text('Super Market',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                      )),
                ),
              ]),
          Container(
              height: 261,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                Fashion(),
                Electronics(),
                Baby(),
                Health(),
                Phones(),
                SuperMarket(),
              ]))
        ],
      ),
    );
  }

}
