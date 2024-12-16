import 'package:amenda_cuts/Constants/FirebaseConstants/firebase_collection_contant.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  UsersModel _usersModel = UsersModel();
  UsersModel get usersModel => _usersModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  init() async {
    await getUserDetails();
    notifyListeners();
  }

  Future getUserDetails() async {
    final userId = user?.uid;
    if (user == null) {
      _usersModel = UsersModel(
        username: '',
        email: '',
      );
    } else {
      firestore
          .collection(FirebaseCollectionConstant.usersCollection)
          .doc(userId)
          .snapshots()
          .listen((snap) {
        Map<String, dynamic> userDetails = snap.data() as Map<String, dynamic>;
        _usersModel = UsersModel.fromFirebase(userDetails);
        notifyListeners();
        print(_usersModel);
      });
    }
  }
}
