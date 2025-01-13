// ignore_for_file: unnecessary_cast

import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Constants/FirebaseConstants/firebase_collection_constant.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/controller/service_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Apis extends ChangeNotifier {
  static Apis instance = Apis._constructor();
  Apis._constructor();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final user = FirebaseAuth.instance.currentUser;

  Stream<List<ServiceModel>> fetchServices() {
    return firestore
        .collection(FirebaseCollectionConstant.serviceCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromFirebase(
            serviceData: doc.data() as Map<String, dynamic>,
            documentId: doc.id);
      }).toList();
    });
  }

  Stream<List<OrderModel>> fetchBooking() {
    return firestore
        .collection('booking')
        .where('userId', isEqualTo: user?.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      List<OrderModel> orders = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Future<OrderModel> orderModel =
            OrderModel.fromFirebase(orderModel: data, orderId: doc.id);
        String serviceId = data['serviceId'];

        // Fetch the associated service model
        DocumentSnapshot serviceSnapshot =
            await firestore.collection('services').doc(serviceId).get();

        ServiceModel serviceModel = ServiceModel(
            serviceName: '',
            serviceImage: '',
            serviceRatings: 0,
            servicePrice: '',
            description: '',
            favorite: [],
            documentId: '',
            serviceCategory: '',
            isDeleted: false);
        if (serviceSnapshot.exists) {
          Map<String, dynamic> serviceData =
              serviceSnapshot.data() as Map<String, dynamic>;
          serviceModel = ServiceModel.fromFirebase(
            serviceData: serviceData,
            documentId: serviceSnapshot.id,
          );
        }

        // Use the corrected getSingleService
        List<OrderModel> singleServiceOrders = await getSingleService(
          serviceModel: serviceModel,
          orderModel: orderModel,
        );

        // Add the result to the list
        orders.addAll(singleServiceOrders);
      }
      return orders;
    });
  }

  Future<void> bookNow(String documentId, String userId, date, time, location,
      BuildContext context) async {
    try {
      await firestore.collection('booking').add({
        'serviceId': documentId,
        'userId': userId,
        'timestamp': Timestamp.now(),
        'status': 'upcoming',
        'remindMe': false,
        'date': date,
        'time': time,
        'location': location,
      });

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavigator()));
        showDialog(
            context: context,
            builder: (context) {
              return const AnimatedAlertDialog(
                  title: "Success",
                  content: "You have made your booking successfully");
            });
      }
    } catch (e) {
      const AnimatedAlertDialog(
          title: "Error",
          content: "An error occurred while creating your booking");
    }
  }

  String getDateString(DateTime date) {
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endOfToday =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    DateTime startOfYesterday = todayStart.subtract(const Duration(days: 1));
    DateTime endOfYesterday =
        todayStart.subtract(const Duration(milliseconds: 1));
    if (date == DateTime(1980)) {
      return '';
    } else if (date.isAfter(todayStart) && date.isBefore(endOfToday)) {
      return DateFormat('HH:mm').format(date);
    } else if (date.isAfter(startOfYesterday) &&
        date.isBefore(endOfYesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat('d/M/yy').format(date);
    }
  }

  Future<void> remindMe(bool value, String docId) async {
    try {
      DocumentReference docRef = firestore.collection('booking').doc(docId);
      await docRef.update({'remindMe': !value});
    } catch (e) {
//
    }
  }

  Future<void> userFavorite(bool favorite, String docId, String userId) async {
    try {
      DocumentReference docRef = firestore.collection('services').doc(docId);

      if (favorite == true) {
        await docRef.update({
          'favorite': FieldValue.arrayRemove([userId]),
        });
      } else {
        await docRef.update({
          'favorite': FieldValue.arrayUnion([userId]),
        });
      }
    } catch (e) {
      //
    }
  }

  Future<void> userCancel({required String docId}) async {
    try {
      DocumentReference docRef = firestore.collection("booking").doc(docId);

      await docRef.update({
        "status": "cancel",
      });
    } catch (e) {
      //
    }
  }

  Future<void> makeAdmin(
      {required BuildContext context,
      required String userId,
      required bool isAdmin}) async {
    try {
      DocumentReference documentReference =
          firestore.collection('users').doc(userId);
      documentReference.set({
        'role': isAdmin ? '' : 'admin',
      }, SetOptions(merge: true));
      showDialog(
          context: context,
          builder: (context) {
            return AnimatedAlertDialog(
              title: "Admins",
              content: isAdmin
                  ? 'You have removed user as Admin'
                  : 'You have added user as Admin',
            );
          });
    } catch (e) {
      //
    }
  }

  Future<void> makeExpert(
      {required BuildContext context,
      required String userId,
      required bool isExpert}) async {
    try {
      DocumentReference documentReference =
          firestore.collection('users').doc(userId);
      documentReference.set({
        'isExpert': isExpert ? false : true,
      }, SetOptions(merge: true));
      showDialog(
          context: context,
          builder: (context) {
            return AnimatedAlertDialog(
                title: "Experts",
                content: isExpert
                    ? 'You have removed user as an Expert'
                    : 'You have added user as an Expert');
          });
    } catch (e) {
      //
    }
  }

  String dateFormat({required date}) {
    return DateFormat.yMMMEd().format(date);
  }
}
