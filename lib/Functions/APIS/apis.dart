// ignore_for_file: unnecessary_cast
import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Constants/FirebaseConstants/firebase_collection_constant.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/snack_alert.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/controller/service_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class Apis {
  static Apis instance = Apis._constructor();
  Apis._constructor();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
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
            expertId: '',
            serviceName: '',
            serviceImage: '',
            serviceRatings: 0,
            imageId: '',
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
      otherUserId, BuildContext context) async {
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
        'expertId': otherUserId
      });

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavigator()));
        showDialog(
            context: context,
            builder: (context) {
              return AnimatedAlertDialog(
                  title: "Success",
                  icon: Icon(
                    Iconsax.tick_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  content: "You have made your booking successfully");
            });
      }
    } catch (e) {
      if (context.mounted) {
        AnimatedAlertDialog(
            title: "Error",
            icon: Icon(
              Iconsax.info_circle,
              color: Theme.of(context).primaryColor,
            ),
            content: "An error occurred while creating your booking");
      }
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
      return DateFormat("HH:mm").format(date);
    } else if (date.isAfter(startOfYesterday) &&
        date.isBefore(endOfYesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat("d/m/y").format(date);
    }
  }

  String getDatesString(DateTime date) {
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
      return "Today";
    } else if (date.isAfter(startOfYesterday) &&
        date.isBefore(endOfYesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMMd().format(date);
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

  Future<void> adminComplete(
      {required String docId, required BuildContext context}) async {
    try {
      DocumentReference docRef = firestore.collection("booking").doc(docId);

      await docRef.update({
        "status": "completed",
      });
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return const AnimatedAlertDialog(
                  title: "Success",
                  content: "Booking has been marked as completed",
                  icon: Icon(Iconsax.tick_circle));
            });
      }
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
              icon: Icon(Iconsax.tick_circle,
                  color: Theme.of(context).primaryColor),
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
                icon: Icon(Iconsax.tick_circle,
                    color: Theme.of(context).primaryColor),
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

  String dates({required date}) {
    return DateFormat.Hm().format(date);
  }

  Future<void> sendMessage(
      {required String chatId,
      required String message,
      required String userId,
      required String replyUserId,
      required String messageId,
      required String text,
      required String otherUserId}) async {
    try {
      CollectionReference collectionReference = instance.firestore
          .collection("messages")
          .doc(chatId)
          .collection('chats');

      DocumentReference chatRef = await collectionReference.add({
        "text_message": message,
        "user_id": userId,
        "replyTo": {
          "messageId": messageId,
          "text": text,
          "userId": replyUserId,
        },
        "timestamp": Timestamp.now()
      });

      DocumentReference documentReference =
          instance.firestore.collection("messages").doc(chatId);
      documentReference.set({
        "last_message_id": chatRef.id,
        "unreadCount": {
          otherUserId: FieldValue.increment(1),
        },
      }, SetOptions(merge: true));
    } catch (e) {
      //
    }
  }

  Future<void> editMessage(
      {required String message,
      required String chatId,
      required String messageId}) async {
    try {
      DocumentReference documentReference = firestore
          .collection("messages")
          .doc(chatId)
          .collection("chats")
          .doc(messageId);
      documentReference.set({"edited_message": message, "isEdited": true},
          SetOptions(merge: true));
    } catch (e) {
      //
    }
  }

  copyToClipBoard({required String text, required BuildContext context}) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      snackAlert(
        context: context,
        info: "Message copied to clipboard",
        icon: Iconsax.clipboard_text,
      ),
    );
  }

  Future<void> deleteForEveryOne(
      {required String messageId,
      required String chatId,
      required BuildContext context}) async {
    try {
      DocumentReference documentReference = firestore
          .collection("messages")
          .doc(chatId)
          .collection("chats")
          .doc(messageId);
      await documentReference.set(
        {
          "isDeleted": true,
        },
        SetOptions(merge: true),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackAlert(
          context: context,
          info: "Message has been deleted",
          icon: Iconsax.tick_circle,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackAlert(
          context: context,
          info: e.toString(),
          icon: Iconsax.close_circle,
        ));
      }
    }
  }

  Future<void> deleteForMe(
      {required String messageId,
      required String chatId,
      required String userId,
      required BuildContext context}) async {
    try {
      DocumentReference documentReference = firestore
          .collection("messages")
          .doc(chatId)
          .collection("chats")
          .doc(messageId);
      await documentReference.set(
        {
          "deleted": FieldValue.arrayUnion([userId]),
        },
        SetOptions(merge: true),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackAlert(
          context: context,
          info: "Message has been deleted",
          icon: Iconsax.tick_circle,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackAlert(
          context: context,
          info: e.toString(),
          icon: Iconsax.close_circle,
        ));
      }
    }
  }

  Future<void> favorite(
      {required bool isFavorite,
      required String messageId,
      required String chatId,
      required String userId,
      required BuildContext context}) async {
    DocumentReference documentReference = firestore
        .collection("messages")
        .doc(chatId)
        .collection("chats")
        .doc(messageId);
    await documentReference.set(
      {
        'favorite': isFavorite
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId])
      },
      SetOptions(merge: true),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackAlert(
        context: context,
        info: isFavorite
            ? "Message removed from favorite"
            : "Message added to favorite",
        icon: Iconsax.star,
      ));
    }
  }

  Future<void> editDetails({required value}) async {
    DocumentReference documentReference =
        firestore.collection("users").doc(user!.uid);

    documentReference.set({}, SetOptions(merge: true));
  }
}
