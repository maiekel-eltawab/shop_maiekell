import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class Category extends StatefulWidget {

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Map> Products=[];
  Future _future;
  getData() async{
    var fetch = await get('https://retail.amit-learning.com/api/categories');
    if(fetch.statusCode==200){
      var data = json.decode(fetch.body);
      List products = data["categories"];
      return products;
    }
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
          print(snapShot.data);
          return GridView.count(crossAxisCount: 2,
                children: List.generate(snapShot.data.length, (index){
                  return Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 5.0)
                        ],
                        color: Colors.white),
                    child: Stack(
                      children: [
                        Hero(
                            tag: NetworkImage(snapShot.data[index]['avatar']),
                            child: Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapShot.data[index]['avatar']),
                                        fit: BoxFit.contain)))) ,
                        Center(
                          child: Text(snapShot.data[index]['name'],style: TextStyle(fontSize: 20,color: Colors.white,backgroundColor: Colors.black.withOpacity(0.5)),),
                        )
                      ],
                    ) ,
                  );
                })) ;
        }
      },
    );
  }
}
