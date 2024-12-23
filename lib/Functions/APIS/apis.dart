import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Apis {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final user = FirebaseAuth.instance.currentUser;

  Stream<List<ServiceModel>> fetchServices() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceModel.fromFirebase(
            serviceData: doc.data() as Map<String, dynamic>,
            documentId: doc.id);
      }).toList();
    });
  }

  Stream<List<OrderModel>> fetchBooking() {
    return _firestore
        .collection('booking')
        .where('userId', isEqualTo: user?.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      List<OrderModel> orders = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Extract basic order details
        DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
        String serviceId = data['serviceId'];
        String status = data['status'];
        bool? remindMe = data['remindMe'];
        String orderId = doc.id;
        // Fetch the associated service model
        DocumentSnapshot serviceSnapshot =
            await _firestore.collection('services').doc(serviceId).get();

        ServiceModel? serviceModel;
        if (serviceSnapshot.exists) {
          Map<String, dynamic> serviceData =
              serviceSnapshot.data() as Map<String, dynamic>;
          serviceModel = ServiceModel.fromFirebase(
            serviceData: serviceData,
            documentId: serviceSnapshot.id,
          );
        }

        // Add OrderModel with populated serviceModel to the list
        orders.add(OrderModel(
            timestamp: timestamp,
            serviceId: serviceId,
            status: status,
            serviceModel: serviceModel,
            remindMe: remindMe,
            orderId: orderId));
      }
      return orders;
    });
  }

  Future<dynamic> bookNow(String documentId, String userId) {
    return _firestore.collection('booking').add({
      'serviceId': documentId,
      'userId': userId,
      'timestamp': Timestamp.now(),
      'status': 'upcoming',
      'remindMe': false,
    });
  }

  String GetDateString(DateTime date) {
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endOfToday =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    DateTime startOfYesterday = todayStart.subtract(Duration(days: 1));
    DateTime endOfYesterday = todayStart.subtract(Duration(milliseconds: 1));
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

  Future<void> remidMe(bool value, String docId) async {
    try {
      DocumentReference docRef = _firestore.collection('booking').doc(docId);
      await docRef.update({'remindMe': !value});

      print("_________________________________");
      print("Reminder status updated to ${!value}");
    } catch (e) {
      print("_________________________________");
      print("Error updating reminder: ${e.toString()}");
      print(docId);
    }
  }

  Future<void> userFavorite(bool favorite, String docId, String userId) async {
    try {
      DocumentReference docRef = _firestore.collection('services').doc(docId);

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
      print("_________________________________");
      print("Error updating favorite: ${e.toString()}");
      print(favorite);
    }
  }

  Future<void> userCancel({required String docId}) async {
    try {
      DocumentReference docRef = _firestore.collection("booking").doc(docId);

      await docRef.update({
        "status": "cancel",
      });
    } catch (e) {
      print("Failed to cancle order ${e.toString()}");
    }
  }
}
