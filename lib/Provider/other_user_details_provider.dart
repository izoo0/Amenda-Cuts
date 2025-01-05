import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherUserDetailsProvider extends ChangeNotifier {
  List<OtherUsersModel> _otherUsersModel = [];
  List<OtherUsersModel> get otherUserModel => _otherUsersModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  init() async {
    await fetchOtherUsers();
    notifyListeners();
  }

  fetchOtherUsers() {
    try {
      firestore.collection('users').snapshots().listen((snap) {
        final data = snap.docs;

        if (data.isNotEmpty) {
          _otherUsersModel = data
              .map((doc) => OtherUsersModel.fromFirebase(doc.data(), doc.id))
              .toList();
          print('______________________________$_otherUsersModel');
          notifyListeners();
        } else {
          _otherUsersModel = [];
        }
      });
    } catch (e) {
      //
    }
  }
}
