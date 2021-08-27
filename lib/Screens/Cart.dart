import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Cart extends StatefulWidget {

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future _future;
  getData()async{
    List<Map> Products = [];
    final prefs =await SharedPreferences.getInstance();
    var data =json.decode(prefs.getString("UserData"));
    var db = await FirebaseFirestore.instance.collection('Users').doc(data['email']).collection('cart').get();
   return db;
  }
  @override
  void initState(){
    _future = getData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future:_future ,
        builder: (ctx,snapShot){
          if(snapShot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if (snapShot.connectionState==ConnectionState.done){
            final List<DocumentSnapshot> documents = snapShot.data.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image(image: NetworkImage(doc['avatar']),),
                    ),
                    title: Text(doc['name'],style: TextStyle(fontSize: 15),),
                    subtitle: Text(doc['price']+' LE'),
                    trailing: Container(
                      width: 110,
                      height: 40,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.remove,),iconSize: 15,),
                          Text("1"),
                          IconButton(onPressed: (){}, icon: Icon(Icons.add,),iconSize: 15,),

                        ],
                      ),
                    )
                    ,
                  ),
                ))
                    .toList());
          }
        },
      ),
    );
  }
}
