import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login {
  static Future signInWithEmailAndPassword(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential result = await Apis.auth
          .signInWithEmailAndPassword(email: email, password: password);
      UserDetailsProvider userDetailsProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const BottomNavigator()));

      userDetailsProvider.getUserDetails();
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
