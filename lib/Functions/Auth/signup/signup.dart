import 'package:amenda_cuts/Auth/SignIn/sign_in.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Constants/FirebaseConstants/user_details_constants.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup {
  static Future<User?> registerWithEmailAndPassword(
      {required String username,
      required String phone,
      required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await Apis.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await Apis.firestore.collection('users').doc(user.uid).set({
          UserDetailsConstants.username: username,
          UserDetailsConstants.email: email,
          UserDetailsConstants.phoneNumber: phone
        });
      }
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SignIn()));
      showDialog(
          context: context,
          builder: (_) {
            return const AnimatedAlertDialog(
              title: 'Sign Up',
              content: "Your accout has been registerd successfully",
            );
          });
      return user;
    } catch (e) {
      //
      return null;
    }
  }
}
