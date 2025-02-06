// ignore_for_file: use_build_context_synchronously

import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Screens/OnBoarding/on_boarding_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignOut {
  static SignOut instance = SignOut._construct();

  SignOut._construct();

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingTwo()),
      );
      showDialog(
        context: context,
        builder: (_) {
          return AnimatedAlertDialog(
            icon: Icon(
              Iconsax.tick_circle,
              color: Theme.of(context).primaryColor,
            ),
            title: 'Sign Out',
            content: "You have signed out successfully",
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error signing out: $e");
      }
    }
  }
}
