import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Authenicate{
  String email;
  String password;

  Future<String> Login(String email,String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      String userData = json.encode({
        'email': email,
        'password': password
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("UserData", userData);
      print(prefs.getString("UserData"));
      return "Loggedin";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "UserError";
      } else if (e.code == 'wrong-password') {
        return "PasswordError";
      }
    }
  }
  Future<String> Autologin() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("UserData")){
      return"Logined";
    }else{return "Not Logined";}
  }
  Signup(String Name,String Email , String Mobile) async {


  }
}