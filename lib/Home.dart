import 'package:flutter/material.dart';
import 'package:shop_maikel/Categories/Categories.dart';
import 'package:shop_maikel/Home_Page.dart';
import 'package:shop_maikel/Screens/Cart.dart';
import 'package:shop_maikel/Screens/Menu.dart';

class Home extends StatefulWidget {
  final Widget x2;
  final int count;

  Home({this.x2,this.count});
  @override
  _HomeState createState() => _HomeState(x2: x2,count: count);
}

class _HomeState extends State<Home> {
  final Widget x2;
  final int count;
  _HomeState({this.x2,this.count});
  List<Widget>Page=[
    Home_Page(),
    Category(),
    Cart(),
    Body()
  ];
  Widget x = Home_Page();
  int myIndex = 0;
  @override
  void initState(){
    if(x2!=null){
      setState(() {
        x = x2;
        myIndex = count;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('Amit Store',
                style: TextStyle(
                    fontFamily: 'Varela', fontSize: 20.0, color: Colors.white)),
          ),
          body: x,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFEFEFEF),
            fixedColor: Colors.red,
            onTap: (index) {
              setState(() {
                myIndex = index;
                x = Page[index];
              });
            },
            currentIndex: myIndex,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home,), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined,),label: "Category" ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined,),label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_sharp),label: "Menu"),
            ],
          ),
        ));
  }
}
