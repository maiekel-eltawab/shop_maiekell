import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_maikel/Screens/DatailProducts.dart';

class ProductCard extends StatefulWidget {
  final Map Data;

  const ProductCard({Key key, this.Data}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(Data);
}

class _ProductCardState extends State<ProductCard> {
  final Map Data;

  _ProductCardState(this.Data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ],
            color: Colors.white),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 5,left: 5),
            child:             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:
            [
              Data['discount']!= 0?
              Data['discount_type']=="PERCENTAGE"?
              Text("${Data['discount']}% off",style: TextStyle(color: Colors.red),):
              Text("${(((Data['price']-Data["price_final"])/Data['price_final'])*100).toInt()}% off",style: TextStyle(color: Colors.red),)

                  :Container()
              ,Icon(Icons.favorite_border,
                color: Color(0xFFF80C28)),],),),
            GestureDetector(
              onTap: (){
                Details();
              },
              child: Column(
                children: [
                  Hero(
                      tag: NetworkImage(Data["avatar"]),
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(Data["avatar"]),
                                  fit: BoxFit.contain)))),
                  Text(Data["title"].toString().length<=17?
                  Data["title"]: Data["title"].toString().substring(0,17)+"...." ),
                  Text("Price : ${Data["price_final"]} LE"),
                ],
              ),
            ),
            Container(height:20,
                margin: EdgeInsets.only(right: 15,left: 15)
                ,child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius:
                  new BorderRadius.circular(10.0)),
              splashColor: Colors.white,
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_shopping_cart_outlined,size: 15,color: Colors.white,),
                  new Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  )
                ],
              ),
              onPressed: () => {},
            ),)
          ],
        ),
      )
    );
  }
  Details(){
    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Detail_Products(Data)));
  }
}
