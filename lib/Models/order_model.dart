import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final DateTime timestamp;
  final String serviceId;
  final String status;
  ServiceModel? serviceModel;
  final String orderId;
  final String? time;
  final DateTime date;
  bool? remindMe;
  final String? location;
  final String? expertId;
  final String? userId;
  OrderModel(
      {required this.timestamp,
      required this.serviceId,
      required this.status,
      required this.serviceModel,
      this.remindMe,
      required this.orderId,
      required this.date,
      this.time,
      this.location,
      this.expertId,
      this.userId});

  static Future<OrderModel> fromFirebase({
    required Map<String, dynamic> orderModel,
    required String orderId,
  }) async {
    DateTime arrivalDate = DateTime(1950);
    DateTime bookingTime = DateTime(1950);
    var newTime = orderModel['timestamp'];
    if (newTime != null && newTime is Timestamp) {
      bookingTime = newTime.toDate();
    }

    var newDate = orderModel['date'];
    if (newDate != null && newDate is Timestamp) {
      arrivalDate = newDate.toDate();
    }

    String serviceId = orderModel['serviceId'];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the service document using the serviceId
    DocumentSnapshot serviceSnapshot =
        await firestore.collection('services').doc(serviceId).get();

    ServiceModel? serviceModel;
    if (serviceSnapshot.exists) {
      Map<String, dynamic> serviceData =
          serviceSnapshot.data() as Map<String, dynamic>;
      serviceModel = ServiceModel.fromFirebase(
          serviceData: serviceData, documentId: serviceSnapshot.id);
    }

    return OrderModel(
        timestamp: bookingTime,
        serviceId: serviceId,
        status: orderModel['status'],
        serviceModel: serviceModel,
        remindMe: orderModel['remindMe'],
        orderId: orderId,
        date: arrivalDate,
        time: orderModel['time'],
        location: orderModel['location'],
        expertId: orderModel['expertId'],
        userId: orderModel['userId']);
  }
}
