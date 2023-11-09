import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> testLogin(String email, String password) async{

  final FirebaseAuth auth = FirebaseAuth.instance;

  final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password
  );

  if (credential != null){
    return true;
  }
  return false;

}

