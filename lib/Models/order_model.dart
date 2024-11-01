import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final DateTime timestamp;
  final String serviceId;
  final String status;
  ServiceModel? serviceModel;
  bool? remindMe;
  OrderModel({
    required this.timestamp,
    required this.serviceId,
    required this.status,
    required this.serviceModel,
    this.remindMe,
  });

  static Future<OrderModel> fromFirebase({
    required Map<String, dynamic> orderModel,
  }) async {
    DateTime bookingTime = DateTime(1950);
    var newTime = orderModel['timestamp'];
    if (newTime != null && newTime is Timestamp) {
      bookingTime = newTime.toDate();
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
      serviceModel = ServiceModel.fromFirebase(serviceData: serviceData);
    }
    return OrderModel(
        timestamp: bookingTime,
        serviceId: serviceId,
        status: orderModel['status'],
        serviceModel: serviceModel,
        remindMe: orderModel['remindMe']);
  }
}
