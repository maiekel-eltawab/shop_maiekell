import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_maikel/Screens/Cart.dart';

import '../Home.dart';
class Detail_Products extends StatefulWidget {
  final Map Data;
  Detail_Products(this.Data);
  @override
  _Detail_ProductsState createState() => _Detail_ProductsState(Data);
}

class _Detail_ProductsState extends State<Detail_Products> {
  final databaseRef = FirebaseDatabase.instance.reference();

  final Map Data;

  _Detail_ProductsState(this.Data);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              },
                  icon: Icon(Icons.arrow_back_outlined, color: Colors.white,)),
              Text(Data["title"]
                  .toString()
                  .length <= 17 ?
              Data["title"] : Data["title"].toString().substring(0, 17) +
                  "...."),
              IconButton(onPressed: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Home(x2: Cart(),count: 2,)));

              },
                  icon: Icon(
                    Icons.shopping_cart_outlined, color: Colors.white,)),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                      tag: NetworkImage(Data["avatar"]),
                      child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(Data["avatar"]),
                                  fit: BoxFit.contain)))),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(onPressed: () {},
                                icon: Icon(Icons.favorite),
                                color: Colors.red,),
                            ),
                          )
                      ), SizedBox(height: 4,),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child:
                          IconButton(onPressed: () {}, icon: Icon(
                              Icons.add_shopping_cart_rounded), color: Colors
                              .white,),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                height: 1,
              ),
              Expanded(child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Data["name"], style: TextStyle(fontSize: 20,
                                  color: Color.fromRGBO(153, 0, 0, 1)),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Price : ${Data["price_final"]} LE",
                                    style: TextStyle(fontSize: 15,
                                        color: Color.fromRGBO(153, 0, 0, 1)),),
                                  SizedBox(width: 10,),
                                  Data['discount'] != 0 ?
                                  Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Text("${Data['price']}LE",
                                            style: TextStyle(fontSize: 10,
                                                color: Colors.redAccent),)
                                          , Container(
                                            height: 1,
                                            width: 40,
                                            color: Colors.grey,
                                          )
                                        ],
                                        alignment: Alignment.center,

                                      ),
                                      Data['discount_type'] == "PERCENTAGE" ?
                                      Text("${Data['discount']}% off",
                                        style: TextStyle(color: Colors.red),) :
                                      Text("${(((Data['price'] -
                                          Data["price_final"]) /
                                          Data['price_final']) * 100)
                                          .toInt()}% off",
                                        style: TextStyle(color: Colors.red),)
                                    ],
                                  ) : Container(),

                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black45.withOpacity(0.2),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0)
                            ],
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description", style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(153, 0, 0, 1)),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${Data['description']}", style: TextStyle(
                                    fontSize: 13, color: Colors.red),)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          margin: EdgeInsets.only(right: 40, left: 40)
                          , child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(10.0)),
                          splashColor: Colors.white,
                          color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_shopping_cart_outlined, size: 20,
                                color: Colors.white,),
                              new Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          onPressed: () =>
                          {
                            addtoCart()
                          },
                        ),)
                      ],
                    )
                ),
              ))
            ],
          ),
        ),
      ),);
  }

  addtoCart() async {
    final prefs =await SharedPreferences.getInstance();
    var data =json.decode(prefs.getString("UserData"));
    var db = await FirebaseFirestore.instance.collection('Users').doc(data['email']);
    await db.collection('cart').doc(Data['id'].toString()).set({
      'name':Data['name'],
      'avatar': Data['avatar'],
      'price': Data['price_final'].toString()
    });
}
}
