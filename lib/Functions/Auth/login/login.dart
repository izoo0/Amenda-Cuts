import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Screens/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login {
  static Future signInWithEmailAndPassword(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential result = await Apis.auth
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Home()));
    } catch (e) {
      print(e.toString());
      Navigator.of(context).pop();
      return showDialog(
          context: context,
          builder: (_) {
            return const AnimatedAlertDialog(
                title: 'Erorr', content: 'Incorrect username or password');
          });
    }
  }
}
