import 'dart:convert';
import 'dart:io';
import 'package:amenda_cuts/Common/Widget/Alerts/new_alert.dart';
import 'package:amenda_cuts/Screens/Admin/Service/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../Common/Constants/FirebaseConstants/firebase_service_constants.dart';

class NodeApi {
  NodeApi._constructor();

  static NodeApi instance = NodeApi._constructor();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createService(
      {required File image,
      required String name,
      required String price,
      required String description,
      required String expertId,
      required String selectedCategory,
      required BuildContext context}) async {
    final uri = Uri.parse('http://192.168.33.213:8080/upload_image');
    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.fields['serviceId'] = 'my-id';
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
}
