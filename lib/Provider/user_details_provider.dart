import 'package:amenda_cuts/Common/Constants/FirebaseConstants/firebase_collection_constant.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  UsersModel _usersModel = UsersModel();
  UsersModel get usersModel => _usersModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  init() {
    getUserDetails();
    notifyListeners();
  }

  Future getUserDetails() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    if (id.isEmpty) {
      _usersModel = UsersModel(
        username: '',
        email: '',
      );
    } else {
      firestore
          .collection(FirebaseCollectionConstant.usersCollection)
          .doc(id)
          .snapshots()
          .listen((snap) {
        Map<String, dynamic> userDetails = snap.data() as Map<String, dynamic>;
        _usersModel = UsersModel.fromFirebase(userDetails, id);
        notifyListeners();
      });
    }
  }
}
