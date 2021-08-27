import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_maikel/common_widget/CircularProgress.dart';
import 'package:shop_maikel/common_widget/Product_Card.dart';


class Baby extends StatefulWidget {
  @override
  BabyState createState() => BabyState();
}

class BabyState extends State<Baby> {
  List<Map> Products=[];
  Future _future;
  getData() async{
    var fetch = await get('https://retail.amit-learning.com/api/products');
    if(fetch.statusCode==200){
      var data = json.decode(fetch.body);
      List products = data["products"];
      for(int i=0;i<=14;i++){
        if(products[i]["category_id"]==3){
          Products.add(products[i]);
        }
      }
    }
    int length = Products.length;
    print("Product lenth = $length");
  }
  @override
  void initState(){
    _future = getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:_future ,
      builder: (ctx,snapShot){
        if(snapShot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if (snapShot.connectionState==ConnectionState.done){
          return GridView.count(crossAxisCount: 2,
              children: List.generate(Products.length, (index){
                return ProductCard(Data: Products[index],);
              }));
        }
      },
    );
  }
}
