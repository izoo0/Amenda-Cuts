import 'dart:convert';
import 'dart:math';
import 'package:amenda_cuts/Common/Widget/Alerts/new_alert.dart';
import 'package:amenda_cuts/Screens/Admin/Service/service.dart';
import 'package:amenda_cuts/Screens/User/Profile/user_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../Common/Constants/FirebaseConstants/firebase_service_constants.dart';

class NodeApi {
  NodeApi._constructor();

  static NodeApi instance = NodeApi._constructor();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> createService(
      {required String image,
      required String name,
      required String price,
      required String description,
      required String expertId,
      required String selectedCategory,
      required BuildContext context}) async {
    final uri = Uri.parse('http://192.168.170.54:8080/upload_image');
    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', image));
      var rng = Random();
      const length = 10;
      const characters =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      String serviceId = List.generate(
          length, (index) => characters[rng.nextInt(characters.length)]).join();
      request.fields['serviceId'] = serviceId;
      final response = await request.send();
      if (response.statusCode != 200) {
        return;
      }

      final responseData = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseData);

      if (decodedResponse['success'] == true) {
        final imageUrl = decodedResponse['image_url'];
        await firestore.collection('services').add({
          FirebaseServiceConstants.serviceName: name,
          FirebaseServiceConstants.serviceImage: imageUrl,
          FirebaseServiceConstants.serviceRatings: 5,
          FirebaseServiceConstants.servicePrice: price,
          FirebaseServiceConstants.serviceDescription: description,
          FirebaseServiceConstants.serviceIsDeleted: false,
          FirebaseServiceConstants.serviceCategory: selectedCategory,
          'image_id': serviceId,
          'expertId': expertId,
          'timestamp': Timestamp.now(),
        });
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Service()));
          showDialog(
              context: context,
              builder: (context) {
                return newAlert(
                    title: "Success",
                    context: context,
                    body: "Service created successfully",
                    icon: Iconsax.tick_circle);
              });
        }
      } else {
        //
      }
    } catch (e) {
      //
    }
  }

  Future<void> updateService(
      {required String image,
      required String name,
      required String price,
      required String description,
      required String expertId,
      required String selectedCategory,
      required BuildContext context,
      required String serviceId,
      required String docId}) async {
    final uri = Uri.parse('http://192.168.170.54:8080/edit_image');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.fields['serviceId'] = serviceId;
    final response = await request.send();
    if (response.statusCode != 200) {
      return;
    }
    final responseData = await response.stream.bytesToString();
    final decodedResponse = jsonDecode(responseData);
    if (decodedResponse['success'] == true) {
      final imageUrl = decodedResponse['image_url'];
      await firestore.collection('services').doc(docId).set({
        FirebaseServiceConstants.serviceName: name,
        FirebaseServiceConstants.serviceImage: imageUrl,
        FirebaseServiceConstants.servicePrice: price,
        FirebaseServiceConstants.serviceDescription: description,
        FirebaseServiceConstants.serviceCategory: selectedCategory,
        'expertId': expertId,
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Service()));
        showDialog(
            context: context,
            builder: (context) {
              return newAlert(
                  title: "Success",
                  context: context,
                  body: "Service updated successfully",
                  icon: Iconsax.tick_circle);
            });
      }
    } else {
      //
    }
  }

  Future<void> createUserProfile({
    required String image,
    required BuildContext context,
  }) async {
    final uri = Uri.parse('http://192.168.170.54:8080/upload_profile');
    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', image));
      final userId = user!.uid;
      request.fields['userId'] = userId;
      final response = await request.send();
      if (response.statusCode != 200) {}
      final responseData = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseData);

      if (decodedResponse['success'] == true) {
        final imageUrl = decodedResponse['user_profile'];
        await firestore.collection('users').doc(user!.uid).set({
          "profile": imageUrl,
        }, SetOptions(merge: true));
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const UserDetailsScreen()));
          showDialog(
              context: context,
              builder: (context) {
                return newAlert(
                    title: "Success",
                    context: context,
                    body: "Service created successfully",
                    icon: Iconsax.tick_circle);
              });
        }
      } else {
        //
      }
    } catch (e) {
      //
    }
  }

  Future<void> editUserProfile({
    required String image,
    required BuildContext context,
  }) async {
    final uri = Uri.parse('http://192.168.170.54:8080/edit_profile');
    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', image));
      final userId = user!.uid;
      request.fields['userId'] = userId;
      final response = await request.send();
      if (response.statusCode != 200) {}
      final responseData = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseData);

      if (decodedResponse['success'] == true) {
        final imageUrl = decodedResponse['user_profile'];
        await firestore.collection('users').doc(user!.uid).set({
          "profile": imageUrl,
        }, SetOptions(merge: true));
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const UserDetailsScreen()));
          showDialog(
              context: context,
              builder: (context) {
                return newAlert(
                    title: "Success",
                    context: context,
                    body: "Profile updated successfully",
                    icon: Iconsax.tick_circle);
              });
        }
      } else {
        //
      }
    } catch (e) {
      //
    }
  }
}
