import 'package:evently_c16/core/source/remote/FirestoreManager.dart';
import 'package:evently_c16/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser.User? user;

  getUser()async{
    print("my user id ${FirebaseAuth.instance.currentUser!.uid}");
    user = await FirestoreManager.getUser(FirebaseAuth.instance.currentUser!.uid);
    print("my user : ${user!.id}");
    notifyListeners();
  }
}