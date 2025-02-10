// ignore_for_file: use_build_context_synchronously

import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Login {
  static Future signInWithEmailAndPassword(BuildContext context,
      {required String email, required String password}) async {
    try {
      Apis instance = Apis.instance;
      UserCredential result = await instance.auth
          .signInWithEmailAndPassword(email: email, password: password);
      String id = result.user!.uid;
      UserDetailsProvider userDetailsProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await userDetailsProvider.getUserDetails();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const BottomNavigator()));
    } catch (e) {
      Navigator.of(context).pop();
      return showDialog(
          context: context,
          builder: (_) {
            return AnimatedAlertDialog(
                icon: Icon(
                  Iconsax.info_circle,
                  color: Theme.of(context).primaryColor,
                ),
                title: 'Error',
                content: 'Incorrect username or password');
          });
    }
  }
}
