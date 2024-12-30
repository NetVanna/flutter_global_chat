import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = "No Name";
  String country = "No Country";
  String email = "No Email";
  String userId = "No User Id";

  /// db for get all in firebase fire store
  /// currentUser need user id for get database by user id
  /// getData() this is function for get data from database
  var db = FirebaseFirestore.instance;

  void getUserDetails() {
    var currentUser = FirebaseAuth.instance.currentUser;
    db.collection("users").doc(currentUser!.uid).get().then(
      (dataSnapshot) {
        name = dataSnapshot.data()?["name"] ?? "";
        country = dataSnapshot.data()?["country"] ?? "";
        email = dataSnapshot.data()?["email"] ?? "";
        userId = dataSnapshot.data()?["userId"] ?? "";
        notifyListeners();
      },
    );
  }
}
