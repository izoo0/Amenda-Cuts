import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Screens/OnBoarding/on_boardig_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut {
  // Method to sigßn out
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnBoardigTwo()));
      showDialog(
          context: context,
          builder: (_) {
            return const AnimatedAlertDialog(
              title: 'SignOut',
              content: "You have signedout successfully",
            );
          });
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
